import 'package:driver/beanmodel/todayrestorder.dart';

class RestaurantBeanOrder {
  dynamic user_address;
  dynamic order_status;
  dynamic vendor_name;
  dynamic vendor_lat;
  dynamic vendor_lng;
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
  List<TodayRestaurantOrderDetails> order_details;

  RestaurantBeanOrder(
      this.user_address,
      this.order_status,
      this.vendor_name,
      this.vendor_lat,
      this.vendor_lng,
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
      this.order_details);

  factory RestaurantBeanOrder.fromJson(dynamic json) {
    var jsData = json['order_details'] as List;
    List<TodayRestaurantOrderDetails> orderDetails = [];
    if (jsData != null && jsData.length > 2) {
      orderDetails =
          jsData.map((e) => TodayRestaurantOrderDetails.fromJson(e)).toList();
    }
    return RestaurantBeanOrder(
        json['user_address'],
        json['order_status'],
        json['vendor_name'],
        json['vendor_lat'],
        json['vendor_lng'],
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
        orderDetails);
  }

  @override
  String toString() {
    return 'RestaurantBeanOrder{user_address: $user_address, order_status: $order_status, vendor_name: $vendor_name, vendor_lat: $vendor_lat, vendor_lng: $vendor_lng, user_lat: $user_lat, user_lng: $user_lng, dboy_lat: $dboy_lat, dboy_lng: $dboy_lng, cart_id: $cart_id, user_name: $user_name, user_phone: $user_phone, remaining_price: $remaining_price, delivery_boy_name: $delivery_boy_name, delivery_boy_phone: $delivery_boy_phone, delivery_date: $delivery_date, time_slot: $time_slot, order_details: $order_details}';
  }
}

// class OrderDetailsRestaurant{
//
//
//
// }
