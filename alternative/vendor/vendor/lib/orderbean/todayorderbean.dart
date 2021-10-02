class TodayOrderDetails {
  dynamic area_id;
  dynamic order_id;
  dynamic user_id;
  dynamic delivery_date;
  dynamic user_name;
  dynamic dboy_id;
  dynamic delivery_charge;
  dynamic total_price;
  dynamic total_products_mrp;
  dynamic delivery_boy_name;
  dynamic order_status;
  dynamic cart_id;
  dynamic user_number;
  dynamic address;
  dynamic time_slot;
  dynamic paid_by_wallet;
  dynamic remaining_price;
  dynamic price_without_delivery;
  dynamic coupon_discount;
  dynamic vendor_name;
  dynamic payment_method;
  dynamic payment_status;
  dynamic delivery_boy_num;
  List<OrderDetails> order_details;

  TodayOrderDetails(
      this.area_id,
      this.order_id,
      this.user_id,
      this.delivery_date,
      this.user_name,
      this.dboy_id,
      this.delivery_charge,
      this.total_price,
      this.total_products_mrp,
      this.delivery_boy_name,
      this.order_status,
      this.cart_id,
      this.user_number,
      this.address,
      this.time_slot,
      this.paid_by_wallet,
      this.remaining_price,
      this.price_without_delivery,
      this.coupon_discount,
      this.vendor_name,
      this.payment_method,
      this.payment_status,
      this.delivery_boy_num,
      this.order_details);

  factory TodayOrderDetails.fromJson(dynamic json) {
    var tagJson = json['order_details'] as List;
    List<OrderDetails> details = [];
    if (tagJson != null) {
      details = tagJson.map((e) => OrderDetails.fromJson(e)).toList();
    }
    return TodayOrderDetails(
        json['area_id'],
        json['order_id'],
        json['user_id'],
        json['delivery_date'],
        json['user_name'],
        json['dboy_id'],
        json['delivery_charge'],
        json['total_price'],
        json['total_products_mrp'],
        json['delivery_boy_name'],
        json['order_status'],
        json['cart_id'],
        json['user_number'],
        json['address'],
        json['time_slot'],
        json['paid_by_wallet'],
        json['remaining_price'],
        json['price_without_delivery'],
        json['coupon_discount'],
        json['vendor_name'],
        json['payment_method'],
        json['payment_status'],
        json['delivery_boy_num'],
        details);
  }

  @override
  String toString() {
    return 'TodayOrderDetails{area_id: $area_id, order_id: $order_id, user_id: $user_id, delivery_date: $delivery_date, user_name: $user_name, dboy_id: $dboy_id, delivery_charge: $delivery_charge, total_price: $total_price, total_products_mrp: $total_products_mrp, delivery_boy_name: $delivery_boy_name, order_status: $order_status, cart_id: $cart_id, user_number: $user_number, address: $address, time_slot: $time_slot, paid_by_wallet: $paid_by_wallet, remaining_price: $remaining_price, price_without_delivery: $price_without_delivery, coupon_discount: $coupon_discount, vendor_name: $vendor_name, payment_method: $payment_method, payment_status: $payment_status, order_details: $order_details}';
  }
}

class OrderDetails {
  dynamic product_name;
  dynamic price;
  dynamic unit;
  dynamic quantity;
  dynamic varient_image;
  dynamic description;
  dynamic varient_id;
  dynamic store_order_id;
  dynamic qty;
  dynamic total_items;

  OrderDetails(
      this.product_name,
      this.price,
      this.unit,
      this.quantity,
      this.varient_image,
      this.description,
      this.varient_id,
      this.store_order_id,
      this.qty,
      this.total_items);

  factory OrderDetails.fromJson(dynamic json) {
    return OrderDetails(
        json['product_name'],
        json['price'],
        json['unit'],
        json['quantity'],
        json['varient_image'],
        json['description'],
        json['varient_id'],
        json['store_order_id'],
        json['qty'],
        json['total_items']);
  }

  @override
  String toString() {
    return 'OrderDetails{product_name: $product_name, price: $price, unit: $unit, quantity: $quantity, varient_image: $varient_image, description: $description, varient_id: $varient_id, store_order_id: $store_order_id, qty: $qty, total_items: $total_items}';
  }
}
