import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/Themes/style.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:driver/baseurl/orderbean.dart';
import 'package:driver/beanmodel/cashcollect.dart';
import 'package:driver/beanmodel/restaurantbeancomplete.dart';
import 'package:driver/parcel/parcelbean/orderdetailpageparcel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class InsightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.orderHistory,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w500)),
        titleSpacing: 0.0,
      ),
      body: Insight(),
    );
  }
}

class Insight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InsightState();
  }
}

class InsightState extends State<Insight> {
  List<OrderDetails> todayOrder = [];
  List<RestaurantBeanOrder> restaurantOrder = [];
  List<RestaurantBeanOrder> pharmaOrder = [];
  List<TodayOrderParcel> parcelOrder = [];
  dynamic currency;
  CashCollect cashC;

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

  getCollectCash(AppLocalizations locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var cashCollectUrl = cashcollect;
    var client = http.Client();
    client.post(cashCollectUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
      print('${value.body}');
      if (value.statusCode == 200) {
        var jsonData = jsonDecode(value.body);
        CashCollect cashCollect = CashCollect.fromJson(jsonData);
        if ('${cashCollect.status}' == '1') {
          setState(() {
            cashC = cashCollect;
          });
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  getCompleteOrders(AppLocalizations locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = completed_orders;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
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
        locale.noGroceryOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getCompleteRestOrders(AppLocalizations locale) async {
    // var locale=AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    var todayOrderUrl = dboy_completed_order;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
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
            restaurantOrder.clear();
          });
        } else {
          var jsonList = jsonData as List;
          List<RestaurantBeanOrder> orderDetails =
              jsonList.map((e) => RestaurantBeanOrder.fromJson(e)).toList();
          print('${orderDetails.toString()}');
          setState(() {
            restaurantOrder.clear();
            restaurantOrder = orderDetails;
          });
        }
      }
    }).catchError((e) {
      Toast.show(
        locale.noResturantOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getCompletePharmaOrders(AppLocalizations locale) async {
    // var locale=AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    // dynamic boyId=await CommonUtils.fetchPrefs(PrefKeys.delivery_boy_id);
    var todayOrderUrl = pharmacy_dboy_completed_order;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
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
            pharmaOrder.clear();
          });
        } else {
          var jsonList = jsonData as List;
          List<RestaurantBeanOrder> orderDetails =
              jsonList.map((e) => RestaurantBeanOrder.fromJson(e)).toList();
          print('${orderDetails.toString()}');
          setState(() {
            pharmaOrder.clear();
            pharmaOrder = orderDetails;
          });
        }
      }
    }).catchError((e) {
      Toast.show(
        locale.noPharmacyOrderFound,
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_SHORT,
      );
      print(e);
    });
  }

  getTodayParcelOrders(AppLocalizations locale) async {
    // var locale=AppLocalizations.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic boyId = prefs.getInt('delivery_boy_id');
    //  dynamic boyId=await CommonUtils.fetchPrefs(PrefKeys.delivery_boy_id);
    var todayOrderUrl = parcel_dboy_completed_order;
    var client = http.Client();
    client.post(todayOrderUrl, body: {'delivery_boy_id': '${boyId}'}).then(
        (value) {
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enteredFirst) {
      setState(() {
        enteredFirst = true;
      });
      getCollectCash(locale);
      getCompleteOrders(locale);
      getCompleteRestOrders(locale);
      getCompletePharmaOrders(locale);
      getTodayParcelOrders(locale);
    }

    return Column(
      children: [
        Divider(
          color: kCardBackgroundColor,
          thickness: 8.0,
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${(cashC != null && cashC.data.count != null) ? cashC.data.count : 0}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    locale.orders,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w500, color: Color(0xff6a6c74)),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '$currency ${(cashC != null && cashC.data.sum != null) ? cashC.data.sum : 0}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    locale.earnings,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w500, color: Color(0xff6a6c74)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: kCardBackgroundColor,
          thickness: 6.7,
        ),
        Expanded(
            child: ((todayOrder != null && todayOrder.length > 0) ||
                    (restaurantOrder != null && restaurantOrder.length > 0) ||
                    (pharmaOrder != null && pharmaOrder.length > 0) ||
                    (parcelOrder != null && parcelOrder.length > 0))
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      primary: true,
                      child: Column(
                        children: [
                          Visibility(
                              visible:
                                  (todayOrder != null && todayOrder.length > 0)
                                      ? true
                                      : false,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    locale.groceryOrders,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
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
                                      return Card(
                                        elevation: 5,
                                        color: kWhiteColor,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(horizontal: 10),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          color: kWhiteColor,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                        locale.orderId +
                                                            "" +
                                                            todayOrder[index]
                                                                .cart_id,
                                                        //""+'Order Id - #${todayOrder[index].cart_id}',
                                                        style:
                                                            orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        0.07),
                                                      ),
                                                      subtitle: Text(
                                                        '${todayOrder[index].delivery_date} | ${todayOrder[index].time_slot}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                fontSize: 11.7,
                                                                letterSpacing:
                                                                    0.06,
                                                                color: Color(
                                                                    0xffc1c1c1)),
                                                      ),
                                                      trailing: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            '${todayOrder[index].order_status}',
                                                            style: orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        kMainColor),
                                                          ),
                                                          SizedBox(height: 7.0),
                                                          Text(
                                                            '${todayOrder[index].total_items} items | $currency ${todayOrder[index].remaining_price}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .copyWith(
                                                                    fontSize:
                                                                        11.7,
                                                                    letterSpacing:
                                                                        0.06,
                                                                    color: Color(
                                                                        0xffc1c1c1)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Divider(
                                              //   color: kCardBackgroundColor,
                                              //   thickness: 1.0,
                                              // ),
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
                                                        locale
                                                            .pickupAndDestination,
                                                        style: TextStyle(
                                                            fontSize: 14)),
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
//                              Text(
//                                'Grocery\t',
//                                style: orderMapAppBarTextStyle.copyWith(
//                                    fontSize: 10.0, letterSpacing: 0.05),
//                              ),
                                                  Expanded(
                                                    child: Text(
                                                      '${todayOrder[index].vendor_name}\n${todayOrder[index].vendor_address}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                              fontSize: 10.0,
                                                              letterSpacing:
                                                                  0.05),
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
                                                              letterSpacing:
                                                                  0.05),
                                                    ),
                                                  ),
                                                ],
                                              ),
