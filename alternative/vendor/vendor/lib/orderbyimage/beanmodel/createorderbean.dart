class OrderImageBean {
  dynamic status;
  dynamic message;
  List<COImageDataBean> Data;

  OrderImageBean(this.status, this.message, this.Data);

  factory OrderImageBean.fromJson(dynamic js) {
    var jsData = js['Data'] as List;
    List<COImageDataBean> jData = [];
    if (jsData != null) {
      jData = jsData.map((e) => COImageDataBean.fromJson(e)).toList();
    }
    return OrderImageBean(js['status'], js['message'], jData);
  }
}

class COImageDataBean {
  dynamic ord_id;
  dynamic user_id;
  dynamic list_photo;
  dynamic store_id;
  dynamic address_id;
  dynamic delivery_date;
  dynamic processed;
  dynamic reason;
  dynamic time_slot;
  dynamic user_name;
  dynamic address;

  COImageDataBean(
      this.ord_id,
      this.user_id,
      this.list_photo,
      this.store_id,
      this.address_id,
      this.delivery_date,
      this.processed,
      this.reason,
      this.time_slot,
      this.user_name,this.address);

  factory COImageDataBean.fromJson(dynamic js) {
    return COImageDataBean(
        js['ord_id'],
        js['user_id'],
        js['list_photo'],
        js['store_id'],
        js['address_id'],
        js['delivery_date'],
        js['processed'],
        js['reason'],
        js['time_slot'],
        js['user_name'],
    js['address']);
  }

  @override
  String toString() {
    return '{ord_id: $ord_id, user_id: $user_id, list_photo: $list_photo, store_id: $store_id, address_id: $address_id, delivery_date: $delivery_date, processed: $processed, reason: $reason, time_slot: $time_slot, user_name: $user_name}';
  }
}
