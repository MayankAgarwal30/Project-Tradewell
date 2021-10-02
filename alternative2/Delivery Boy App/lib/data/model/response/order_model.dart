class OrderModel {
  int _id;
  int _userId;
  double _orderAmount;
  double _couponDiscountAmount;
  String _couponDiscountTitle;
  String _paymentStatus;
  String _orderStatus;
  double _totalTaxAmount;
  String _paymentMethod;
  String _transactionReference;
  int _deliveryAddressId;
  String _createdAt;
  String _updatedAt;
  int _deliveryManId;
  double _deliveryCharge;
  String _orderNote;
  String _couponCode;
  String _orderType;
  int _branchId;
  int _timeSlotId;
  String _date;
  String _deliveryDate;
  DeliveryAddress _deliveryAddress;
  Customer _customer;

  OrderModel(
      {int id,
        int userId,
        double orderAmount,
        double couponDiscountAmount,
        String couponDiscountTitle,
        String paymentStatus,
        String orderStatus,
        double totalTaxAmount,
        String paymentMethod,
        String transactionReference,
        int deliveryAddressId,
        String createdAt,
        String updatedAt,
        int deliveryManId,
        double deliveryCharge,
        String orderNote,
        String couponCode,
        String orderType,
        int branchId,
        int timeSlotId,
        String date,
        String deliveryDate,
        DeliveryAddress deliveryAddress,
        Customer customer}) {
    this._id = id;
    this._userId = userId;
    this._orderAmount = orderAmount;
    this._couponDiscountAmount = couponDiscountAmount;
    this._couponDiscountTitle = couponDiscountTitle;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._totalTaxAmount = totalTaxAmount;
    this._paymentMethod = paymentMethod;
    this._transactionReference = transactionReference;
    this._deliveryAddressId = deliveryAddressId;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deliveryManId = deliveryManId;
    this._deliveryCharge = deliveryCharge;
    this._orderNote = orderNote;
    this._couponCode = couponCode;
    this._orderType = orderType;
    this._branchId = branchId;
    this._timeSlotId = timeSlotId;
    this._date = date;
    this._deliveryDate = deliveryDate;
    this._deliveryAddress = deliveryAddress;
    this._customer = customer;
  }

  int get id => _id;
  int get userId => _userId;
  double get orderAmount => _orderAmount;
  double get couponDiscountAmount => _couponDiscountAmount;
  String get couponDiscountTitle => _couponDiscountTitle;
  String get paymentStatus => _paymentStatus;
  // ignore: unnecessary_getters_setters
  String get orderStatus => _orderStatus;
  // ignore: unnecessary_getters_setters
  set orderStatus(String status) => _orderStatus = status;
  double get totalTaxAmount => _totalTaxAmount;
  String get paymentMethod => _paymentMethod;
  String get transactionReference => _transactionReference;
  int get deliveryAddressId => _deliveryAddressId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get deliveryManId => _deliveryManId;
  double get deliveryCharge => _deliveryCharge;
  String get orderNote => _orderNote;
  String get couponCode => _couponCode;
  String get orderType => _orderType;
  int get branchId => _branchId;
  int get timeSlotId => _timeSlotId;
  String get date => _date;
  String get deliveryDate => _deliveryDate;
  DeliveryAddress get deliveryAddress => _deliveryAddress;
  Customer get customer => _customer;

  OrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _orderAmount = json['order_amount'].toDouble();
    _couponDiscountAmount = json['coupon_discount_amount'].toDouble();
    _couponDiscountTitle = json['coupon_discount_title'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _totalTaxAmount = json['total_tax_amount'].toDouble();
    _paymentMethod = json['payment_method'];
    _transactionReference = json['transaction_reference'];
    _deliveryAddressId = json['delivery_address_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deliveryManId = json['delivery_man_id'];
    _deliveryCharge = json['delivery_charge'].toDouble();
    _orderNote = json['order_note'];
    _couponCode = json['coupon_code'];
    _orderType = json['order_type'];
    _branchId = json['branch_id'];
    _timeSlotId = json['time_slot_id'];
    _date = json['date'];
    _deliveryDate = json['delivery_date'];
    _deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    _customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['order_amount'] = this._orderAmount;
    data['coupon_discount_amount'] = this._couponDiscountAmount;
    data['coupon_discount_title'] = this._couponDiscountTitle;
    data['payment_status'] = this._paymentStatus;
    data['order_status'] = this._orderStatus;
    data['total_tax_amount'] = this._totalTaxAmount;
    data['payment_method'] = this._paymentMethod;
    data['transaction_reference'] = this._transactionReference;
    data['delivery_address_id'] = this._deliveryAddressId;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['delivery_man_id'] = this._deliveryManId;
    data['delivery_charge'] = this._deliveryCharge;
    data['order_note'] = this._orderNote;
    data['coupon_code'] = this._couponCode;
    data['order_type'] = this._orderType;
    data['branch_id'] = this._branchId;
    data['time_slot_id'] = this._timeSlotId;
    data['date'] = this._date;
    data['delivery_date'] = this._deliveryDate;
    if (this._deliveryAddress != null) {
      data['delivery_address'] = this._deliveryAddress.toJson();
    }
    if (this._customer != null) {
      data['customer'] = this._customer.toJson();
    }
    return data;
  }
}

class DeliveryAddress {
  int _id;
  String _addressType;
  String _contactPersonNumber;
  String _address;
  String _latitude;
  String _longitude;
  String _createdAt;
  String _updatedAt;
  int _userId;
  String _contactPersonName;

  DeliveryAddress(
      {int id,
        String addressType,
        String contactPersonNumber,
        String address,
        String latitude,
        String longitude,
        String createdAt,
        String updatedAt,
        int userId,
        String contactPersonName}) {
    this._id = id;
    this._addressType = addressType;
    this._contactPersonNumber = contactPersonNumber;
    this._address = address;
    this._latitude = latitude;
    this._longitude = longitude;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._userId = userId;
    this._contactPersonName = contactPersonName;
  }

  int get id => _id;
  String get addressType => _addressType;
  String get contactPersonNumber => _contactPersonNumber;
  String get address => _address;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get userId => _userId;
  String get contactPersonName => _contactPersonName;

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'];
    _contactPersonNumber = json['contact_person_number'];
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userId = json['user_id'];
    _contactPersonName = json['contact_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['address_type'] = this._addressType;
    data['contact_person_number'] = this._contactPersonNumber;
    data['address'] = this._address;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['user_id'] = this._userId;
    data['contact_person_name'] = this._contactPersonName;
    return data;
  }
}

class Customer {
  int _id;
  String _fName;
  String _lName;
  String _email;
  String _image;
  int _isPhoneVerified;
  Null _emailVerifiedAt;
  String _createdAt;
  String _updatedAt;
  Null _emailVerificationToken;
  String _phone;
  String _cmFirebaseToken;

  Customer(
      {int id,
        String fName,
        String lName,
        String email,
        String image,
        int isPhoneVerified,
        Null emailVerifiedAt,
        String createdAt,
        String updatedAt,
        Null emailVerificationToken,
        String phone,
        String cmFirebaseToken}) {
    this._id = id;
    this._fName = fName;
    this._lName = lName;
    this._email = email;
    this._image = image;
    this._isPhoneVerified = isPhoneVerified;
    this._emailVerifiedAt = emailVerifiedAt;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._emailVerificationToken = emailVerificationToken;
    this._phone = phone;
    this._cmFirebaseToken = cmFirebaseToken;
  }

  int get id => _id;
  String get fName => _fName;
  String get lName => _lName;
  String get email => _email;
  String get image => _image;
  int get isPhoneVerified => _isPhoneVerified;
  Null get emailVerifiedAt => _emailVerifiedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Null get emailVerificationToken => _emailVerificationToken;
  String get phone => _phone;
  String get cmFirebaseToken => _cmFirebaseToken;

  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _email = json['email'];
    _image = json['image'];
    _isPhoneVerified = json['is_phone_verified'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _emailVerificationToken = json['email_verification_token'];
    _phone = json['phone'];
    _cmFirebaseToken = json['cm_firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['email'] = this._email;
    data['image'] = this._image;
    data['is_phone_verified'] = this._isPhoneVerified;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['email_verification_token'] = this._emailVerificationToken;
    data['phone'] = this._phone;
    data['cm_firebase_token'] = this._cmFirebaseToken;
    return data;
  }
}