//                         Visibility(
//                             visible: (todayOrder[index].order_status == 'Out for delivery')?true:false,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   alignment: Alignment.centerLeft,
//                                   padding: EdgeInsets.only(left: 20),
//                                   color: kCardBackgroundColor,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: 5,),
//                                       Text('Delivery Contact',style: TextStyle(
//                                           fontSize: 14
//                                       ),),
//                                       SizedBox(height: 5,),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 36.0,
//                                                   bottom: 6.0,
//                                                   top: 12.0,
//                                                   right: 12.0),
//                                               child: ImageIcon(
//                                                 AssetImage(
//                                                     'images/icons/ic_name.png'),
//                                                 size: 13.3,
//                                                 color: kMainColor,
//                                               ),
//                                             ),
// //                              Text(
// //                                'Grocery\t',
// //                                style: orderMapAppBarTextStyle.copyWith(
// //                                    fontSize: 10.0, letterSpacing: 0.05),
// //                              ),
//                                             Text(
//                                               '${todayOrder[index].user_name}',
//                                               style: Theme
//                                                   .of(context)
//                                                   .textTheme
//                                                   .caption
//                                                   .copyWith(
//                                                   fontSize: 13.0, letterSpacing: 0.05),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 36.0,
//                                                   bottom: 12.0,
//                                                   top: 12.0,
//                                                   right: 12.0),
//                                               child: ImageIcon(
//                                                 AssetImage(
//                                                     'images/icons/ic_phone.png'),
//                                                 size: 13.3,
//                                                 color: kMainColor,
//                                               ),
//                                             ),
// //                              Text(
// //                                'Home\t',
// //                                style: orderMapAppBarTextStyle.copyWith(
// //                                    fontSize: 10.0, letterSpacing: 0.05),
// //                              ),
//                                             Text(
//                                               '${todayOrder[index].user_phone}',
//                                               style: Theme
//                                                   .of(context)
//                                                   .textTheme
//                                                   .caption
//                                                   .copyWith(
//                                                   fontSize: 13.0, letterSpacing: 0.05),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(right: 10),
//                                       child: Card(
//                                         elevation: 8,
//                                         clipBehavior: Clip.hardEdge,
//                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                                         child: CircleAvatar(
//                                           backgroundColor: kMainTextColor.withOpacity(0.2),
//                                           child: Icon(Icons.call,color: kGreen,),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             )),
                                              // Divider(
                                              //   color: kCardBackgroundColor,
                                              //   thickness: 13.3,
                                              // ),
                                              // Visibility(
                                              //     visible: (todayOrder[index].order_status == 'Out for delivery')?true:false,
                                              //     // visible:true,
                                              //     child: Column(
                                              //       children: [
                                              //         SizedBox(height: 5,),
                                              //         Row(
                                              //           mainAxisAlignment: MainAxisAlignment.center,
                                              //           children: [
                                              //             RaisedButton(
                                              //               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                              //               onPressed: (){
                                              //                 Navigator.pushNamed(context, PageRoutes.itemDetails,
                                              //                     arguments: {
                                              //                       "cart_id":'${todayOrder[index].cart_id}',
                                              //                       "itemDetails":todayOrder[index].order_details
                                              //                     });
                                              //               },
                                              //               child: Text('Item Detail\'s',textAlign: TextAlign.center,style: TextStyle(
                                              //                   fontSize: 16,
                                              //                   color: kWhiteColor,
                                              //                   fontWeight: FontWeight.w600
                                              //               ),),),
                                              //             SizedBox(width: 20,),
                                              //             RaisedButton(
                                              //               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                              //               onPressed: (){
                                              //
                                              //               },
                                              //               child: Text('Get Direction',textAlign: TextAlign.center,style: TextStyle(
                                              //                   fontSize: 16,
                                              //                   color: kWhiteColor,
                                              //                   fontWeight: FontWeight.w600
                                              //               ),),)
                                              //           ],
                                              //         ),
                                              //         SizedBox(height: 5,),
                                              //       ],
                                              //     ))
                                            ],
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
                                    height: 5,
                                  ),
                                ],
                              )),
                          Visibility(
                              visible: (restaurantOrder != null &&
                                      restaurantOrder.length > 0)
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    locale.restaurantOrders,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
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
                                    itemCount: restaurantOrder.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 5,
                                        color: kWhiteColor,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(horizontal: 10),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          color: kWhiteColor,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                        locale.orderId +
                                                            "" +
                                                            restaurantOrder[
                                                                    index]
                                                                .cart_id,
                                                        // 'Order Id - #${restaurantOrder[index].cart_id}',
                                                        style:
                                                            orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        0.07),
                                                      ),
                                                      subtitle: Text(
                                                        '${restaurantOrder[index].delivery_date} | ${restaurantOrder[index].time_slot}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                fontSize: 11.7,
                                                                letterSpacing:
                                                                    0.06,
                                                                color: Color(
                                                                    0xffc1c1c1)),
                                                      ),
                                                      trailing: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            '${restaurantOrder[index].order_status}',
                                                            style: orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        kMainColor),
                                                          ),
                                                          SizedBox(height: 7.0),
                                                          Text(
                                                            '$currency ${restaurantOrder[index].remaining_price}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .copyWith(
                                                                    fontSize:
                                                                        11.7,
                                                                    letterSpacing:
                                                                        0.06,
                                                                    color: Color(
                                                                        0xffc1c1c1)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Divider(
                                              //   color: kCardBackgroundColor,
                                              //   thickness: 1.0,
                                              // ),
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
                                                        locale
                                                            .pickupAndDestination,
                                                        style: TextStyle(
                                                            fontSize: 14)),
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
//                              Text(
//                                'Grocery\t',
//                                style: orderMapAppBarTextStyle.copyWith(
//                                    fontSize: 10.0, letterSpacing: 0.05),
//                              ),
                                                  Expanded(
                                                    child: Text(
                                                      '${restaurantOrder[index].vendor_name}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                              fontSize: 10.0,
                                                              letterSpacing:
                                                                  0.05),
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
                                                      '${restaurantOrder[index].user_address}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                              fontSize: 10.0,
                                                              letterSpacing:
                                                                  0.05),
                                                    ),
                                                  ),
                                                ],
                                              ),
