import 'dart:math';

import 'package:driver/Account/UI/account_page.dart';
import 'package:driver/Components/bottom_bar.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliverySuccessful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeliverySuccessfulState();
  }
}

class DeliverySuccessfulState extends State<DeliverySuccessful> {
  dynamic cart_id = '';
  dynamic vendorName = '';
  dynamic vendorAddress = '';
  dynamic vendorDistance = '';
  dynamic userName = '';
  dynamic userAddress = '';
  dynamic userphone;
  dynamic vendorlat;
  dynamic vendorlng;
  dynamic dlat;
  dynamic dlng;
  dynamic remprice;
  dynamic paymentstatus;
  dynamic paymentMethod;
  dynamic distance;

  @override
  void initState() {
    super.initState();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
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
      dlat = dataObject['dlat'];
      dlng = dataObject['dlng'];
      remprice = dataObject['remprice'];
      paymentstatus = dataObject['paymentstatus'];
      paymentMethod = dataObject['paymentMethod'];
      distance = calculateDistance(
              double.parse(vendorlat), double.parse(vendorlng), dlat, dlng)
          .toStringAsFixed(2);
    });

    return WillPopScope(
      onWillPop: () {
        return Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return AccountPage();
        }), (Route<dynamic> route) => false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: kMainColor,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return AccountPage();
                  }), (Route<dynamic> route) => false);
                },
              ),
              title: Text(locale.order+""+cart_id,
                  //'Order - #${cart_id}',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500)),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.all(60.0),
              child: Image.asset(
                'images/delivery done.png',
                height: 236.7,
                width: 210.7,
              ),
            ),
            Text(
              locale.deliverySuccessfully,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 20, color: kMainTextColor, letterSpacing: 0.1),
            ),
            Text(
              locale.thankYouForDeliverSafely,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: kMainTextColor),
            ),
            Spacer(),
            BottomBar(
              text: locale.backToHome,
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return AccountPage();
                }), (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
