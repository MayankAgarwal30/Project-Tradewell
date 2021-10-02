class CashCollect {
  dynamic status;
  dynamic message;
  CashSub data;

  CashCollect(this.status, this.message, this.data);

  factory CashCollect.fromJson(dynamic json) {
    CashSub cashCollect = CashSub.fromJson(json['data']);
    return CashCollect(json['status'], json['message'], cashCollect);
  }

  @override
  String toString() {
    return 'CashCollect{status: $status, message: $message, data: $data}';
  }
}

class CashSub {
  dynamic sum;
  dynamic count;

  CashSub(this.sum, this.count);

  factory CashSub.fromJson(dynamic json) {
    return CashSub(json['sum'], json['count']);
  }
}
