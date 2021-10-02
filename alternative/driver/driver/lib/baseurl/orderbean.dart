class OrderDetails {
  dynamic payment_method;
  dynamic payment_status;
  dynamic user_address;
  dynamic order_status;
  dynamic vendor_name;
  dynamic vendor_lat;
  dynamic vendor_lng;
  dynamic vendor_phone;
  dynamic vendor_address;
  dynamic user_lat;
  dynamic user_lng;
  dynamic dboy_lat;
  dynamic dboy_lng;
  dynamic cart_id;
  dynamic user_name;
  dynamic user_phone;
  dynamic remaining_price;
  dynamic delivery_boy_name;
  dynamic delivery_boy_phone;
  dynamic delivery_date;
  dynamic time_slot;
  dynamic total_items;
  List<OrderDeatisSub> order_details;

  OrderDetails(
      this.payment_method,
      this.payment_status,
      this.user_address,
      this.order_status,
      this.vendor_name,
      this.vendor_lat,
      this.vendor_lng,
      this.vendor_phone,
      this.vendor_address,
      this.user_lat,
      this.user_lng,
      this.dboy_lat,
      this.dboy_lng,
      this.cart_id,
      this.user_name,
      this.user_phone,
      this.remaining_price,
      this.delivery_boy_name,
      this.delivery_boy_phone,
      this.delivery_date,
      this.time_slot,
      this.total_items,
      this.order_details);

  factory OrderDetails.fromJson(dynamic json) {
    var jsonList = json['order_details'] as List;
    List<OrderDeatisSub> orderDetails = [];
    if (jsonList != null) {
      orderDetails = jsonList.map((e) => OrderDeatisSub.fromJson(e)).toList();
    }

    return OrderDetails(
        json['payment_method'],
        json['payment_status'],
        json['user_address'],
        json['order_status'],
        json['vendor_name'],
        json['vendor_lat'],
        json['vendor_lng'],
        json['vendor_phone'],
        json['vendor_address'],
        json['user_lat'],
        json['user_lng'],
        json['dboy_lat'],
        json['dboy_lng'],
        json['cart_id'],
        json['user_name'],
        json['user_phone'],
        json['remaining_price'],
        json['delivery_boy_name'],
        json['delivery_boy_phone'],
        json['delivery_date'],
        json['time_slot'],
        json['total_items'],
        orderDetails);
  }

  @override
  String toString() {
    return 'OrderDetails{payment_method: $payment_method, payment_status: $payment_status, user_address: $user_address, order_status: $order_status, vendor_name: $vendor_name, vendor_lat: $vendor_lat, vendor_lng: $vendor_lng, vendor_address: $vendor_address, user_lat: $user_lat, user_lng: $user_lng, dboy_lat: $dboy_lat, dboy_lng: $dboy_lng, cart_id: $cart_id, user_name: $user_name, user_phone: $user_phone, remaining_price: $remaining_price, delivery_boy_name: $delivery_boy_name, delivery_boy_phone: $delivery_boy_phone, delivery_date: $delivery_date, time_slot: $time_slot, total_items: $total_items, order_details: $order_details}';
  }
}

class OrderDeatisSub {
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

  OrderDeatisSub(
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

  factory OrderDeatisSub.fromJson(dynamic json) {
    return OrderDeatisSub(
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
    return 'OrderDeatisSub{product_name: $product_name, price: $price, unit: $unit, quantity: $quantity, varient_image: $varient_image, description: $description, varient_id: $varient_id, store_order_id: $store_order_id, qty: $qty, total_items: $total_items}';
  }
}
