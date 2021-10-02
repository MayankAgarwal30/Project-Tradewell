class DutyOnOff {
  dynamic status;
  dynamic message;

  DutyOnOff(this.status, this.message);

  factory DutyOnOff.fromJson(dynamic json) {
    return DutyOnOff(json['status'], json['message']);
  }

  @override
  String toString() {
    return 'DutyOnOff{status: $status, message: $message}';
  }
}
