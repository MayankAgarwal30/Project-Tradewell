import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/Themes/style.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:driver/baseurl/orderbean.dart';
import 'package:driver/beanmodel/todayrestorder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class NextDayOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NextDayOrderState();
  }
}

class NextDayOrderState extends State<NextDayOrder> {
  List<OrderDetails> todayOrder = [];
  List<TodayRestaurantOrder> pharmaOrder = [];
  dynamic lat;
  dynamic lng;
  dynamic currency;
  bool enteredFirst = false;

  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currency = prefs.getString('curency');
    });
  }

  getTodayOrders(AppLocalizations locale) async {
    // var locale = AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = ordersfornextday;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
      print('G ${value.body}');
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

  getTodayPharmaOrders(AppLocalizations locale) async {
    // var locale = AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = pharmacy_dboy_nextday_order;
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

  getAllApi(AppLocalizations locale) async {
    getTodayOrders(locale);
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
      _getLocation(locale);
      getAllApi(locale);
    }
    return Scaffold(
      backgroundColor: kCardBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        titleSpacing: 0.0,
        title: Text(locale.nextDayOrders,
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: ((todayOrder != null && todayOrder.length > 0) ||
              (pharmaOrder != null && pharmaOrder.length > 0))
          ? SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
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
                                            todayOrder[index].payment_method
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
                                            todayOrder[index].payment_method
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
                                            todayOrder[index].payment_method
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
                                              title: Text(
                                                'Order Id - #${todayOrder[index].cart_id}',
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
                                                      'Item Detail\'s',
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
                                               // 'Order Id - #${pharmaOrder[index].cart_id}',
                                                style: orderMapAppBarTextStyle
                                                    .copyWith(
                                                        letterSpacing: 0.07),
                                              ),
                                              subtitle: Text(
                                                '${pharmaOrder[index].delivery_date}',
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
                                                      'Item Detail\'s',
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
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Text(locale.noOrderFound),
            ),
    );
  }

  void setLocation(double lats, double lngs) async {
    setState(() {
      lat = lats;
      lng = lngs;
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getDirection(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
