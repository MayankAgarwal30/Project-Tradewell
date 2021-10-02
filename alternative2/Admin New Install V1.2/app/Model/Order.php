<?php

namespace App\Model;

use App\User;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $casts = [
        'order_amount'           => 'float',
        'checked'                => 'integer',
        'branch_id'              => 'integer',
        'time_slot_id'           => 'integer',
        'coupon_discount_amount' => 'float',
        'total_tax_amount'       => 'float',
        'delivery_address_id'    => 'integer',
        'delivery_man_id'        => 'integer',
        'delivery_charge'        => 'float',
        'user_id'                => 'integer',
        'created_at'             => 'datetime',
        'updated_at'             => 'datetime',
    ];

    public function details()
    {
        return $this->hasMany(OrderDetail::class);
    }

    public function delivery_man()
    {
        return $this->belongsTo(DeliveryMan::class, 'delivery_man_id');
    }
    public function time_slot()
    {
        return $this->belongsTo(TimeSlot::class, 'time_slot_id');
    }

    public function customer()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    public function delivery_address()
    {
        return $this->belongsTo(CustomerAddress::class, 'delivery_address_id');
    }
}
