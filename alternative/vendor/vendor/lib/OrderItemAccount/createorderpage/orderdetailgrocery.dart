import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Components/bottom_bar.dart';
import 'package:vendor/Components/custom_appbar.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/baseurl/baseurl.dart';
import 'package:vendor/orderbyimage/beanmodel/createorderbean.dart';
import 'package:vendor/orderbyimage/beanmodel/orderarray.dart';
import 'package:vendor/orderbyimage/beanmodel/productimagebeam.dart';

class CartOrderDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartOrderDetailsState();
  }
}

class CartOrderDetailsState extends State<CartOrderDetails> {
  dynamic curency;
  COImageDataBean orderDetails;
  List<ProductCartItemV> orederImageList = [];
  var indexSelected = 0;
  int selectedQnty = 0;
  bool isFetchingTime = false;
  bool isFirstTime = true;
  DateTime firstDate;
  DateTime lastDate;
  List<DateTime> dateList = [];
  List<dynamic> radioList = [];
  String dateTimeSt = '';
  String dateSlotCustomer = '';
  String timeSlotCustomer = '';
  int idd = 0;
  int idd1 = 0;
  bool placingRequest = false;

  @override
  void initState() {
    super.initState();
    firstDate = DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    prepareData(firstDate);
    dateTimeSt =
        '${firstDate.year}-${(firstDate.month.toString().length == 1) ? '0' + firstDate.month.toString() : firstDate.month}-${firstDate.day}';
    dynamic date =
        '${firstDate.day}-${(firstDate.month.toString().length == 1) ? '0' + firstDate.month.toString() : firstDate.month}-${firstDate.year}';
    hitDateCounter(date);
  }

