import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/Themes/style.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:driver/baseurl/orderbean.dart';
import 'package:driver/beanmodel/todayrestorder.dart';
import 'package:driver/parcel/parcelbean/orderdetailpageparcel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class TodayDayOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodayDayOrderState();
  }
}

class TodayDayOrderState extends State<TodayDayOrder> {
  List<OrderDetails> todayOrder = [];
  List<TodayRestaurantOrder> restOrder = [];
  List<TodayRestaurantOrder> pharmaOrder = [];
  List<TodayOrderParcel> parcelOrder = [];
  dynamic lat;
  dynamic lng;
  dynamic currency;
  bool enteredFirst = false;

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currency = prefs.getString('curency');
    });
  }

  getTodayOrders(AppLocalizations locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = ordersfortoday;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
      print('g ${value.body}');
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        if (value.body
                .toString()
                .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            todayOrder.clear();
          });
        } else {
          var jsonList = jsonData as List;
          List<OrderDetails> orderDetails =
              jsonList.map((e) => OrderDetails.fromJson(e)).toList();
          print('${orderDetails.toString()}');
          setState(() {
            todayOrder.clear();
            todayOrder = orderDetails;
          });
        }
      }
    }).catchError((e) {
      Toast.show(
        locale.noOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getTodayRestOrders(AppLocalizations locale) async {
    // var locale = AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = dboy_today_order;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
      print('resr ${value.body}');
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        print('${jsonData.toString()}');
        if (value.body
                .toString()
                .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            restOrder.clear();
          });
        } else {
          var jsonList = jsonData as List;
          List<TodayRestaurantOrder> orderDetails =
              jsonList.map((e) => TodayRestaurantOrder.fromJson(e)).toList();
          print('${orderDetails.toString()}');
          setState(() {
            restOrder.clear();
            restOrder = orderDetails;
          });
        }
      }
    }).catchError((e) {
      Toast.show(
       locale.noOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getTodayPharmaOrders(AppLocalizations locale) async {
    // var locale = AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = pharmacy_dboy_today_order;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
      print('ph ${value.body}');
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);

        if (value.body
                .toString()
                .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            pharmaOrder.clear();
          });
        } else {
          var jsonList = jsonData as List;
          List<TodayRestaurantOrder> orderDetails =
              jsonList.map((e) => TodayRestaurantOrder.fromJson(e)).toList();
          print('${orderDetails.toString()}');
          setState(() {
            pharmaOrder.clear();
            pharmaOrder = orderDetails;
          });
        }
      }
    }).catchError((e) {
      Toast.show(
        locale.noOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getTodayParcelOrders(AppLocalizations locale) async {
    // var locale = AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = parcel_dboy_today_order;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
      print('par ${value.body}');
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        if (value.body
                .toString()
                .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            parcelOrder.clear();
          });
        } else {
          var jsonList = jsonData as List;
          List<TodayOrderParcel> orderDetails =
              jsonList.map((e) => TodayOrderParcel.fromJson(e)).toList();
          print('${orderDetails.toString()}');
          setState(() {
            parcelOrder.clear();
            parcelOrder = orderDetails;
          });
        }
      }
    }).catchError((e) {
      Toast.show(
        locale.noOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getAllApi(AppLocalizations locale) async {
    getTodayOrders(locale);
    getTodayRestOrders(locale);
    getTodayParcelOrders(locale);
    getTodayPharmaOrders(locale);
  }

  void _getLocation(AppLocalizations locale) async {
    // var locale = AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool isLocationServiceEnableds = await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnableds) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((position) {
          double lat = position.latitude;
          double lng = position.longitude;
          prefs.setString("lat", lat.toStringAsFixed(8));
          prefs.setString("lng", lng.toStringAsFixed(8));
          setLocation(lat, lng);
        });
      } else {
        await Geolocator.openLocationSettings().then((value) {
          if (value) {
            _getLocation(locale);
          } else {
            Toast.show(locale.locationPermissionIsRequired, context,
                duration: Toast.LENGTH_SHORT);
          }
        }).catchError((e) {
          Toast.show(locale.locationPermissionIsRequired, context,
              duration: Toast.LENGTH_SHORT);
        });
      }
    } else if (permission == LocationPermission.denied) {
      LocationPermission permissiond = await Geolocator.requestPermission();
      if (permissiond == LocationPermission.whileInUse ||
          permissiond == LocationPermission.always) {
        _getLocation(locale);
      } else {
        Toast.show(locale.locationPermissionIsRequired, context,
            duration: Toast.LENGTH_SHORT);
      }
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings().then((value) {
        _getLocation(locale);
      }).catchError((e) {
        Toast.show(locale.locationPermissionIsRequired, context,
            duration: Toast.LENGTH_SHORT);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if(!enteredFirst){
      setState(() {
        enteredFirst = true;
      });
      getAllApi(locale);
      _getLocation(locale);
    }
    return Scaffold(
      backgroundColor: kCardBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        titleSpacing: 0.0,
        title: Text(locale.todayDayOrders,
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: ((pharmaOrder != null && pharmaOrder.length > 0) ||
              restOrder != null && restOrder.length > 0 ||
              todayOrder != null && todayOrder.length > 0 ||
              parcelOrder != null && parcelOrder.length > 0)
          ? SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: (todayOrder != null && todayOrder.length > 0)
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Text(
                          locale.groceryOrders,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6a6c74),
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: todayOrder.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('${lat} - ${lng}');
                                if (todayOrder[index].order_status == "Pending" ||
                                    todayOrder[index].order_status ==
                                        "pending" ||
                                    todayOrder[index].order_status ==
                                        "Confirmed") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.newDeliveryPage,
                                      arguments: {
                                        "cart_id": todayOrder[index].cart_id,
                                        "vendorName":
                                            todayOrder[index].vendor_name,
                                        "vendorAddress":
                                            todayOrder[index].vendor_address,
                                        "vendorlat":
                                            todayOrder[index].vendor_lat,
                                        "vendorlng":
                                            todayOrder[index].vendor_lng,
                                        "vendor_phone":
                                            todayOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": todayOrder[index].user_lat,
                                        "userlng": todayOrder[index].user_lng,
                                        "userName": todayOrder[index].user_name,
                                        "userAddress":
                                            todayOrder[index].user_address,
                                        "userphone":
                                            todayOrder[index].user_phone,
                                        "itemDetails":
                                            todayOrder[index].order_details,
                                        "remprice":
                                            todayOrder[index].remaining_price,
                                        "paymentstatus":
                                            todayOrder[index].payment_status,
                                        "paymentMethod":
                                            todayOrder[index].payment_method,
                                        "ui_type": "1"
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (todayOrder[index].order_status ==
                                    "Delivery Accepted") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.acceptedPage,
                                      arguments: {
                                        "cart_id": todayOrder[index].cart_id,
                                        "vendorName":
                                            todayOrder[index].vendor_name,
                                        "vendorAddress":
                                            todayOrder[index].vendor_address,
                                        "vendorlat":
                                            todayOrder[index].vendor_lat,
                                        "vendorlng":
                                            todayOrder[index].vendor_lng,
                                        "vendor_phone":
                                            todayOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": todayOrder[index].user_lat,
                                        "userlng": todayOrder[index].user_lng,
                                        "userName": todayOrder[index].user_name,
                                        "userAddress":
                                            todayOrder[index].user_address,
                                        "userphone":
                                            todayOrder[index].user_phone,
                                        "itemDetails":
                                            todayOrder[index].order_details,
                                        "remprice":
                                            todayOrder[index].remaining_price,
                                        "paymentstatus":
                                            todayOrder[index].payment_status,
                                        "paymentMethod":
                                            todayOrder[index].payment_method,
                                        "ui_type": "1"
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (todayOrder[index].order_status ==
                                    "Out For Delivery") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.onWayPage,
                                      arguments: {
                                        "cart_id": todayOrder[index].cart_id,
                                        "vendorName":
                                            todayOrder[index].vendor_name,
                                        "vendorAddress":
                                            todayOrder[index].vendor_address,
                                        "vendorlat":
                                            todayOrder[index].vendor_lat,
                                        "vendorlng":
                                            todayOrder[index].vendor_lng,
                                        "vendor_phone":
                                            todayOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": todayOrder[index].user_lat,
                                        "userlng": todayOrder[index].user_lng,
                                        "userName": todayOrder[index].user_name,
                                        "userAddress":
                                            todayOrder[index].user_address,
                                        "userphone":
                                            todayOrder[index].user_phone,
                                        "itemDetails":
                                            todayOrder[index].order_details,
                                        "remprice":
                                            todayOrder[index].remaining_price,
                                        "paymentstatus":
                                            todayOrder[index].payment_status,
                                        "paymentMethod":
                                            todayOrder[index].payment_method,
                                        "ui_type": "1"
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Card(
                                elevation: 5,
                                color: kWhiteColor,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  color: kWhiteColor,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.3),
                                            child: Image.asset(
                                              'images/vegetables_fruitsact.png',
                                              height: 42.3,
                                              width: 33.7,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(locale.orderId+""+todayOrder[index].cart_id,
                                                //'Order Id - #${todayOrder[index].cart_id}',
                                                style: orderMapAppBarTextStyle
                                                    .copyWith(
                                                        letterSpacing: 0.07),
                                              ),
                                              subtitle: Text(
                                                '${todayOrder[index].delivery_date} | ${todayOrder[index].time_slot}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        fontSize: 11.7,
                                                        letterSpacing: 0.06,
                                                        color:
                                                            Color(0xffc1c1c1)),
                                              ),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${todayOrder[index].order_status}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                color:
                                                                    kMainColor),
                                                  ),
                                                  SizedBox(height: 7.0),
                                                  Text(
                                                    '${todayOrder[index].total_items} items | $currency ${todayOrder[index].remaining_price}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                            fontSize: 11.7,
                                                            letterSpacing: 0.06,
                                                            color: Color(
                                                                0xffc1c1c1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 20),
                                        color: kCardBackgroundColor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(locale.pickupAndDestination,
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 36.0,
                                                bottom: 6.0,
                                                top: 12.0,
                                                right: 12.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'images/custom/ic_pickup_pointact.png'),
                                              size: 13.3,
                                              color: kMainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${todayOrder[index].vendor_name}\n${todayOrder[index].vendor_address}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 36.0,
                                                bottom: 12.0,
                                                top: 12.0,
                                                right: 12.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'images/custom/ic_droppointact.png'),
                                              size: 13.3,
                                              color: kMainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${todayOrder[index].user_address}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                          visible:
                                              (todayOrder[index].order_status ==
                                                      'Out for delivery')
                                                  ? true
                                                  : false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                color: kCardBackgroundColor,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                     locale.deliveryContact,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom: 6.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_name.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${todayOrder[index].user_name}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom:
                                                                        12.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_phone.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${todayOrder[index].user_phone}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _launchURL(
                                                            "tel://${todayOrder[index].user_phone}");
                                                      },
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      child: Card(
                                                        elevation: 8,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              kMainTextColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          child: Icon(
                                                            Icons.call,
                                                            color: kGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                      Visibility(
                                          visible:
                                              (todayOrder[index].order_status ==
                                                          'Out for delivery' ||
                                                      todayOrder[index]
                                                              .order_status ==
                                                          'Out For Delivery')
                                                  ? true
                                                  : false,
                                          // visible:true,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          PageRoutes
                                                              .itemDetails,
                                                          arguments: {
                                                            "cart_id":
                                                                '${todayOrder[index].cart_id}',
                                                            "itemDetails":
                                                                todayOrder[
                                                                        index]
                                                                    .order_details,
                                                            "currency": currency
                                                          });
                                                    },
                                                    child: Text(
                                                      locale.itemDetails,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      _getDirection(
                                                          'https://maps.google.com/maps?daddr=${todayOrder[index].user_lat},${todayOrder[index].user_lng}');
                                                    },
                                                    child: Text(
                                                      locale.getDirection,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 8,
                              color: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (restOrder != null && restOrder.length > 0)
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Text(
                          locale.restaurantOrders,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6a6c74),
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: restOrder.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('${lat} - ${lng}');
                                if (restOrder[index].order_status == "Pending" ||
                                    restOrder[index].order_status ==
                                        "pending" ||
                                    restOrder[index].order_status ==
                                        "Confirmed") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.newdeliveryrest,
                                      arguments: {
                                        "cart_id": restOrder[index].cart_id,
                                        "vendorName":
                                            restOrder[index].vendor_name,
                                        "vendorAddress":
                                            restOrder[index].vendor_address,
                                        "vendorlat":
                                            restOrder[index].vendor_lat,
                                        "vendorlng":
                                            restOrder[index].vendor_lng,
                                        "vendor_phone":
                                            restOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": restOrder[index].user_lat,
                                        "userlng": restOrder[index].user_lng,
                                        "userName": restOrder[index].user_name,
                                        "userAddress":
                                            restOrder[index].user_address,
                                        "userphone":
                                            restOrder[index].user_phone,
                                        "itemDetails":
                                            restOrder[index].order_details,
                                        "remprice":
                                            restOrder[index].remaining_price,
                                        "paymentstatus":
                                            restOrder[index].payment_status,
                                        "paymentMethod":
                                            restOrder[index].payment_method,
                                        "ui_type": "2",
                                        "addons": restOrder[index].addons
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (restOrder[index].order_status ==
                                    "Delivery Accepted") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.restacceptpage,
                                      arguments: {
                                        "cart_id": restOrder[index].cart_id,
                                        "vendorName":
                                            restOrder[index].vendor_name,
                                        "vendorAddress":
                                            restOrder[index].vendor_address,
                                        "vendorlat":
                                            restOrder[index].vendor_lat,
                                        "vendorlng":
                                            restOrder[index].vendor_lng,
                                        "vendor_phone":
                                            restOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": restOrder[index].user_lat,
                                        "userlng": restOrder[index].user_lng,
                                        "userName": restOrder[index].user_name,
                                        "userAddress":
                                            restOrder[index].user_address,
                                        "userphone":
                                            restOrder[index].user_phone,
                                        "itemDetails":
                                            restOrder[index].order_details,
                                        "remprice":
                                            restOrder[index].remaining_price,
                                        "paymentstatus":
                                            restOrder[index].payment_status,
                                        "paymentMethod":
                                            restOrder[index].payment_method,
                                        "ui_type": "2",
                                        "addons": restOrder[index].addons
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (restOrder[index].order_status ==
                                    "Out For Delivery") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.restonway,
                                      arguments: {
                                        "cart_id": restOrder[index].cart_id,
                                        "vendorName":
                                            restOrder[index].vendor_name,
                                        "vendorAddress":
                                            restOrder[index].vendor_address,
                                        "vendorlat":
                                            restOrder[index].vendor_lat,
                                        "vendorlng":
                                            restOrder[index].vendor_lng,
                                        "vendor_phone":
                                            restOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": restOrder[index].user_lat,
                                        "userlng": restOrder[index].user_lng,
                                        "userName": restOrder[index].user_name,
                                        "userAddress":
                                            restOrder[index].user_address,
                                        "userphone":
                                            restOrder[index].user_phone,
                                        "itemDetails":
                                            restOrder[index].order_details,
                                        "remprice":
                                            restOrder[index].remaining_price,
                                        "paymentstatus":
                                            restOrder[index].payment_status,
                                        "paymentMethod":
                                            restOrder[index].payment_method,
                                        "ui_type": "2",
                                        "addons": restOrder[index].addons
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Card(
                                elevation: 5,
                                color: kWhiteColor,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  color: kWhiteColor,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.3),
                                            child: Image.asset(
                                              'images/vegetables_fruitsact.png',
                                              height: 42.3,
                                              width: 33.7,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(locale.orderId+""+restOrder[index].cart_id,
                                                //'Order Id - #${restOrder[index].cart_id}',
                                                style: orderMapAppBarTextStyle
                                                    .copyWith(
                                                        letterSpacing: 0.07),
                                              ),
                                              subtitle: Text(
                                                '${restOrder[index].delivery_date}',
                                                // | ${restOrder[index].time_slot}
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        fontSize: 11.7,
                                                        letterSpacing: 0.06,
                                                        color:
                                                            Color(0xffc1c1c1)),
                                              ),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${restOrder[index].order_status}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                color:
                                                                    kMainColor),
                                                  ),
                                                  SizedBox(height: 7.0),
                                                  Text(
                                                    '${restOrder[index].order_details.length} items | $currency ${restOrder[index].remaining_price}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                            fontSize: 11.7,
                                                            letterSpacing: 0.06,
                                                            color: Color(
                                                                0xffc1c1c1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 20),
                                        color: kCardBackgroundColor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(locale.pickupAndDestination,
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 36.0,
                                                bottom: 6.0,
                                                top: 12.0,
                                                right: 12.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'images/custom/ic_pickup_pointact.png'),
                                              size: 13.3,
                                              color: kMainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${restOrder[index].vendor_name}\n${restOrder[index].vendor_address}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 36.0,
                                                bottom: 12.0,
                                                top: 12.0,
                                                right: 12.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'images/custom/ic_droppointact.png'),
                                              size: 13.3,
                                              color: kMainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${restOrder[index].user_address}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                          visible:
                                              (restOrder[index].order_status ==
                                                      'Out for delivery')
                                                  ? true
                                                  : false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                color: kCardBackgroundColor,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Delivery Contact',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom: 6.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_name.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${restOrder[index].user_name}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom:
                                                                        12.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_phone.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${restOrder[index].user_phone}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _launchURL(
                                                            "tel://${restOrder[index].user_phone}");
                                                      },
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      child: Card(
                                                        elevation: 8,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              kMainTextColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          child: Icon(
                                                            Icons.call,
                                                            color: kGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                      Visibility(
                                          visible:
                                              (restOrder[index].order_status ==
                                                          'Out for delivery' ||
                                                      restOrder[index]
                                                              .order_status ==
                                                          'Out For Delivery')
                                                  ? true
                                                  : false,
                                          // visible:true,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      Navigator.pushNamed(context,
                                                          PageRoutes.itemDetailsPh,
                                                          arguments: {
                                                            "cart_id": '${restOrder[index].cart_id}',
                                                            "itemDetails": restOrder[index].order_details,
                                                            "currency": currency,
                                                            'addons':restOrder[index].addons,
                                                            "itemDetails":
                                                            restOrder[index].order_details,
                                                            "remprice": restOrder[index].remaining_price,
                                                            "paymentstatus":
                                                            restOrder[index].payment_status,
                                                            "paymentMethod":
                                                            restOrder[index].payment_method,
                                                          });
                                                    },
                                                    child: Text(
                                                      locale.itemDetails,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      _getDirection(
                                                          'https://maps.google.com/maps?daddr=${restOrder[index].user_lat},${restOrder[index].user_lng}');
                                                    },
                                                    child: Text(
                                                      locale.getDirection,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 8,
                              color: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (pharmaOrder != null && pharmaOrder.length > 0)
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Text(
                          locale.pharmacyOrders,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6a6c74),
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: pharmaOrder.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('${lat} - ${lng}');
                                if (pharmaOrder[index].order_status == "Pending" ||
                                    pharmaOrder[index].order_status ==
                                        "pending" ||
                                    pharmaOrder[index].order_status ==
                                        "Confirmed") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.newdeliverypharma,
                                      arguments: {
                                        "cart_id": pharmaOrder[index].cart_id,
                                        "vendorName":
                                            pharmaOrder[index].vendor_name,
                                        "vendorAddress":
                                            pharmaOrder[index].vendor_address,
                                        "vendorlat":
                                            pharmaOrder[index].vendor_lat,
                                        "vendorlng":
                                            pharmaOrder[index].vendor_lng,
                                        "vendor_phone":
                                            pharmaOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": pharmaOrder[index].user_lat,
                                        "userlng": pharmaOrder[index].user_lng,
                                        "userName":
                                            pharmaOrder[index].user_name,
                                        "userAddress":
                                            pharmaOrder[index].user_address,
                                        "userphone":
                                            pharmaOrder[index].user_phone,
                                        "itemDetails":
                                            pharmaOrder[index].order_details,
                                        "remprice":
                                            pharmaOrder[index].remaining_price,
                                        "paymentstatus":
                                            pharmaOrder[index].payment_status,
                                        "paymentMethod":
                                            pharmaOrder[index].payment_method,
                                        "ui_type": "2",
                                        "addons": pharmaOrder[index].addons
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (pharmaOrder[index].order_status ==
                                    "Delivery Accepted") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.pharmaacceptpage,
                                      arguments: {
                                        "cart_id": pharmaOrder[index].cart_id,
                                        "vendorName":
                                            pharmaOrder[index].vendor_name,
                                        "vendorAddress":
                                            pharmaOrder[index].vendor_address,
                                        "vendorlat":
                                            pharmaOrder[index].vendor_lat,
                                        "vendorlng":
                                            pharmaOrder[index].vendor_lng,
                                        "vendor_phone":
                                            pharmaOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": pharmaOrder[index].user_lat,
                                        "userlng": pharmaOrder[index].user_lng,
                                        "userName":
                                            pharmaOrder[index].user_name,
                                        "userAddress":
                                            pharmaOrder[index].user_address,
                                        "userphone":
                                            pharmaOrder[index].user_phone,
                                        "itemDetails":
                                            pharmaOrder[index].order_details,
                                        "remprice":
                                            pharmaOrder[index].remaining_price,
                                        "paymentstatus":
                                            pharmaOrder[index].payment_status,
                                        "paymentMethod":
                                            pharmaOrder[index].payment_method,
                                        "ui_type": "3",
                                        "addons": pharmaOrder[index].addons
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (pharmaOrder[index].order_status ==
                                    "Out For Delivery") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.pharmaonway,
                                      arguments: {
                                        "cart_id": pharmaOrder[index].cart_id,
                                        "vendorName":
                                            pharmaOrder[index].vendor_name,
                                        "vendorAddress":
                                            pharmaOrder[index].vendor_address,
                                        "vendorlat":
                                            pharmaOrder[index].vendor_lat,
                                        "vendorlng":
                                            pharmaOrder[index].vendor_lng,
                                        "vendor_phone":
                                            pharmaOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": pharmaOrder[index].user_lat,
                                        "userlng": pharmaOrder[index].user_lng,
                                        "userName":
                                            pharmaOrder[index].user_name,
                                        "userAddress":
                                            pharmaOrder[index].user_address,
                                        "userphone":
                                            pharmaOrder[index].user_phone,
                                        "itemDetails":
                                            pharmaOrder[index].order_details,
                                        "remprice":
                                            pharmaOrder[index].remaining_price,
                                        "paymentstatus":
                                            pharmaOrder[index].payment_status,
                                        "paymentMethod":
                                            pharmaOrder[index].payment_method,
                                        "ui_type": "3",
                                        "addons": pharmaOrder[index].addons
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Card(
                                elevation: 5,
                                color: kWhiteColor,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  color: kWhiteColor,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.3),
                                            child: Image.asset(
                                              'images/vegetables_fruitsact.png',
                                              height: 42.3,
                                              width: 33.7,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(locale.orderId+""+pharmaOrder[index].cart_id,
                                                //'Order Id - #${pharmaOrder[index].cart_id}',
                                                style: orderMapAppBarTextStyle
                                                    .copyWith(
                                                        letterSpacing: 0.07),
                                              ),
                                              subtitle: Text(
                                                '${pharmaOrder[index].delivery_date}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        fontSize: 11.7,
                                                        letterSpacing: 0.06,
                                                        color:
                                                            Color(0xffc1c1c1)),
                                              ),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${pharmaOrder[index].order_status}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                color:
                                                                    kMainColor),
                                                  ),
                                                  SizedBox(height: 7.0),
                                                  Text(
                                                    '${pharmaOrder[index].order_details.length} items | $currency ${pharmaOrder[index].remaining_price}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                            fontSize: 11.7,
                                                            letterSpacing: 0.06,
                                                            color: Color(
                                                                0xffc1c1c1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 20),
                                        color: kCardBackgroundColor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(locale.pickupAndDestination,
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 36.0,
                                                bottom: 6.0,
                                                top: 12.0,
                                                right: 12.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'images/custom/ic_pickup_pointact.png'),
                                              size: 13.3,
                                              color: kMainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${pharmaOrder[index].vendor_name}\n${pharmaOrder[index].vendor_address}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 36.0,
                                                bottom: 12.0,
                                                top: 12.0,
                                                right: 12.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'images/custom/ic_droppointact.png'),
                                              size: 13.3,
                                              color: kMainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${pharmaOrder[index].user_address}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                          visible: (pharmaOrder[index]
                                                      .order_status ==
                                                  'Out for delivery')
                                              ? true
                                              : false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                color: kCardBackgroundColor,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      locale.deliveryContact,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom: 6.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_name.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${pharmaOrder[index].user_name}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom:
                                                                        12.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_phone.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${pharmaOrder[index].user_phone}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _launchURL(
                                                            "tel://${pharmaOrder[index].user_phone}");
                                                      },
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      child: Card(
                                                        elevation: 8,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              kMainTextColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          child: Icon(
                                                            Icons.call,
                                                            color: kGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                      Visibility(
                                          visible: (pharmaOrder[index]
                                                          .order_status ==
                                                      'Out for delivery' ||
                                                  pharmaOrder[index]
                                                          .order_status ==
                                                      'Out For Delivery')
                                              ? true
                                              : false,
                                          // visible:true,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      Navigator.pushNamed(context,
                                                          PageRoutes.itemDetailsPh,
                                                          arguments: {
                                                            "cart_id": '${pharmaOrder[index].cart_id}',
                                                            "itemDetails": pharmaOrder[index].order_details,
                                                            "currency": currency,
                                                            'addons':pharmaOrder[index].addons,
                                                            "itemDetails":
                                                            pharmaOrder[index].order_details,
                                                            "remprice": pharmaOrder[index].remaining_price,
                                                            "paymentstatus":
                                                            pharmaOrder[index].payment_status,
                                                            "paymentMethod":
                                                            pharmaOrder[index].payment_method,
                                                          });
                                                    },
                                                    child: Text(
                                                      locale.itemDetails,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      _getDirection(
                                                          'https://maps.google.com/maps?daddr=${pharmaOrder[index].user_lat},${pharmaOrder[index].user_lng}');
                                                    },
                                                    child: Text(
                                                      locale.getDirection,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 8,
                              color: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (parcelOrder != null && parcelOrder.length > 0)
                        ? true
                        : false,
                    child: Column(
                      children: [
                        Text(
                          locale.parcelOrders,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6a6c74),
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: parcelOrder.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('${lat} - ${lng}');
                                if (parcelOrder[index].order_status == "Pending" ||
                                    parcelOrder[index].order_status ==
                                        "pending" ||
                                    parcelOrder[index].order_status ==
                                        "Confirmed") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.newdeliveryparcel,
                                      arguments: {
                                        "cart_id": parcelOrder[index].cart_id,
                                        "vendorName":
                                            parcelOrder[index].vendor_name,
                                        "vendorAddress":
                                            parcelOrder[index].vendor_loc,
                                        "vendorlat": parcelOrder[index].lat,
                                        "vendorlng": parcelOrder[index].lng,
                                        "vendor_phone":
                                            parcelOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": '',
                                        "userlng": '',
                                        "userName":
                                            parcelOrder[index].user_name,
                                        "userAddress":
                                            '${parcelOrder[index].source_houseno}${parcelOrder[index].source_add}${parcelOrder[index].source_landmark}${parcelOrder[index].source_city}${parcelOrder[index].source_state}(${parcelOrder[index].source_pincode})',
                                        "userphone":
                                            parcelOrder[index].user_phone,
                                        "itemDetails": parcelOrder[index],
                                        "remprice":
                                            '${(double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}') > 1) ? (double.parse('${parcelOrder[index].charges}') * double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}')) : double.parse('${parcelOrder[index].charges}')}',
                                        "paymentstatus":
                                            parcelOrder[index].payment_status,
                                        "paymentMethod":
                                            parcelOrder[index].payment_method,
                                        "ui_type": "4",
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (parcelOrder[index].order_status ==
                                    "Delivery Accepted") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.parcelacceptpage,
                                      arguments: {
                                        "cart_id": parcelOrder[index].cart_id,
                                        "vendorName":
                                            parcelOrder[index].vendor_name,
                                        "vendorAddress":
                                            parcelOrder[index].vendor_loc,
                                        "vendorlat": parcelOrder[index].lat,
                                        "vendorlng": parcelOrder[index].lng,
                                        "vendor_phone":
                                            parcelOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": '',
                                        "userlng": '',
                                        "userName":
                                            parcelOrder[index].user_name,
                                        "userAddress":
                                            '${parcelOrder[index].source_houseno}${parcelOrder[index].source_add}${parcelOrder[index].source_landmark}${parcelOrder[index].source_city}${parcelOrder[index].source_state}(${parcelOrder[index].source_pincode})',
                                        "userphone":
                                            parcelOrder[index].user_phone,
                                        "itemDetails": parcelOrder[index],
                                        "remprice":
                                            '${(double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}') > 1) ? (double.parse('${parcelOrder[index].charges}') * double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}')) : double.parse('${parcelOrder[index].charges}')}',
                                        "paymentstatus":
                                            parcelOrder[index].payment_status,
                                        "paymentMethod":
                                            parcelOrder[index].payment_method,
                                        "ui_type": "4",
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                } else if (parcelOrder[index].order_status ==
                                    "Out For Delivery") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.parcelonway,
                                      arguments: {
                                        "cart_id": parcelOrder[index].cart_id,
                                        "vendorName":
                                            parcelOrder[index].vendor_name,
                                        "vendorAddress":
                                            parcelOrder[index].vendor_loc,
                                        "vendorlat": parcelOrder[index].lat,
                                        "vendorlng": parcelOrder[index].lng,
                                        "vendor_phone":
                                            parcelOrder[index].vendor_phone,
                                        "dlat": lat,
                                        "dlng": lng,
                                        "userlat": '',
                                        "userlng": '',
                                        "userName":
                                            parcelOrder[index].user_name,
                                        "userAddress":
                                            '${parcelOrder[index].source_houseno}${parcelOrder[index].source_add}${parcelOrder[index].source_landmark}${parcelOrder[index].source_city}${parcelOrder[index].source_state}(${parcelOrder[index].source_pincode})',
                                        "userphone":
                                            parcelOrder[index].user_phone,
                                        "itemDetails": parcelOrder[index],
                                        "remprice":
                                            '${(double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}') > 1) ? (double.parse('${parcelOrder[index].charges}') * double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}')) : double.parse('${parcelOrder[index].charges}')}',
                                        "paymentstatus":
                                            parcelOrder[index].payment_status,
                                        "paymentMethod":
                                            parcelOrder[index].payment_method,
                                        "ui_type": "4",
                                      }).then((value) {
                                    getAllApi(locale);
                                  });
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Card(
                                elevation: 5,
                                color: kWhiteColor,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  color: kWhiteColor,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.3),
                                            child: Image.asset(
                                              'images/vegetables_fruitsact.png',
                                              height: 42.3,
                                              width: 33.7,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(locale.orderId+""+parcelOrder[index].cart_id,
                                                //'Order Id - #${parcelOrder[index].cart_id}',
                                                style: orderMapAppBarTextStyle
                                                    .copyWith(
                                                        letterSpacing: 0.07),
                                              ),
                                              subtitle: Text(
                                                '${parcelOrder[index].pickup_date} | ${parcelOrder[index].pickup_time}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        fontSize: 11.7,
                                                        letterSpacing: 0.06,
                                                        color:
                                                            Color(0xffc1c1c1)),
                                              ),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${parcelOrder[index].order_status}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                color:
                                                                    kMainColor),
                                                  ),
                                                  SizedBox(height: 7.0),
                                                  Text(
                                                    '1 items | $currency ${(double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}') > 1) ? (double.parse('${parcelOrder[index].charges}') * double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}')) : double.parse('${parcelOrder[index].charges}')}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                            fontSize: 11.7,
                                                            letterSpacing: 0.06,
                                                            color: Color(
                                                                0xffc1c1c1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 20),
                                        color: kCardBackgroundColor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(locale.pickupAndDestination,
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 5, bottom: 5),
                                        child: Text(locale.vendorAddress,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.06,
                                                    color: kMainColor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_city,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${parcelOrder[index].vendor_name}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.05),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    '${parcelOrder[index].vendor_loc}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        .copyWith(
                                                            fontSize: 10.0,
                                                            letterSpacing:
                                                                0.05),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fill,
                                              child: Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.phone,
                                                      color: kMainColor,
                                                      size: 15.0,
                                                    ),
                                                    onPressed: () {
                                                      _launchURL(
                                                          "tel://${parcelOrder[index].vendor_phone}");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 5, bottom: 5),
                                        child: Text(locale.pickUpAddress,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.06,
                                                    color: kMainColor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_city,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${parcelOrder[index].source_name}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.05),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    '${parcelOrder[index].source_houseno}, ${parcelOrder[index].source_add}, ${parcelOrder[index].source_city}, ${parcelOrder[index].source_state}(${parcelOrder[index].source_pincode})\nLandmark :- ${parcelOrder[index].source_landmark}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        .copyWith(
                                                            fontSize: 10.5,
                                                            letterSpacing:
                                                                0.05),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fill,
                                              child: Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.phone,
                                                      color: kMainColor,
                                                      size: 15.0,
                                                    ),
                                                    onPressed: () {
                                                      _launchURL(
                                                          "tel://${parcelOrder[index].source_phone}");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 5, bottom: 5),
                                        child: Text(locale.destinationAddress,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.06,
                                                    color: kMainColor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 20),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_city,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${parcelOrder[index].destination_name}',
                                                    style:
                                                        orderMapAppBarTextStyle
                                                            .copyWith(
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.05),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    '${parcelOrder[index].destination_houseno}, ${parcelOrder[index].destination_add}, ${parcelOrder[index].destination_city}, ${parcelOrder[index].destination_state}(${parcelOrder[index].destination_pincode})\nLandmark :- ${parcelOrder[index].destination_landmark}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        .copyWith(
                                                            fontSize: 10.5,
                                                            letterSpacing:
                                                                0.05),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fill,
                                              child: Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.phone,
                                                      color: kMainColor,
                                                      size: 15.0,
                                                    ),
                                                    onPressed: () {
                                                      _launchURL(
                                                          "tel://${parcelOrder[index].destination_phone}");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Visibility(
                                          visible: (parcelOrder[index]
                                                          .order_status ==
                                                      'Out for delivery' ||
                                                  parcelOrder[index]
                                                          .order_status ==
                                                      'Out For Delivery')
                                              ? true
                                              : false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                color: kCardBackgroundColor,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      locale.deliveryContact,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom: 6.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_name.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${parcelOrder[index].destination_name}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 36.0,
                                                                    bottom:
                                                                        12.0,
                                                                    top: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  'images/icons/ic_phone.png'),
                                                              size: 13.3,
                                                              color: kMainColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${parcelOrder[index].destination_phone}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                .copyWith(
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.05),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _launchURL(
                                                            "tel://${parcelOrder[index].user_phone}");
                                                      },
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      child: Card(
                                                        elevation: 8,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              kMainTextColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          child: Icon(
                                                            Icons.call,
                                                            color: kGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                      Visibility(
                                          visible: (parcelOrder[index]
                                                          .order_status ==
                                                      'Out for delivery' ||
                                                  parcelOrder[index]
                                                          .order_status ==
                                                      'Out For Delivery')
                                              ? true
                                              : false,
                                          // visible:true,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          PageRoutes
                                                              .itemDetailsparcel,
                                                          arguments: {
                                                            "cart_id":
                                                                '${parcelOrder[index].cart_id}',
                                                            "itemDetails":
                                                                parcelOrder[
                                                                    index],
                                                            "currency": currency
                                                          });
                                                    },
                                                    child: Text(
                                                      locale.itemDetails,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 15),
                                                    onPressed: () {
                                                      _getDirection(
                                                          'https://maps.google.com/maps?daddr=${parcelOrder[index].destination_lat},${parcelOrder[index].destination_lng}');
                                                    },
                                                    child: Text(
                                                      locale.getDirection,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 8,
                              color: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Text(locale.noOrderFound),
            ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setLocation(double lats, double lngs) async {
    setState(() {
      lat = lats;
      lng = lngs;
    });
  }

  _getDirection(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
