import 'dart:math';

import 'package:driver/Components/bottom_bar.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/Themes/style.dart';
import 'package:driver/beanmodel/todayrestorder.dart';
import 'package:driver/orderpage/restaurantorderpage/rest_slide_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OnWayPagePharma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnWayBodyPharma();
  }
}

class OnWayBodyPharma extends StatefulWidget {
  @override
  _OnWayBodyPharmaState createState() => _OnWayBodyPharmaState();
}

class _OnWayBodyPharmaState extends State<OnWayBodyPharma> {
  dynamic cart_id = '';
  dynamic vendorName = '';
  dynamic vendorAddress = '';
  dynamic vendorDistance = '';
  dynamic userName = '';
  dynamic userAddress = '';
  dynamic userphone;
  dynamic vendorlat;
  dynamic vendorlng;
  dynamic vendor_phone;
  dynamic dlat;
  dynamic dlng;
  dynamic userlat;
  dynamic userlng;
  dynamic remprice;
  dynamic paymentstatus;
  dynamic paymentMethod;
  List<TodayRestaurantOrderDetails> orderDeatisSub;
  List<AddonList> addons;
  dynamic distance;
  dynamic currency;

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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: locale.loadingPleaseWait,
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
    final Map<String, Object> dataObject =
        ModalRoute.of(context).settings.arguments;
    setState(() {
      cart_id = dataObject['cart_id'];
      vendorName = dataObject['vendorName'];
      vendorAddress = dataObject['vendorAddress'];
      userName = dataObject['userName'];
      userAddress = dataObject['userAddress'];
      userphone = dataObject['userphone'];
      vendorlat = dataObject['vendorlat'];
      vendorlng = dataObject['vendorlng'];
      vendor_phone = dataObject['vendor_phone'];
      dlat = dataObject['dlat'];
      dlng = dataObject['dlng'];
      userlat = dataObject['userlat'];
      userlng = dataObject['userlng'];
      remprice = dataObject['remprice'];
      paymentstatus = dataObject['paymentstatus'];
      paymentMethod = dataObject['paymentMethod'];
      orderDeatisSub = dataObject['itemDetails'] as List;
      addons = dataObject['addons'] as List;
      distance = calculateDistance(
              double.parse(vendorlat), double.parse(vendorlng), dlat, dlng)
          .toStringAsFixed(2);
    });

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: AppBar(
              automaticallyImplyLeading: true,
              title: Text(locale.orderId+""+cart_id,
                  //'Order - #${cart_id}',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500)),
              actions: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: FlatButton.icon(
                    icon: Icon(
                      isOpen ? Icons.close : Icons.shopping_basket,
                      color: kMainColor,
                      size: 13.0,
                    ),
                    label: Text(isOpen ? locale.close : locale.orderInfo,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 11.7,
                              fontWeight: FontWeight.bold,
                            )),
                    onPressed: () {
                      setState(() {
                        if (isOpen)
                          isOpen = false;
                        else
                          isOpen = true;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'images/map.png',
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.3),
                            child: Image.asset(
                              'images/vegetables_fruitsact.png',
                              height: 42.3,
                              width: 33.7,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                '${vendorName}',
                                style: orderMapAppBarTextStyle.copyWith(
                                    letterSpacing: 0.07),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Text(
                                    '${distance} km ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize: 11.7,
                                            letterSpacing: 0.06,
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    locale.twentyMin,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize: 11.7,
                                            letterSpacing: 0.06,
                                            color: Color(0xffc1c1c1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: FlatButton(
                              onPressed: () {
                                _getDirection(
                                    'https://maps.google.com/maps?daddr=${userlat},${userlng}');
                              },
                              color: kMainColor,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.navigation,
                                    color: kWhiteColor,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    locale.direction,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.7,
                                            letterSpacing: 0.06),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 1.0,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 36.0, bottom: 6.0, top: 6.0, right: 20.0),
                            child: ImageIcon(
                              AssetImage(
                                  'images/custom/ic_pickup_pointact.png'),
                              size: 13.3,
                              color: kMainColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${vendorName}',
                                  style: orderMapAppBarTextStyle.copyWith(
                                      fontSize: 10.0, letterSpacing: 0.05),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  '${vendorAddress}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontSize: 10.0, letterSpacing: 0.05),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
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
                                    _launchURL("tel:${vendor_phone}");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 36.0,
                                bottom: 12.0,
                                top: 12.0,
                                right: 20.0),
                            child: ImageIcon(
                              AssetImage('images/custom/ic_droppointact.png'),
                              size: 13.3,
                              color: kMainColor,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${userName}',
                                style: orderMapAppBarTextStyle.copyWith(
                                    fontSize: 10.0, letterSpacing: 0.05),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '${userAddress}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontSize: 10.0, letterSpacing: 0.05),
                              ),
                            ],
                          ),
                          Spacer(),
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
                                    _launchURL("tel:${userphone}");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      BottomBar(
                          text: locale.markAsDelivered,
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, PageRoutes.signatureView,
                                arguments: {
                                  "cart_id": cart_id,
                                  "vendorName": vendorName,
                                  "vendorAddress": vendorAddress,
                                  "vendorlat": vendorlat,
                                  "vendorlng": vendorlng,
                                  "vendor_phone": vendor_phone,
                                  "dlat": dlat,
                                  "dlng": dlng,
                                  "userlat": userlat,
                                  "userlng": userlng,
                                  "userName": userName,
                                  "userAddress": userAddress,
                                  "userphone": userphone,
                                  "remprice": remprice,
                                  "paymentstatus": paymentstatus,
                                  "paymentMethod": paymentMethod,
                                  "ui_type": "3",
                                  // "addons":addons
                                });
                          }),
                    ],
                  ),
                )
              ],
            ),
            isOpen
                ? OrderInfoContainerRest(orderDeatisSub, remprice,
                    paymentMethod, paymentstatus, currency, addons)
                : SizedBox.shrink(),
          ],
        ));
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