  void prepareData(firstDate) {

    // lastDate = toDateMonthYear(firstDate.add(Duration(days: 9)));
    lastDate = DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(firstDate.add(Duration(days: 9))));
    dateList.add(firstDate);
    for(int i=0;i<9;i++){
      dateList.add(DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(firstDate.add(Duration(days: i+1)))));
    }
    // dateList = getDateList(firstDate, lastDate);
  }

  void hitDateCounter(date) async {
    setState(() {
      isFetchingTime = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    int vendorId = pref.getInt('vendor_id');
    var url = timeSlots;
    http.post(url, body: {
      'vendor_id': '${vendorId}',
      'selected_date': '$date'
    }).then((value) {
      if (value != null && value.statusCode == 200) {
        var jsonData = jsonDecode(value.body);
        if (jsonData['status'] == "1") {
          var rdlist = jsonData['data'] as List;
          print('list $rdlist');
          setState(() {
            radioList.clear();
            radioList = rdlist;
          });
        } else {
          setState(() {
            radioList = [];
          });
          Toast.show(jsonData['message'], context,
              duration: Toast.LENGTH_SHORT);
        }
      } else {
        setState(() {
          radioList = [];
          // radioList = rdlist;
        });
      }
      setState(() {
        isFetchingTime = false;
      });
    }).catchError((e) {
      setState(() {
        isFetchingTime = false;
      });
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 7;
    final double itemWidth = size.width / 2;
    Map<String, Object> dataObject = ModalRoute.of(context).settings.arguments;
    if (isFirstTime) {
      setState(() {
        isFirstTime = false;
        orderDetails = dataObject['orderdetails'];
        orederImageList = dataObject['cartitemlist'];
        curency = dataObject['curency'];
        print(orderDetails.toString());
        dateSlotCustomer = orderDetails.delivery_date;
        timeSlotCustomer = orderDetails.time_slot;
        print(dateSlotCustomer);
        print(timeSlotCustomer);
        DateTime orderDate = DateTime.parse(orderDetails.delivery_date);
        int dateIndexOrder = dateList.indexOf(DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(orderDate)));
        if (dateIndexOrder >= 0) {
          idd = dateIndexOrder;
        } else {
          idd = -1;
        }
        int timeIndexOrder = radioList.indexOf(orderDetails.time_slot);
        if (timeIndexOrder >= 0) {
          idd1 = timeIndexOrder;
        } else {
          idd1 = -1;
        }
      });
    }
    return WillPopScope(
      onWillPop: () async {
        print('erw ${dateSlotCustomer}');
        print(timeSlotCustomer);
        setState(() {
          orderDetails.delivery_date = dateSlotCustomer;
          orderDetails.time_slot = timeSlotCustomer;
        });
        return true;
      },
      child: Scaffold(
        body: SafeArea(
            child: (placingRequest)
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : Column(
                    children: [
                      CustomAppBar(
                        leading: GestureDetector(
                          onTap: () {
                            print('erw ${dateSlotCustomer}');
                            print(timeSlotCustomer);
                            orderDetails.delivery_date = dateSlotCustomer;
                            orderDetails.time_slot = timeSlotCustomer;
                            Navigator.of(context).pop();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 25,
                            color: kMainTextColor,
                          ),
                        ),
                        titleWidget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(locale.orderdetail,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: kMainTextColor)),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: SingleChildScrollView(
                          primary: true,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: (orederImageList != null &&
                                        orederImageList.length > 0)
                                    ? ListView.builder(
                                        itemCount: orederImageList.length,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 15, right: 15, top: 10),
                                            color: kWhiteColor,
                                            child: Material(
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              clipBehavior: Clip.hardEdge,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: kWhiteColor,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                        '${orederImageList[index].productname} - ${orederImageList[index].quntitiyunit}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color:
                                                                    kMainColor)),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        25.0,
                                                                    vertical:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  kCardBackgroundColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            child: Text(
                                                                '${orederImageList[index].quntitiyunit}'),
                                                          ),
                                                        ),
                                                        Text(
                                                            '$curency ${orederImageList[index].price}'),
                                                        Container(
                                                          height: 30.0,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      11.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    kMainColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (orederImageList[index]
                                                                            .qnty >
                                                                        0) {
                                                                      orederImageList[
                                                                              index]
                                                                          .qnty = orederImageList[index]
                                                                              .qnty -
                                                                          1;
                                                                      if (orederImageList[index]
                                                                              .qnty ==
                                                                          0) {
                                                                        orederImageList
                                                                            .removeAt(index);
                                                                      }
                                                                    }
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color:
                                                                      kMainColor,
                                                                  size: 20.0,
                                                                  //size: 23.3,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 8.0),
                                                              Text(
                                                                  '${orederImageList[index].qnty}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption),
                                                              SizedBox(
                                                                  width: 8.0),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    orederImageList[
                                                                            index]
                                                                        .qnty = orederImageList[index]
                                                                            .qnty +
                                                                        1;
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      kMainColor,
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : Container(),
                              ),
                              Divider(
                                color: kCardBackgroundColor,
                                thickness: 6.7,
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                color: kCardBackgroundColor,
                                child: Text(locale.dateslot,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color: Color(0xff616161),
                                            letterSpacing: 0.67)),
                              ),
                              Divider(
                                color: kCardBackgroundColor,
                                thickness: 6.7,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(right: 5, left: 5),
                                child: ListView.builder(
                                    itemCount: dateList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      // var dateCount1 =
                                      //     '${dateList[index].day.toString()}/${(dateList[index].month.toString().length == 1) ? '0' + dateList[index].month.toString() : dateList[index].month}/${dateList[index].year}';
                                      DateFormat formatter =
                                          DateFormat('dd MMM yyyy');
                                      var dateCount =
                                          formatter.format(dateList[index]);
                                      return GestureDetector(
                                        onTap: () {
                                          if (idd >= 0) {
                                            setState(() {
                                              dateTimeSt =
                                                  '${dateList[index].year}-${(dateList[index].month.toString().length == 1) ? '0' + dateList[index].month.toString() : dateList[index].month}-${dateList[index].day}';
                                              orderDetails.delivery_date =
                                                  dateTimeSt;
                                              idd1 = -1;
                                              idd = index;
                                              dynamic date =
                                                  '${dateList[index].day}-${(dateList[index].month.toString().length == 1) ? '0' + dateList[index].month.toString() : dateList[index].month}-${dateList[index].year}';

                                              hitDateCounter(date);
                                              print('${dateTimeSt}');
                                            });
                                          } else {
                                            showAlertDialog(context, index);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10),
                                          margin: EdgeInsets.only(
                                              right: 5, left: 5),
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: (idd == index)
                                                  ? kMainColor
                                                  : kWhiteColor,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: (idd == index)
                                                      ? kMainColor
                                                      : kMainColor)),
                                          child: Text(
                                            '${dateCount}',
                                            style: TextStyle(
                                                color: (idd == index)
                                                    ? kWhiteColor
                                                    : kMainTextColor,
                                                fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: kCardBackgroundColor,
                                thickness: 6.7,
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                color: kCardBackgroundColor,
                                child: Text(locale.timeslot,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            color: Color(0xff616161),
                                            letterSpacing: 0.67)),
                              ),
                              Divider(
                                color: kCardBackgroundColor,
                                thickness: 6.7,
                              ),
                              (!isFetchingTime && radioList.length > 0)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      child: GridView.builder(
                                        itemCount: radioList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0,
                                          childAspectRatio:
                                              (itemWidth / itemHeight),
                                        ),
                                        controller: ScrollController(
                                            keepScrollOffset: false),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                idd1 = index;
                                                print('${radioList[idd1]}');
                                              });
                                            },
                                            child: SizedBox(
                                              height: 100,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    right: 5,
                                                    left: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                height: 30,
                                                width: 100,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: (idd1 == index)
                                                        ? kMainColor
                                                        : kWhiteColor,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: (idd1 == index)
                                                            ? kMainColor
                                                            : kMainColor)),
                                                child: Text(
                                                  '${radioList[index].toString()}',
                                                  style: TextStyle(
                                                      color: (idd1 == index)
                                                          ? kWhiteColor
                                                          : kMainTextColor,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          isFetchingTime
                                              ? CircularProgressIndicator()
                                              : Container(
                                                  width: 0.5,
                                                ),
                                          isFetchingTime
                                              ? SizedBox(
                                                  width: 10,
                                                )
                                              : Container(
                                                  width: 0.5,
                                                ),
                                          (isFetchingTime)
                                              ? Text(
                                            locale.timeslot1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kMainTextColor),
                                                )
                                              : Expanded(
                                                  child: Text(
                                                    locale.timeslot2,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: kMainTextColor),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                              Divider(
                                color: kCardBackgroundColor,
                                thickness: 6.7,
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 8.0, horizontal: 20.0),
                              //   child: Text(locale.payementinfo,
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .headline6
                              //           .copyWith(color: kDisabledColor)),
                              //   color: Colors.white,
                              // ),
                              // Container(
                              //   color: Colors.white,
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 4.0, horizontal: 20.0),
                              //   child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: <Widget>[
                              //         Text(
                              //           locale.subtotal,
                              //           style:
                              //               Theme.of(context).textTheme.caption,
                              //         ),
                              //         Text(
                              //           '',
                              //           style:
                              //               Theme.of(context).textTheme.caption,
                              //         ),
                              //       ]),
                              // ),
                              // Divider(
                              //   color: kCardBackgroundColor,
                              //   thickness: 1.0,
                              // ),
                              // Container(
                              //   color: Colors.white,
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 4.0, horizontal: 20.0),
                              //   child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: <Widget>[
                              //         Text(
                              //           locale.servicefee,
                              //           style:
                              //               Theme.of(context).textTheme.caption,
                              //         ),
                              //         Text(
                              //           '$curency 120',
                              //           style:
                              //               Theme.of(context).textTheme.caption,
                              //         ),
                              //       ]),
                              // ),
                              // Divider(
                              //   color: kCardBackgroundColor,
                              //   thickness: 1.0,
                              // ),
                              // Container(
                              //   color: Colors.white,
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 4.0, horizontal: 20.0),
                              //   child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: <Widget>[
                              //         Text(
                              //           locale.amountpay,
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .caption
                              //               .copyWith(
                              //                   fontWeight: FontWeight.bold),
                              //         ),
                              //         Text(
                              //           '$curency 240',
                              //           style:
                              //               Theme.of(context).textTheme.caption,
                              //         ),
                              //       ]),
                              // ),
                              // Divider(
                              //   color: kCardBackgroundColor,
                              //   thickness: 6.7,
                              // ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                color: kCardBackgroundColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(locale.deliveryadd,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                color: Color(0xff616161),
                                                letterSpacing: 0.67)),
                                  ],
                                ),
                              ),
                              Divider(
                                color: kCardBackgroundColor,
                                thickness: 6.7,
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                color: kWhiteColor,
                                child: Text(
                                    '${orderDetails.address}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            fontSize: 11.7,
                                            color: Color(0xffb7b7b7))),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      )),
                      SizedBox(
                        height: 3,
                      ),
                      BottomBar(
                          text: 'Proceed To Place Order',
                          onTap: () {
                            if (idd >= 0) {
                              setState(() {
                                placingRequest = true;
                              });
                              hitService(context);
                            } else {
                              Toast.show(
                                  locale.deliverydate1, context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.CENTER);
                            }
                          }),
                    ],
                  )),
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    var locale = AppLocalizations.of(context);
    Widget clear = GestureDetector(
      onTap: () {
        setState(() {
          dateTimeSt =
              '${dateList[index].year}-${(dateList[index].month.toString().length == 1) ? '0' + dateList[index].month.toString() : dateList[index].month}-${dateList[index].day}';
          orderDetails.delivery_date = dateTimeSt;
          idd = index;
          dynamic date =
              '${dateList[idd].day}-${(dateList[idd].month.toString().length == 1) ? '0' + dateList[idd].month.toString() : dateList[idd].month}-${dateList[idd].year}';
          hitDateCounter(date);
        });
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
      child: Material(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            locale.yes1,
            style: TextStyle(fontSize: 13, color: kWhiteColor),
          ),
        ),
      ),
    );

    Widget no = GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            locale.no1,
            style: TextStyle(fontSize: 13, color: kWhiteColor),
          ),
        ),
      ),
    );
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(locale.outdateordalert),
      content: Text('${locale.outdateordalert1} ${dateList[index].day} - ${dateList[index].month} - ${dateList[index].year} date.'),
      actions: [clear, no],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void hitService(BuildContext context) async {
    List<dynamic> orderArray = [];
    // for (ProductCartItemV item in orederImageList) {
    //   orderArray.add(OrderArrayGrocery(
    //       int.parse('${item.qnty}'), int.parse('${item.varient_id}')));
    // }
    SharedPreferences pref = await SharedPreferences.getInstance();
    var vendorId = pref.getInt('vendor_id');
    var ui_type = pref.getString('ui_type');
    var client = http.Client();
    dynamic todayOrderUrl = "";
    if(ui_type == "1"){
      todayOrderUrl = orderGenerateByStore;
      for (ProductCartItemV item in orederImageList) {
        orderArray.add(OrderArrayGrocery1(
            int.parse('${item.qnty}'), int.parse('${item.varient_id}')));
      }
    }else if(ui_type == "3"){
      todayOrderUrl = orderGenerateByPharmacy;
      for (ProductCartItemV item in orederImageList) {
        orderArray.add(OrderArrayGrocery(
            int.parse('${item.qnty}'), int.parse('${item.varient_id}')));
      }
    }
    client.post(todayOrderUrl, body: {
      'vendor_id': '${vendorId}',
      'user_id': '${orderDetails.user_id}',
      'delivery_date': '${dateList[idd]}',
      'time_slot': '${radioList[idd1]}',
      'ui_type': '${pref.getString('ui_type')}',
      'address_id': '${orderDetails.address_id}',
      'ord_id': '${orderDetails.ord_id}',
      'order_array': orderArray.toString(),
    }).then((value) {
      print('${value.body}');
      if (value.statusCode == 200 && !value.body.contains('<!DOCTYPE html>')) {
        setState(() {
          placingRequest = false;
        });
        Navigator.of(context).pop(true);
      } else {
        Toast.show('Some error occurred please try again in some short of time.', context,duration: Toast.LENGTH_SHORT,gravity: Toast.CENTER);
        setState(() {
          placingRequest = false;
        });
      }
    }).catchError((e) {
      setState(() {
        placingRequest = false;
      });
      print(e);
    });
  }
}
