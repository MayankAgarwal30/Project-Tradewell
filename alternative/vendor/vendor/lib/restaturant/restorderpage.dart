import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/baseurl/baseurl.dart';
import 'package:vendor/orderbean/restaurantbean/todayorderrest.dart';
import 'package:vendor/orderbean/todayorderbean.dart';

class OrderPageRest extends StatefulWidget {
  @override
  _OrderPageRestState createState() => _OrderPageRestState();
}

class _OrderPageRestState extends State<OrderPageRest>
    with SingleTickerProviderStateMixin {
  // final List<Tab> tabs = <Tab>[
  //   Tab(text: 'NEW ORDERS'),
  //   Tab(text: 'NEXTDAY ORDERS'),
  // ];
  // TabController tabController;
  List<TodayOrderRestaurant> orederList = [];

  bool isFetch = true;
  bool isRun = false;

  dynamic curency;

  dynamic status = 0;
  Timer timer;
  SharedPreferences preferences;

  @override
  void initState() {
    getSharedPref();
    super.initState();
    hitStatusServiced();
    getTodayOrders();
    setTimerTask();
  }

  void setTimerTask() async {
    Timer.periodic(Duration(minutes: 3), (timer) {
      if (this.timer == null) {
        this.timer = timer;
      }
      getTodayOrders();
    });
  }

  void hitStatusServiced() async {
    setState(() {
      isRun = true;
    });
    preferences = await SharedPreferences.getInstance();
    var vendorId = preferences.getInt('vendor_id');
    print('${status} - ${vendorId}');
    var client = http.Client();
    var statusUrl = store_current_status;
    client.post(statusUrl, body: {'vendor_id': '${vendorId}'}).then((value) {
      setState(() {
        isRun = false;
      });
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        print('${jsonData.toString()}');
        if (jsonData['status'] == 1) {
          var sats = jsonData['data'][0];
          print('----  --${sats.toString()}');
          var sat = sats['online_status'];
          print('${sat}');
          if (sat == "on" || sat == "On" || sat == "ON") {
            preferences.setInt('duty', 1);
            setState(() {
              status = 1;
            });
          } else if (sat == "off" || sat == "Off" || sat == "OFF") {
            preferences.setInt('duty', 0);
            setState(() {
              status = 0;
            });
          }
        }
        Toast.show(jsonData['message'], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isRun = false;
      });
    });
  }

  void getSharedPref() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('duty')) {
      setState(() {
        print('${preferences.getInt('duty')}');
        setState(() {
          status = preferences.getInt('duty');
          // onOffLine = 'GO OFFLINE';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: false,
          title: Text(
            locale.myorder,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            isRun
                ? CupertinoActivityIndicator(
                    radius: 15,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: (status == 1) ? kRed : kGreen)),
                color: (status == 1) ? kRed : kGreen,
                onPressed: () {
                  // Navigator.popAndPushNamed(context, PageRoutes.offlinePage)
                  if (!isRun) {
                    hitStatusService();
                  }
                },
                child: Text(
                  '${status == 1 ? locale.GoOffline : locale.GoOnline}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.7,
                      letterSpacing: 0.06),
                ),
              ),
            ),
          ],
        ),
      ),
      body: (orederList != null && orederList.length > 0)
          ? ListView.builder(
              itemCount: orederList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (orederList[index].payment_method == null ||
                              orederList[index].payment_status == null ||
                              orederList[index].order_status == "Cancel" ||
                              orederList[index].order_status == "Cancelled") {
                            print(
                                '${orederList[index].payment_method} -- ${orederList[index].payment_status}');
                          } else {
                            Navigator.pushNamed(
                                context, PageRoutes.orderInfoPageRest,
                                arguments: {
                                  'orderdetails': orederList[index],
                                  'curency': curency,
                                }).then((value) {
                              // print('${tabController.index}');
                              getTodayOrders();
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: ListTile(
                            leading: Image.asset(
                              'images/user.png',
                              scale: 2.5,
                              width: 33.7,
                              height: 42.3,
                            ),
                            title: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: '${orederList[index].user_name}\n\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                          fontSize: 13.3, letterSpacing: 0.07),
                                ),
                                TextSpan(
                                  text:
                                      '${orederList[index].delivery_date} | ${orederList[index].time_slot}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 11.7,
                                          letterSpacing: 0.06,
                                          fontWeight: FontWeight.w500),
                                )
                              ]),
                            ),
                            trailing: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      '${curency} ${orederList[index].remaining_price}\n\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                          fontSize: 13.3, letterSpacing: 0.07),
                                ),
                                TextSpan(
                                  text: '${orederList[index].payment_method}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 11.7,
                                          letterSpacing: 0.06,
                                          fontWeight: FontWeight.w500),
                                )
                              ]),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Spacer(),
                            Text('${locale.myorder1} #${orederList[index].cart_id}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontSize: 11.7,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.06,
                                        color: Color(0xff393939))),
                            Spacer(),
                            Text(
                                '${(orederList[index].order_details != null && orederList[index].order_details.length > 0) ? orederList[index].order_details.length : 0} Items',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontSize: 11.7,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.06,
                                        color: Color(0xff393939))),
                            Spacer(),
                            Text('${orederList[index].order_status}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        color: Color(0xffffa025),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.7,
                                        letterSpacing: 0.06)),
                          ],
                        ),
                      ),
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 8.0,
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFetch ? CircularProgressIndicator() : Container(),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      isFetch
                          ? locale.fetchingdata
                          : locale.fetchingdata1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void hitStatusService() async {
    setState(() {
      isRun = true;
    });
    preferences = await SharedPreferences.getInstance();
    var vendorId = preferences.getInt('vendor_id');
    dynamic statuss = preferences.getInt('duty');
    int sentStatus;
    if (preferences.containsKey('duty')) {
      statuss = preferences.getInt('duty');
      if(statuss==0){
        sentStatus = 1;
      }else if(statuss==1){
        sentStatus = 0;
      }
    } else {
      statuss = status;
      if(statuss==0){
        sentStatus = 1;
      }else if(statuss==1){
        sentStatus = 0;
      }
    }
    print('${statuss} - ${status} - ${vendorId}');
    var client = http.Client();
    var statusUrl = store_status;
    client.post(statusUrl, body: {
      'vendor_id': '${vendorId}',
      'status': (sentStatus == 1) ? 'on' : 'off'
    }).then((value) {
      setState(() {
        isRun = false;
      });
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        print('${jsonData.toString()}');
        if (jsonData['status'] == "1") {
          print('----  --${jsonData['status']}');
          // var sats = jsonData['data'][0];
          // print('----  --${sats.toString()}');
          var sat = jsonData['Status'];
          print('----  --${sat}');
          if ('$sat'.toUpperCase() == 'ON') {
            preferences.setInt('duty', 1);
            setState(() {
              status = 1;
            });
          } else if ('$sat'.toUpperCase() == 'OFF') {
            preferences.setInt('duty', 0);
            setState(() {
              status = 0;
            });
          }
        } else {
          var sat = jsonData['Status'];
          print('----  --${sat}');
          if ('$sat'.toUpperCase() == 'ON') {
            preferences.setInt('duty', 1);
            setState(() {
              status = 1;
            });
          } else if ('$sat'.toUpperCase() == 'OFF') {
            preferences.setInt('duty', 0);
            setState(() {
              status = 0;
            });
          }
        }
        Toast.show(jsonData['message'], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        setState(() {
          isRun = false;
          status = preferences.getInt('duty');
        });
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isRun = false;
      });
    });
  }

  void getTodayOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      curency = pref.getString('curency');
    });
    orederList = [];
    var vendorId = pref.getInt('vendor_id');
    var client = http.Client();
    var todayOrderUrl = vendor_today_order;
    client
        .post(todayOrderUrl, body: {'vendor_id': '${vendorId}'}).then((value) {
      if (value.statusCode == 200) {
        if (value.body
                .toString()
                .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            orederList.clear();
            isFetch = false;
          });
        } else {
          var jsonData = jsonDecode(value.body) as List;
          List<TodayOrderRestaurant> oreder =
              jsonData.map((e) => TodayOrderRestaurant.fromJson(e)).toList();
          if (oreder != null && oreder.length > 0) {
            isFetch = false;
            setState(() {
              orederList = List.from(oreder);
            });
          } else {
            setState(() {
              isFetch = false;
            });
          }
        }
      } else {
        setState(() {
          isFetch = false;
        });
      }
    }).catchError((e) {
      setState(() {
        isFetch = false;
      });
      print(e);
    });
  }

  void getNextDayOrders() async {
    orederList = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    var vendorId = pref.getInt('vendor_id');
    var client = http.Client();
    var todayOrderUrl = store_next_day_order;
    client
        .post(todayOrderUrl, body: {'vendor_id': '${vendorId}'}).then((value) {
      if (value.statusCode == 200) {
        if (value.body
                .toString()
                .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            orederList.clear();
          });
        } else {
          var jsonData = jsonDecode(value.body) as List;
          List<TodayOrderDetails> oreder =
              jsonData.map((e) => TodayOrderDetails.fromJson(e)).toList();
          if (oreder != null && oreder.length > 0) {
            isFetch = false;
            setState(() {
              orederList = List.from(oreder);
            });
          } else {
            setState(() {
              isFetch = false;
            });
          }
        }
      } else {
        setState(() {
          isFetch = false;
        });
      }
    }).catchError((e) {
      setState(() {
        isFetch = false;
      });
      print(e);
    });
  }
}
