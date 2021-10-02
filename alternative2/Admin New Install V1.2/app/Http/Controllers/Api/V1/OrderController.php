<?php

namespace App\Http\Controllers\Api\V1;

use App\CentralLogics\Helpers;
use App\CentralLogics\OrderLogic;
use App\Http\Controllers\Controller;
use App\Model\BusinessSetting;
use App\Model\Order;
use App\Model\OrderDetail;
use App\Model\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    public function track_order(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_id' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        return response()->json(OrderLogic::track_order($request['order_id']), 200);
    }

    public function place_order(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_amount'        => 'required',
            'delivery_address_id' => 'required',
            'order_type'          => 'required|in:self_pickup,delivery',
            'branch_id'           => 'required',
        ]);

        foreach ($request['cart'] as $c) {
            $product = Product::find($c['product_id']);
            $type = $c['variation'][0]['type'];
            foreach (json_decode($product['variations'], true) as $var) {
                if ($type == $var['type'] && $var['stock'] < $c['quantity']) {
                    $validator->getMessageBag()->add('stock', 'Stock is insufficient! available stock ' . $var['stock']);
                }
            }
        }

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        try {
            $or = [
                'id'                     => 100000 + Order::all()->count() + 1,
                'user_id'                => $request->user()->id,
                'order_amount'           => $request['order_amount'],
                'coupon_discount_amount' => $request->coupon_discount_amount,
                'coupon_discount_title'  => $request->coupon_discount_title == 0 ? null : 'coupon_discount_title',
                'payment_status'         => 'unpaid',
                'order_status'           => 'pending',
                'coupon_code'            => $request['coupon_code'],
                'payment_method'         => $request->payment_method,
                'transaction_reference'  => null,
                'order_note'             => $request['order_note'],
                'order_type'             => $request['order_type'],
                'branch_id'              => $request['branch_id'],
                'delivery_address_id'    => $request->delivery_address_id,
                'time_slot_id'           => $request->time_slot_id,
                'delivery_date'          => $request->delivery_date,

                'date'                   => date('Y-m-d'),
                'delivery_charge'        => BusinessSetting::where(['key' => 'delivery_charge'])->first()->value,
                'created_at'             => now(),
                'updated_at'             => now(),
            ];

            $o_id = DB::table('orders')->insertGetId($or);
            $o_time = $or['time_slot_id'];
            $o_delivery = $or['delivery_date'];

            foreach ($request['cart'] as $c) {
                $product = Product::find($c['product_id']);
                if (count(json_decode($product['variations'], true)) > 0) {
                    $price = Helpers::variation_price($product, json_encode($c['variation']));
                } else {
                    $price = $product['price'];
                }
                $or_d = [
                    'order_id'            => $o_id,
                    'product_id'          => $c['product_id'],
                    'time_slot_id'        => $o_time,
                    'delivery_date'       => $o_delivery,
                    'product_details'     => $product,
                    'quantity'            => $c['quantity'],
                    'price'               => $price,
                    'unit'                => $product['unit'],
                    'tax_amount'          => Helpers::tax_calculate($product, $price),
                    'discount_on_product' => Helpers::discount_calculate($product, $price),
                    'discount_type'       => 'discount_on_product',
                    'variant'             => json_encode($c['variant']),
                    'variation'           => json_encode($c['variation']),
                    'is_stock_decreased'  => 1,

                    'created_at'          => now(),
                    'updated_at'          => now(),
                ];

                $type = $c['variation'][0]['type'];
                $var_store = [];
                foreach (json_decode($product['variations'], true) as $var) {
                    if ($type == $var['type']) {
                        $var['stock'] -= $c['quantity'];
                    }
                    array_push($var_store, $var);
                }
                Product::where(['id' => $product['id']])->update([
                    'variations'  => json_encode($var_store),
                    'total_stock' => $product['total_stock'] - $c['quantity'],
                ]);

                DB::table('order_details')->insert($or_d);
            }

            $fcm_token = $request->user()->cm_firebase_token;
            $value = Helpers::order_status_update_message('pending');
            try {
                if ($value) {
                    $data = [
                        'title'       => 'Order',
                        'description' => $value,
                        'order_id'    => $o_id,
                        'image'       => '',
                    ];
                    Helpers::send_push_notif_to_device($fcm_token, $data);
                }
            } catch (\Exception $e) {
            }

            return response()->json([
                'message'  => 'Order placed successfully!',
                'order_id' => $o_id,
            ], 200);

            /*Mail::to($email)->send(new \App\Mail\OrderPlaced($o_id));*/
        } catch (\Exception $e) {
            return response()->json([$e], 403);
        }
    }

    public function get_order_list(Request $request)
    {
        $orders = Order::with(['customer', 'delivery_man.rating'])->withCount('details')->where(['user_id' => $request->user()->id])->get();
        return response()->json($orders->map(function ($data) {
            $data->details_count = (integer) $data->details_count;
            return $data;
        }), 200);
    }

    public function get_order_details(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_id' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)], 403);
        }

        $details = OrderDetail::where(['order_id' => $request['order_id']])->get();
        if ($details->count() > 0) {
            foreach ($details as $det) {
                $det['variation'] = json_decode($det['variation']);
                $det['product_details'] = Helpers::product_data_formatting(json_decode($det['product_details'], true));
            }
            return response()->json($details, 200);
        } else {
            return response()->json([
                'errors' => [
                    ['code' => 'order', 'message' => 'not found!'],
                ],
            ], 401);
        }
    }

    public function cancel_order(Request $request)
    {
        if (Order::where(['user_id' => $request->user()->id, 'id' => $request['order_id']])->first()) {

            $order = Order::with(['details'])->where(['user_id' => $request->user()->id, 'id' => $request['order_id']])->first();

            foreach ($order->details as $detail) {
                if ($detail['is_stock_decreased'] == 1) {
                    $product = Product::find($detail['product_id']);
                    $type = json_decode($detail['variation'])[0]->type;
                    $var_store = [];
                    foreach (json_decode($product['variations'], true) as $var) {
                        if ($type == $var['type']) {
                            $var['stock'] += $detail['quantity'];
                        }
                        array_push($var_store, $var);
                    }
                    Product::where(['id' => $product['id']])->update([
                        'variations'  => json_encode($var_store),
                        'total_stock' => $product['total_stock'] + $detail['quantity'],
                    ]);
                    OrderDetail::where(['id' => $detail['id']])->update([
                        'is_stock_decreased' => 0,
                    ]);
                }
            }
            Order::where(['user_id' => $request->user()->id, 'id' => $request['order_id']])->update([
                'order_status' => 'canceled',
            ]);
            return response()->json(['message' => 'Order canceled'], 200);
        }
        return response()->json([
            'errors' => [
                ['code' => 'order', 'message' => 'not found!'],
            ],
        ], 401);
    }

    public function update_payment_method(Request $request)
    {
        if (Order::where(['user_id' => $request->user()->id, 'id' => $request['order_id']])->first()) {
            Order::where(['user_id' => $request->user()->id, 'id' => $request['order_id']])->update([
                'payment_method' => $request['payment_method'],
            ]);
            return response()->json(['message' => 'Payment method is updated.'], 200);
        }
        return response()->json([
            'errors' => [
                ['code' => 'order', 'message' => 'not found!'],
            ],
        ], 401);
    }
}
