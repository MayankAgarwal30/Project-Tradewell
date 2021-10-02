class TodayRestaurantOrder {
  dynamic payment_method;
  dynamic payment_status;
  dynamic user_address;
  dynamic order_status;
  dynamic vendor_name;
  dynamic vendor_lat;
  dynamic vendor_lng;
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
  dynamic vendor_phone;
  List<TodayRestaurantOrderDetails> order_details;
  List<AddonList> addons;

  TodayRestaurantOrder(
      this.payment_method,
      this.payment_status,
      this.user_address,
      this.order_status,
      this.vendor_name,
      this.vendor_lat,
      this.vendor_lng,
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
      this.order_details,
      this.addons);

  factory TodayRestaurantOrder.fromJson(dynamic json) {
    var jsData = json['order_details'] as List;
    List<TodayRestaurantOrderDetails> orderDetails = [];
    if (jsData != null) {
      orderDetails =
          jsData.map((e) => TodayRestaurantOrderDetails.fromJson(e)).toList();
    }

    var jaddons = json['addons'] as List;
    List<AddonList> addonList = [];
    if (jaddons != null) {
      addonList = jaddons.map((e) => AddonList.fromJson(e)).toList();
    }

    return TodayRestaurantOrder(
        json['payment_method'],
        json['payment_status'],
        json['user_address'],
        json['order_status'],
        json['vendor_name'],
        json['vendor_lat'],
        json['vendor_lng'],
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
        orderDetails,
        addonList);
  }

  @override
  String toString() {
    return '{payment_method: $payment_method, payment_status: $payment_status, user_address: $user_address, order_status: $order_status, vendor_name: $vendor_name, vendor_lat: $vendor_lat, vendor_lng: $vendor_lng, vendor_address: $vendor_address, user_lat: $user_lat, user_lng: $user_lng, dboy_lat: $dboy_lat, dboy_lng: $dboy_lng, cart_id: $cart_id, user_name: $user_name, user_phone: $user_phone, remaining_price: $remaining_price, delivery_boy_name: $delivery_boy_name, delivery_boy_phone: $delivery_boy_phone, delivery_date: $delivery_date, time_slot: $time_slot, order_details: $order_details, addons: $addons}';
  }
}

class TodayRestaurantOrderDetails {
  dynamic product_name;
  dynamic price;
  dynamic unit;
  dynamic quantity;
  dynamic product_image;
  dynamic description;

  // dynamic addon_price;
  // dynamic addon_name;
  dynamic varient_id;
  dynamic store_order_id;
  dynamic qty;

  // dynamic total_items;

  TodayRestaurantOrderDetails(
      this.product_name,
      this.price,
      this.unit,
      this.quantity,
      this.product_image,
      this.description,
      this.varient_id,
      this.store_order_id,
      this.qty);

  factory TodayRestaurantOrderDetails.fromJson(dynamic json) {
    return TodayRestaurantOrderDetails(
        json['product_name'],
        json['price'],
        json['unit'],
        json['quantity'],
        json['product_image'],
        json['description'],
        json['varient_id'],
        json['store_order_id'],
        json['qty']);
  }

  @override
  String toString() {
    return '{product_name: $product_name, price: $price, unit: $unit, quantity: $quantity, product_image: $product_image, description: $description, varient_id: $varient_id, store_order_id: $store_order_id, qty: $qty}';
  }
}

class AddonList {
  dynamic addon_id;
  dynamic addon_price;
  dynamic addon_name;
  dynamic product_name;

  AddonList(
      this.addon_id, this.addon_price, this.addon_name, this.product_name);

  factory AddonList.fromJson(dynamic json) {
    return AddonList(json['addon_id'], json['addon_price'], json['addon_name'],
        json['product_name']);
  }

  @override
  String toString() {
    return '{addon_id: $addon_id, addon_price: $addon_price, addon_name: $addon_name, product_name: $product_name}';
  }
}
