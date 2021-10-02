class BannerDetails {
  dynamic banner_id;
  dynamic banner_image;
  dynamic vendor_id;

  BannerDetails(this.banner_id, this.banner_image, this.vendor_id);

  factory BannerDetails.fromJson(dynamic json) {
    return BannerDetails(json['banner_id'], json['banner_image'], json['vendor_id']);
  }

  @override
  String toString() {
    return 'BannerDetails{banner_id: $banner_id, banner_image: $banner_image, vendor_id: $vendor_id}';
  }
}
