class SubcategoryList {
  dynamic subcat_id;
  dynamic subcat_name;
  dynamic subcat_image;
  dynamic vendor_id;

  SubcategoryList(
      this.subcat_id, this.subcat_name, this.subcat_image, this.vendor_id);

  factory SubcategoryList.fromJson(dynamic json) {
    return SubcategoryList(json['subcat_id'], json['subcat_name'],
        json['subcat_image'], json['vendor_id']);
  }

  @override
  String toString() {
    return 'SubcategoryList{subcat_id: $subcat_id, subcat_name: $subcat_name, subcat_image: $subcat_image, vendor_id: $vendor_id}';
  }
}

class CategoryRestList {
  dynamic resturant_cat_id;
  dynamic cat_name;
  dynamic cat_image;
  dynamic vendor_id;

  CategoryRestList(
      this.resturant_cat_id, this.cat_name, this.cat_image, this.vendor_id);

  factory CategoryRestList.fromJson(dynamic json) {
    return CategoryRestList(json['resturant_cat_id'], json['cat_name'],
        json['cat_image'], json['vendor_id']);
  }

  @override
  String toString() {
    return 'SubcategoryList{subcat_id: $resturant_cat_id, subcat_name: $cat_name, subcat_image: $cat_image, vendor_id: $vendor_id}';
  }
}
