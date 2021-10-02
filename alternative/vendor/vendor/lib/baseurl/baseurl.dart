var imageBaseUrl = "https://gomarket.tecmanic.com/";
var baseUrl = imageBaseUrl+"api/";
var termcondition = Uri.parse(baseUrl + "termcondition");
var aboutus = Uri.parse(baseUrl + "aboutus");
var support = Uri.parse(baseUrl + "support");
var currency = Uri.parse(baseUrl + "currency");
var storelogin = Uri.parse(baseUrl + "storelogin");
var country_code = Uri.parse(baseUrl + "country_code");
var storeprofile_edit = Uri.parse(baseUrl + "storeprofile_edit");
var store_addnewproduct = Uri.parse(baseUrl + "store_addproductvariant");
var store_updatenewproduct = Uri.parse(baseUrl + "store_updateproductvariant");
var storeverifyphone = Uri.parse(baseUrl + "storeverifyphone");
var store_today_order = Uri.parse(baseUrl + "store_today_order");
var venodr_image_order = Uri.parse(baseUrl + "venodr_image_order");
var store_allproduct = Uri.parse(baseUrl + "store_allproduct");
var store_next_day_order = Uri.parse(baseUrl + "store_next_day_order");
var store_complete_order = Uri.parse(baseUrl + "store_complete_order");
var store_delivery_boy = Uri.parse(baseUrl + "store_delivery_boy");
var assigned_store_order = Uri.parse(baseUrl + "assigned_store_order");
var store_category = Uri.parse(baseUrl + "store_category");
var store_subcategory = Uri.parse(baseUrl + "store_subcategory");
var store_subcategoryall = Uri.parse(baseUrl + "store_subcategoryshow"); //vendor_id
var store_subcategoryproduct =
    Uri.parse(baseUrl + "store_subcategoryproduct"); //vendeo_id,subcat_id
var store_addnewvariant = Uri.parse(baseUrl + "store_addnewvariant"); //vendeo_id,subcat_id
var store_deleteproduct = Uri.parse(baseUrl + "store_deleteproduct"); //vendeo_id,subcat_id
var store_deletevariant = Uri.parse(baseUrl + "store_deletevariant"); //vendeo_id,subcat_id
var store_status = Uri.parse(baseUrl + "store_status"); //vendeo_id,subcat_id
var store_current_status = Uri.parse(baseUrl + "store_current_status"); //vendeo_id
var vendor_order_list = Uri.parse(baseUrl + "vendor_order_list"); //vendeo_id
var send_request = Uri.parse(baseUrl + "send_request"); //vendeo_id
var store_timming = Uri.parse(baseUrl + "store_timming");
var timeSlots = Uri.parse(baseUrl + "timeslot");//vendeo_id

//Restaurant Api
var vendor_today_order = Uri.parse(baseUrl + "vendor_today_order");
var resturant_category = Uri.parse(baseUrl + "resturant_category");
var resturant_product = Uri.parse(baseUrl + "resturant_product");
var resturant_complete_order = Uri.parse(baseUrl + "resturant_complete_order");
var resturant_deleteproduct = Uri.parse(baseUrl + "resturant_deleteproduct");
var resturant_deletevariant = Uri.parse(baseUrl + "resturant_deletevariant");
var resturant_updateproductvariant = Uri.parse(baseUrl + "resturant_updateproductvariant");
var resturant_addnewvariant = Uri.parse(baseUrl + "resturant_addnewvariant");
var resturant_updatevariant = Uri.parse(baseUrl + "resturant_updatevariant");
var resturant_addaddons = Uri.parse(baseUrl + "resturant_addaddons");
var resturant_deleteaddon = Uri.parse(baseUrl + "resturant_deleteaddon");
var resturant_addaddons_update = Uri.parse(baseUrl + "resturant_addaddons_update");
var resturant_addnewproduct = Uri.parse(baseUrl + "resturant_addnewproduct");
var resturant_updatenewproduct = Uri.parse(baseUrl + "resturant_updatenewproduct");

//pharmacy Api
var pharmacy_today_order = Uri.parse(baseUrl + "pharmacy_today_order");
var pharmacy_next_day_order = Uri.parse(baseUrl + "pharmacy_next_day_order");
var pharmacy_complete_order = Uri.parse(baseUrl + "pharmacy_complete_order");
var pharmacy_products = Uri.parse(baseUrl + "pharmacy_products");
var pharmacy_product = Uri.parse(baseUrl + "pharmacy_product");
var pharmacy_addnewproduct = Uri.parse(baseUrl + "pharmacy_addnewproduct");
var pharmacy_updatenewproduct = Uri.parse(baseUrl + "pharmacy_updatenewproduct");
var pharmacy_deleteproduct = Uri.parse(baseUrl + "pharmacy_deleteproduct");
var pharmacy_category = Uri.parse(baseUrl + "pharmacy_category");
var pharmacy_addnewvariant = Uri.parse(baseUrl + "pharmacy_addnewvariant");
var pharmacy_updatevariant = Uri.parse(baseUrl + "pharmacy_updatevariant");
var pharmacy_deletevariant = Uri.parse(baseUrl + "pharmacy_deletevariant");
var pharmacy_addaddons = Uri.parse(baseUrl + "pharmacy_addaddons");
var pharmacy_addaddons_update = Uri.parse(baseUrl + "pharmacy_addaddons_update");
var pharmacy_deleteaddon = Uri.parse(baseUrl + "pharmacy_deleteaddon");

//parcel Api
var parcel_city = Uri.parse(baseUrl + "parcel_city");
var parcel_listcharges = Uri.parse(baseUrl + "parcel_listcharges");
var parcel_updatecharges = Uri.parse(baseUrl + "parcel_updatecharges");
var parcel_deletecharges = Uri.parse(baseUrl + "parcel_deletecharges");
var parcel_addcharges = Uri.parse(baseUrl + "parcel_addcharges");
var parcel_today_order = Uri.parse(baseUrl + "parcel_today_order");
var parcel_next_day_order = Uri.parse(baseUrl + "parcel_next_day_order");
var parcel_store_order = Uri.parse(baseUrl + "parcel_store_order");
var parcel_complete_order = Uri.parse(baseUrl + "parcel_complete_history");

//new api
var orderGenerateByStore = Uri.parse('${baseUrl}order_generate_by_store');
var orderGenerateByPharmacy = Uri.parse('${baseUrl}order_generate_by_pharmacy');
var pharmacy_allproducts = Uri.parse('${baseUrl}pharmacy_allproducts');
var firebase = Uri.parse('${baseUrl}firebase');
var verifyotpfirebase = Uri.parse('${baseUrl}verifyotpfirebase_vendor');
var resendOtpVendor = Uri.parse('${baseUrl}resend_otp_vendor');

var appname = 'GoMarket Vendor';

dynamic APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=com.gomarketdemo.vendor&mt=8';
dynamic PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=com.gomarketdemo.vendor';
