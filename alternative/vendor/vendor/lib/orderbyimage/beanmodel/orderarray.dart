class OrderArrayGrocery{

  int qty;
  int varient_id;


  OrderArrayGrocery(this.qty, this.varient_id);

  @override
  String toString() {
    return '{\"qty\": $qty, \"variant_id\": $varient_id}';
  }
}

class OrderArrayGrocery1{

  int qty;
  int varient_id;


  OrderArrayGrocery1(this.qty, this.varient_id);

  @override
  String toString() {
    return '{\"qty\": $qty, \"varient_id\": $varient_id}';
  }
}