//                         Visibility(
//                             visible: (todayOrder[index].order_status == 'Out for delivery')?true:false,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   alignment: Alignment.centerLeft,
//                                   padding: EdgeInsets.only(left: 20),
//                                   color: kCardBackgroundColor,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: 5,),
//                                       Text('Delivery Contact',style: TextStyle(
//                                           fontSize: 14
//                                       ),),
//                                       SizedBox(height: 5,),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 36.0,
//                                                   bottom: 6.0,
//                                                   top: 12.0,
//                                                   right: 12.0),
//                                               child: ImageIcon(
//                                                 AssetImage(
//                                                     'images/icons/ic_name.png'),
//                                                 size: 13.3,
//                                                 color: kMainColor,
//                                               ),
//                                             ),
// //                              Text(
// //                                'Grocery\t',
// //                                style: orderMapAppBarTextStyle.copyWith(
// //                                    fontSize: 10.0, letterSpacing: 0.05),
// //                              ),
//                                             Text(
//                                               '${todayOrder[index].user_name}',
//                                               style: Theme
//                                                   .of(context)
//                                                   .textTheme
//                                                   .caption
//                                                   .copyWith(
//                                                   fontSize: 13.0, letterSpacing: 0.05),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 36.0,
//                                                   bottom: 12.0,
//                                                   top: 12.0,
//                                                   right: 12.0),
//                                               child: ImageIcon(
//                                                 AssetImage(
//                                                     'images/icons/ic_phone.png'),
//                                                 size: 13.3,
//                                                 color: kMainColor,
//                                               ),
//                                             ),
// //                              Text(
// //                                'Home\t',
// //                                style: orderMapAppBarTextStyle.copyWith(
// //                                    fontSize: 10.0, letterSpacing: 0.05),
// //                              ),
//                                             Text(
//                                               '${todayOrder[index].user_phone}',
//                                               style: Theme
//                                                   .of(context)
//                                                   .textTheme
//                                                   .caption
//                                                   .copyWith(
//                                                   fontSize: 13.0, letterSpacing: 0.05),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(right: 10),
//                                       child: Card(
//                                         elevation: 8,
//                                         clipBehavior: Clip.hardEdge,
//                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                                         child: CircleAvatar(
//                                           backgroundColor: kMainTextColor.withOpacity(0.2),
//                                           child: Icon(Icons.call,color: kGreen,),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             )),
                                              // Divider(
                                              //   color: kCardBackgroundColor,
                                              //   thickness: 13.3,
                                              // ),
                                              // Visibility(
                                              //     visible: (todayOrder[index].order_status == 'Out for delivery')?true:false,
                                              //     // visible:true,
                                              //     child: Column(
                                              //       children: [
                                              //         SizedBox(height: 5,),
                                              //         Row(
                                              //           mainAxisAlignment: MainAxisAlignment.center,
                                              //           children: [
                                              //             RaisedButton(
                                              //               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                              //               onPressed: (){
                                              //                 Navigator.pushNamed(context, PageRoutes.itemDetails,
                                              //                     arguments: {
                                              //                       "cart_id":'${todayOrder[index].cart_id}',
                                              //                       "itemDetails":todayOrder[index].order_details
                                              //                     });
                                              //               },
                                              //               child: Text('Item Detail\'s',textAlign: TextAlign.center,style: TextStyle(
                                              //                   fontSize: 16,
                                              //                   color: kWhiteColor,
                                              //                   fontWeight: FontWeight.w600
                                              //               ),),),
                                              //             SizedBox(width: 20,),
                                              //             RaisedButton(
                                              //               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                              //               onPressed: (){
                                              //
                                              //               },
                                              //               child: Text('Get Direction',textAlign: TextAlign.center,style: TextStyle(
                                              //                   fontSize: 16,
                                              //                   color: kWhiteColor,
                                              //                   fontWeight: FontWeight.w600
                                              //               ),),)
                                              //           ],
                                              //         ),
                                              //         SizedBox(height: 5,),
                                              //       ],
                                              //     ))
                                            ],
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
                              )),
                          Visibility(
                              visible: (pharmaOrder != null &&
                                      pharmaOrder.length > 0)
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    locale.pharmacyOrders,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
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
                                      return Card(
                                        elevation: 5,
                                        color: kWhiteColor,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(horizontal: 10),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          color: kWhiteColor,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                        locale.orderId +
                                                            "" +
                                                            pharmaOrder[index]
                                                                .cart_id,
                                                        //'Order Id - #${pharmaOrder[index].cart_id}',
                                                        style:
                                                            orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        0.07),
                                                      ),
                                                      subtitle: Text(
                                                        '${pharmaOrder[index].delivery_date} | ${pharmaOrder[index].time_slot}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                fontSize: 11.7,
                                                                letterSpacing:
                                                                    0.06,
                                                                color: Color(
                                                                    0xffc1c1c1)),
                                                      ),
                                                      trailing: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            '${pharmaOrder[index].order_status}',
                                                            style: orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        kMainColor),
                                                          ),
                                                          SizedBox(height: 7.0),
                                                          Text(
                                                            '$currency ${pharmaOrder[index].remaining_price}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .copyWith(
                                                                    fontSize:
                                                                        11.7,
                                                                    letterSpacing:
                                                                        0.06,
                                                                    color: Color(
                                                                        0xffc1c1c1)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Divider(
                                              //   color: kCardBackgroundColor,
                                              //   thickness: 1.0,
                                              // ),
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
                                                        locale
                                                            .pickupAndDestination,
                                                        style: TextStyle(
                                                            fontSize: 14)),
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
//                              Text(
//                                'Grocery\t',
//                                style: orderMapAppBarTextStyle.copyWith(
//                                    fontSize: 10.0, letterSpacing: 0.05),
//                              ),
                                                  Expanded(
                                                    child: Text(
                                                      '${pharmaOrder[index].vendor_name}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                              fontSize: 10.0,
                                                              letterSpacing:
                                                                  0.05),
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
                                                              letterSpacing:
                                                                  0.05),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                              )),
                          Visibility(
                            visible:
                                (parcelOrder != null && parcelOrder.length > 0)
                                    ? true
                                    : false,
                            child: Column(
                              children: [
                                Text(
                                  locale.parcelOrders,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
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
                                    return (parcelOrder[index].parcel_id !=
                                            null)
                                        ? Card(
                                            elevation: 5,
                                            color: kWhiteColor,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              // margin: EdgeInsets.symmetric(horizontal: 10),
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              color: kWhiteColor,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                            locale.orderId +
                                                                "" +
                                                                parcelOrder[
                                                                        index]
                                                                    .cart_id,
                                                            //'Order Id - #${parcelOrder[index].cart_id}',
                                                            style: orderMapAppBarTextStyle
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        0.07),
                                                          ),
                                                          subtitle: Text(
                                                            '${parcelOrder[index].pickup_date} | ${parcelOrder[index].pickup_time}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .copyWith(
                                                                    fontSize:
                                                                        11.7,
                                                                    letterSpacing:
                                                                        0.06,
                                                                    color: Color(
                                                                        0xffc1c1c1)),
                                                          ),
                                                          trailing: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                '${parcelOrder[index].order_status}',
                                                                style: orderMapAppBarTextStyle
                                                                    .copyWith(
                                                                        color:
                                                                            kMainColor),
                                                              ),
                                                              SizedBox(
                                                                  height: 7.0),
                                                              Text(
                                                                '1 items | $currency ${(double.parse('${parcelOrder[index].charges}') * double.parse('${double.parse('${parcelOrder[index].distance}').toStringAsFixed(2)}'))}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .copyWith(
                                                                        fontSize:
                                                                            11.7,
                                                                        letterSpacing:
                                                                            0.06,
                                                                        color: Color(
                                                                            0xffc1c1c1)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  // Divider(
                                                  //   color: kCardBackgroundColor,
                                                  //   thickness: 1.0,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    color: kCardBackgroundColor,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            locale
                                                                .pickupAndDestination,
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Text(
                                                        locale.vendorAddress,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.06,
                                                                color:
                                                                    kMainColor)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0,
                                                            left: 20),
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                '${parcelOrder[index].vendor_name}',
                                                                style: orderMapAppBarTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.05),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                '${parcelOrder[index].vendor_loc}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.05),
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
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Text(
                                                        locale.pickUpAddress,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.06,
                                                                color:
                                                                    kMainColor)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0,
                                                            left: 20),
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                '${parcelOrder[index].source_name}',
                                                                style: orderMapAppBarTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.05),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                '${parcelOrder[index].source_houseno}, ${parcelOrder[index].source_add}, ${parcelOrder[index].source_city}, ${parcelOrder[index].source_state}(${parcelOrder[index].source_pincode})\nLandmark :- ${parcelOrder[index].source_landmark}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10.5,
                                                                        letterSpacing:
                                                                            0.05),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Text(locale.destinationAddress,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.06,
                                                                color:
                                                                    kMainColor)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0,
                                                            left: 20),
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                '${parcelOrder[index].destination_name}',
                                                                style: orderMapAppBarTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.05),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                '${parcelOrder[index].destination_houseno}, ${parcelOrder[index].destination_add}, ${parcelOrder[index].destination_city}, ${parcelOrder[index].destination_state}(${parcelOrder[index].destination_pincode})\nLandmark :- ${parcelOrder[index].destination_landmark}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10.5,
                                                                        letterSpacing:
                                                                            0.05),
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
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container();
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
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text(locale.noHistoryFound),
                  ))
      ],
    );
  }
}
