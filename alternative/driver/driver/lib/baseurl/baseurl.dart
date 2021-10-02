var imageBaseUrl = "https://demo.nikis.tech//";
var baseUrl = imageBaseUrl+"api/";
var driverlogin = Uri.parse(baseUrl + "driverlogin");
var delievery_boy_phone_verify = Uri.parse(baseUrl + "delievery_boy_phone_verify");
var userRegistration = Uri.parse(baseUrl + "userRegistration");
var driver_profile = Uri.parse(baseUrl + "driver_profile");
var completed_orders = Uri.parse(baseUrl + "completed_orders");
var ordersfortoday = Uri.parse(baseUrl + "ordersfortoday");
var ordersfornextday = Uri.parse(baseUrl + "ordersfornextday");
var country_code = Uri.parse(baseUrl + "country_code");
var dboy_status = Uri.parse(baseUrl + "dboy_status");
var delivery_out = Uri.parse(baseUrl + "delivery_out"); //cart_id
var delivery_accepted = Uri.parse(baseUrl + "delivery_accepted"); //cart_id,user_signature
var delivery_completed =
    Uri.parse(baseUrl + "delivery_completed"); //cart_id,user_signature
var termcondition = Uri.parse(baseUrl + "termcondition");
var aboutus = Uri.parse(baseUrl + "aboutus");
var support = Uri.parse(baseUrl + "support");
var currency = Uri.parse(baseUrl + "currency"); //cart_id,user_signature
var cashcollect = Uri.parse(baseUrl + "cashcollect"); //cart_id,user_signature
var driverstatus = Uri.parse(baseUrl + "driverstatus"); //cart_id,user_signature
var today_order_count = Uri.parse(baseUrl + "today_order_count"); //cart_id,user_signature
var delivery_accepted_by_dboy =
    Uri.parse(baseUrl + "delivery_accepted_by_dboy"); //cart_id,user_signature
var dboy_nextday_order =
    Uri.parse(baseUrl + "dboy_nextday_order"); //cart_id,user_signature
var dboy_today_order = Uri.parse(baseUrl + "dboy_today_order"); //cart_id,user_signature
var dboy_completed_order =
    Uri.parse(baseUrl + "dboy_completed_order"); //cart_id,user_signature
var resturant_delivery_out =
    Uri.parse(baseUrl + "resturant_delivery_out"); //cart_id,user_signature
var resturant_delivery_completed =
    Uri.parse(baseUrl + "resturant_delivery_completed"); //cart_id,user_signature

//pharmancy

var pharmacy_dboy_today_order = Uri.parse(baseUrl + "pharmacy_dboy_today_order");
var pharmacy_dboy_nextday_order = Uri.parse(baseUrl + "pharmacy_dboy_nextday_order");
var pharmacy_dboy_completed_order = Uri.parse(baseUrl + "pharmacy_dboy_completed_order");
var pharmacy_delivery_accepted_by_dboy =
    Uri.parse(baseUrl + "pharmacy_delivery_accepted_by_dboy");
var pharmacy_today_order_count = Uri.parse(baseUrl + "pharmacy_today_order_count");
var pharmacy_delivery_out = Uri.parse(baseUrl + "pharmacy_delivery_out"); //not completed
var pharmacy_delivery_completed =
    Uri.parse(baseUrl + "pharmacy_delivery_completed"); //not completed

//parcel api
var  parcel_dboy_today_order = Uri.parse(baseUrl + "parcel_dboy_today_order");
var parcel_dboy_completed_order = Uri.parse(baseUrl + "parcel_dboy_completed_order");
var parcel_delivery_accepted_by_dboy = Uri.parse(baseUrl + "parcel_delivery_accepted_by_dboy");
var parcel_today_order_count = Uri.parse(baseUrl + "parcel_today_order_count");
var parcel_delivery_out = Uri.parse(baseUrl + "parcel_delivery_out");
var parcel_delivery_completed = Uri.parse(baseUrl + "parcel_delivery_completed");

//new api
var firebase = Uri.parse('${baseUrl}firebase');
var verifyotpfirebase = Uri.parse('${baseUrl}verifyotpfirebase_driver');
var resendOtpDriverApi = Uri.parse('${baseUrl}resend_otp_driver');

var appname = 'GoMart Driver';
