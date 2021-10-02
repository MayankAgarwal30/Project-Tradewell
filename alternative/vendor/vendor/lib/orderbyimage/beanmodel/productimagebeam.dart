class ProductB{

  dynamic status;
  dynamic message;
  List<ProductNameList> data;

  ProductB(this.status, this.message, this.data);

  factory ProductB.fromJson(dynamic js){
    var jsData = js['data'] as List;
    List<ProductNameList> jData = [];
    if (jsData != null) {
      jData = jsData.map((e) => ProductNameList.fromJson(e)).toList();
    }
    return ProductB(js['status'], js['message'], jData);
  }

  @override
  String toString() {
    return '{status: $status, message: $message, data: $data}';
  }
}

class ProductNameList{

  dynamic product_id;
  dynamic product_name;
  dynamic product_image;
  List<PIVarient> variant;
  dynamic selectedVarient = 0;
  dynamic qnty = 0;

  ProductNameList(
      this.product_id, this.product_name, this.product_image, this.variant,this.selectedVarient,this.qnty);

  factory ProductNameList.fromJson(dynamic js){
    var jsData = js['variant'] as List;
    List<PIVarient> jData = [];
    if (jsData != null) {
      jData = jsData.map((e) => PIVarient.fromJson(e)).toList();
    }
    return ProductNameList(js['product_id'], js['product_name'], js['product_image'], jData,0,0);
  }

  @override
  String toString() {
    return '{product_id: $product_id, product_name: $product_name, product_image: $product_image, variant: $variant}';
  }
}

class PIVarient{
  dynamic varient_id;
  dynamic product_id;
  dynamic quantity;
  dynamic unit;
  dynamic price;
  dynamic description;
  dynamic varient_image;


  PIVarient(this.varient_id, this.product_id, this.quantity, this.unit,
      this.price, this.description, this.varient_image);

  factory PIVarient.fromJson(dynamic js){
    return PIVarient((js['variant_id']!=null)?js['variant_id']:js['varient_id'], js['product_id'], js['quantity'], js['unit'], js['price'], js['description'], js['varient_image']);
  }

  @override
  String toString() {
    return '{variant_id: $varient_id, product_id: $product_id, quantity: $quantity, unit: $unit, price: $price, description: $description, varient_image: $varient_image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PIVarient &&
          runtimeType == other.runtimeType &&
          '$varient_id' == '${other.varient_id}';

  @override
  int get hashCode => varient_id.hashCode;
}

class ProductCartItemV{
  dynamic productid;
  dynamic varient_id;
  dynamic productname;
  dynamic price;
  dynamic quntitiyunit;
  dynamic qnty;

  ProductCartItemV(this.productid, this.varient_id, this.productname,this.price, this.quntitiyunit,this.qnty);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCartItemV &&
          runtimeType == other.runtimeType &&
          '$varient_id' == '${other.varient_id}';

  @override
  int get hashCode => varient_id.hashCode;

  @override
  String toString() {
    return 'ProductCartItemV{productid: $productid, varient_id: $varient_id, productname: $productname, price: $price, quntitiyunit: $quntitiyunit, qnty: $qnty}';
  }
}