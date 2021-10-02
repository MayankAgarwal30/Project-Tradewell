import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/Components/bottom_bar.dart';
import 'package:vendor/Components/custom_appbar.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/baseurl/baseurl.dart';
import 'package:vendor/orderbean/vendorboy.dart';
import 'package:vendor/parcel/parcelbean/todayorderparcel.dart';

class OrderInfoParcel extends StatefulWidget {
  @override
  _OrderInfoParcelState createState() => _OrderInfoParcelState();
}

class _OrderInfoParcelState extends State<OrderInfoParcel> {
  TodayOrderParcel orderDetails;
  dynamic curency;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    final Map<String, Object> dataObject =
        ModalRoute.of(context).settings.arguments;
    setState(() {
      orderDetails = dataObject['orderdetails'];
      curency = dataObject['curency'];
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(144.0),
        child: CustomAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kMainColor,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          titleWidget: Text(
            '${locale.orderid1} #${orderDetails.cart_id}',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontSize: 13.3, letterSpacing: 0.07),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(
                      PageRoutes.invoicepdfparcel,
                      arguments: {
                        'inv_details': orderDetails,
                      })
                      .then((value) {})
                      .catchError((e) {});
                },
                child: Text(
                  locale.invoiceprint,
                  style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.w400),
                ),
                color: kMainColor,
                highlightColor: kMainColor,
                focusColor: kMainColor,
                splashColor: kMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Hero(
              tag: locale.customer,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  leading: Image.asset(
                    'images/user.png',
                    scale: 2.5,
                    height: 42.3,
                    width: 33.7,
                  ),
                  title: Text(
                    '${orderDetails.user_name}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 13.3, letterSpacing: 0.07),
                  ),
                  subtitle: Text(
                    '${orderDetails.pickup_date} | ${orderDetails.pickup_time}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 11.7, letterSpacing: 0.06),
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: kMainColor,
                            size: 18.0,
                          ),
                          onPressed: () {
                            if (orderDetails.user_phone != null &&
                                orderDetails.user_phone.toString().length > 9) {
                              _launchURL("tel:${orderDetails.user_phone}");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            primary: true,
            children: <Widget>[
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      child: Text(locale.pickupadd,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.06,
                              color: kMainColor)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_city,
                          size: 30,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                              '${orderDetails.source_houseno}, ${orderDetails.source_add}, ${orderDetails.source_city}, ${orderDetails.source_state}(${orderDetails.source_pincode})\nLandmark :- ${orderDetails.source_landmark}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontSize: 11.7,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.06,
                                      color: Color(0xff393939))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      child: Text(locale.destinationadd,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.06,
                              color: kMainColor)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_city,
                          size: 30,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                              '${orderDetails.destination_houseno}, ${orderDetails.destination_add}, ${orderDetails.destination_city}, ${orderDetails.destination_state}(${orderDetails.destination_pincode})\nLandmark :- ${orderDetails.destination_landmark}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontSize: 11.7,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.06,
                                      color: Color(0xff393939))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(locale.item,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Color(0xffadadad), fontWeight: FontWeight.bold)),
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        (orderDetails.parcel_description != null)
                            ? '${orderDetails.parcel_id}\n${orderDetails.parcel_description}'
                            : '${orderDetails.parcel_id}',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${locale.parcelweight} :- ${orderDetails.weight} KG \nDimension :- ${orderDetails.length} x ${orderDetails.width} x ${orderDetails.height}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      trailing: Text(
                        '${curency} ${orderDetails.charges}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Divider(
                      color: kCardBackgroundColor,
                      thickness: 1.0,
                    ),
                  ],
                ),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(locale.payementinfo,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: kDisabledColor, fontWeight: FontWeight.bold)),
                color: Colors.white,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.subtotal,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '${curency} ${(double.parse('${orderDetails.distance}') > 1) ? (double.parse('${orderDetails.charges}') * double.parse('${orderDetails.distance}')) : double.parse('${orderDetails.charges}')}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.distance,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '${(double.parse('${orderDetails.distance}') > 1) ? orderDetails.distance : 1} km',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.orderprice,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${curency} ${(double.parse('${orderDetails.distance}') > 1) ? (double.parse('${orderDetails.charges}') * double.parse('${orderDetails.distance}')) : double.parse('${orderDetails.charges}')}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.remainamt,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${curency} ${(double.parse('${orderDetails.distance}') > 1) ? (double.parse('${orderDetails.charges}') * double.parse('${orderDetails.distance}')) : double.parse('${orderDetails.charges}')}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.paymethod,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${orderDetails.payment_method}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.paystatus,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${orderDetails.payment_status}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ]),
              ),
              SizedBox(
                height: 7.0,
              ),
              Container(
                height: 180.0,
                color: kCardBackgroundColor,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: kWhiteColor,
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22.0,
                      backgroundImage: AssetImage('images/profile.png'),
                    ),
                    title: Text(
                      '${orderDetails.delivery_boy_name != null ? orderDetails.delivery_boy_name : 'Not Assigned Yet'}',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      locale.delpartner,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 11.7, letterSpacing: 0.06),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.call,
                        color: kMainColor,
                        size: 17.0,
                      ),
                      onPressed: () {
                        if (orderDetails.delivery_boy_phone != null &&
                            orderDetails.delivery_boy_phone.toString().length >
                                9) {
                          _launchURL(
                              "tel://${orderDetails.delivery_boy_phone}");
                        }
                      },
                    ),
                  ),
                ),
                BottomBar(
                    text:
                        '${orderDetails.delivery_boy_name != null ? orderDetails.delivery_boy_name : 'Not Assigned Yet'}',
                    onTap: () {
                      if (orderDetails.order_status == "pending" ||
                          orderDetails.order_status == "Pending") {
                        hitFindDriver(context, pr,locale);
                      } else {
                        Toast.show(locale.deliveryboy, context,
                            duration: Toast.LENGTH_SHORT);
                      }
                      // Navigator.pop(context);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    // print('$lat1 - $lon1 - $lat2 - $lon2');
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  showDialogList(
      BuildContext contextd, List<DeliveryBoyList> list, lat, lng, ProgressDialog pr) {
    var locale = AppLocalizations.of(contextd);
    showDialog(
        context: contextd,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 500,
              color: kWhiteColor,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (list[index]
                              .delivery_boy_status
                              .toString()
                              .toLowerCase() ==
                          "online") {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                        showProgressDialog(locale.loading, pr);
                        pr.show();
                        hitAssignOrder(
                            contextd,
                            pr,
                            list[index].delivery_boy_id,
                            list[index].delivery_boy_name,
                            list[index].delivery_boy_phone);
                      } else {
                        Toast.show(locale.driveoffnow, contextd,
                            gravity: Toast.CENTER,
                            duration: Toast.LENGTH_SHORT);
                      }
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${locale.delboy} - ${list[index].delivery_boy_name} (${list[index].delivery_boy_status})\nPhone - ${list[index].delivery_boy_phone}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kMainTextColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 6,
                    color: kCardBackgroundColor,
                  );
                },
                itemCount: list.length,
              ),
            ),
          );
        });
  }

  showProgressDialog(String text, ProgressDialog pr) {
    pr.style(
        message: '${text}',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  void hitFindDriver(context, ProgressDialog pr, AppLocalizations locale) async {
    showProgressDialog('Please wait finding delivery boy', pr);
    pr.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var vendorId = pref.getInt('vendor_id');
    var client = http.Client();
    var assignUrl = store_delivery_boy;
    client.post(assignUrl, body: {'vendor_id': '${vendorId}'}).then((value) {
      pr.hide();
      if (value.statusCode == 200) {
        var jsonData = jsonDecode(value.body);
        if (jsonData['status'] == "1") {
          var jsond = jsonData['data'] as List;
          List<DeliveryBoyList> delList =
              jsond.map((e) => DeliveryBoyList.fromJson(e)).toList();
          if (delList != null && delList.length > 0) {
            showDialogList(
                context, delList, pref.getString('lat'), pref.get('lng'), pr);
          } else {
            Toast.show(locale.deliveryboy1, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show(locale.deliveryboy1, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  void hitAssignOrder(context, ProgressDialog pr, dBoyId, delivery_boy_name,
      delivery_phone) async {
    var client = http.Client();
    var assignUrl = parcel_store_order;
    client.post(assignUrl, body: {
      'delivery_boy_id': '${dBoyId}',
      'parcel_id': '${orderDetails.parcel_id}'
    }).then((value) {
      pr.hide();
      if (value.statusCode == 200) {
        var jsonData = jsonDecode(value.body);
        if (jsonData['status'] == "1") {
          setState(() {
            orderDetails.delivery_boy_name = delivery_boy_name;
            orderDetails.delivery_boy_phone = delivery_phone;
          });
          Toast.show(jsonData['message'], context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          Navigator.of(context).pop();
        }
      }
    }).catchError((e) {
      print(e);
      pr.hide();
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
