import 'dart:convert';
import 'dart:math';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:toast/toast.dart';

class SignatureView extends StatefulWidget {
  @override
  SignatureViewState createState() => SignatureViewState();
}

class SignatureViewState extends State<SignatureView> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: kWhiteColor,
  );
  dynamic currencyd = '';
  final TextEditingController _cashController = TextEditingController();
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
  dynamic ui_type;

  @override
  void initState() {
    getCurrency();
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currencyd = prefs.getString('curency');
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

  @override
  void dispose() {
    super.dispose();
    _cashController.dispose();
  }

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
      dlat = dataObject['dlat'];
      dlng = dataObject['dlng'];
      remprice = dataObject['remprice'];
      paymentstatus = dataObject['paymentstatus'];
      paymentMethod = dataObject['paymentMethod'];
      ui_type = dataObject['ui_type'];
      // orderDeatisSub = dataObject['itemDetails'] as List;
      distance = calculateDistance(
              double.parse(vendorlat), double.parse(vendorlng), dlat, dlng)
          .toStringAsFixed(2);
      print('${distance}');
    });

    return Scaffold(
      backgroundColor: kCardBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: kWhiteColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.order+""+cart_id,
                    //'Order - #${cart_id}',
                    // 'Order',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 5,
                ),
                Text('Order Amount - ${currencyd} ${remprice}',
                    // 'Order',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                child: RaisedButton(
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  child: Text(
                    locale.clearView,
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
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
            child: Signature(
              controller: _controller,
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height - 70,
              backgroundColor: kWhiteColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Sign/Signature Here.',style: TextStyle(
              color: kLightTextColor.withOpacity(0.7),
            ),),
          ),
          Positioned(
            top: 10.0,
            width: MediaQuery.of(context).size.width,
            height: 52,
            child: Visibility(
              visible: (paymentMethod == "COD" || paymentMethod == "cod")
                  ? true
                  : false,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: _cashController,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: locale.enterCODAmount,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 10.0,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (paymentMethod == "COD") {
                      if ('${remprice}' == '${_cashController.text}') {
                        if (ui_type == "1") {
                          hitSevice(cart_id, _cashController.text, pr, context);
                        } else if (ui_type == "2") {
                          hitSeviced(
                              cart_id, _cashController.text, pr, context);
                        } else if (ui_type == "4") {
                          hitSevicep(
                              cart_id, _cashController.text, pr, context);
                        } else if (ui_type == "3") {
                          hitSeviceph(
                              cart_id, _cashController.text, pr, context);
                        }
                      } else {
                        Toast.show(
                            locale.youHaveFilledIncorrectAmount, context,
                            gravity: Toast.BOTTOM,
                            duration: Toast.LENGTH_SHORT);
                      }
                    } else {
                      if (ui_type == "1") {
                        hitSevice(cart_id, _cashController.text, pr, context);
                      } else if (ui_type == "2") {
                        hitSeviced(cart_id, _cashController.text, pr, context);
                      } else if (ui_type == "4") {
                        hitSevicep(cart_id, _cashController.text, pr, context);
                      } else if (ui_type == "3") {
                        hitSeviceph(cart_id, _cashController.text, pr, context);
                      }
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        locale.markAsDelivered,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void hitSevice(cartID, cashAmt, ProgressDialog pr, context) async {
    var locale = AppLocalizations.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var dBoyId = pref.getInt('delivery_boy_id');
    if (_controller != null && _controller.isNotEmpty) {
      pr.show();
      var data = await _controller.toPngBytes();
      dynamic imageS = base64Encode(data);
      var delivery_out = delivery_completed;
      var client = http.Client();
      if (paymentMethod != "COD") {
        client.post(delivery_out, body: {
          'cart_id': '${cartID}',
          'user_signature': '${imageS}',
          'cash_amount': '0',
          'delivery_boy_id': '${dBoyId}',
        }).then((value) {
          pr.hide();
          print('${value.body}');
          if (value.statusCode == 200) {
            Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                arguments: {
                  "cart_id": cart_id,
                  "vendorName": vendorName,
                  "vendorAddress": vendorAddress,
                  "vendorlat": vendorlat,
                  "vendorlng": vendorlng,
                  "dlat": dlat,
                  "dlng": dlng,
                  "userName": userName,
                  "userAddress": userAddress,
                  "userphone": userphone,
                  "remprice": remprice,
                  "paymentstatus": paymentstatus,
                  "paymentMethod": paymentMethod
                });
          }
        }).catchError((e) {
          pr.hide();
          print(e);
        });
      } else {
        if (cashAmt.toString() == '') {
          pr.hide();
          Toast.show(locale.pleaseFillTheAmountYouHaveReceivedFromCustomer,
              context,
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        } else {
          client.post(delivery_out, body: {
            'cart_id': '${cartID}',
            'user_signature': '${imageS}',
            'cash_amount': '${cashAmt}',
            'delivery_boy_id': '${dBoyId}',
          }).then((value) {
            pr.hide();
            print('d ${value.body}');
            if (value.statusCode == 200) {
              Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                  arguments: {
                    "cart_id": cart_id,
                    "vendorName": vendorName,
                    "vendorAddress": vendorAddress,
                    "vendorlat": vendorlat,
                    "vendorlng": vendorlng,
                    "dlat": dlat,
                    "dlng": dlng,
                    "userName": userName,
                    "userAddress": userAddress,
                    "userphone": userphone,
                    // "itemDetails":orderDeatisSub,
                    "remprice": remprice,
                    "paymentstatus": paymentstatus,
                    "paymentMethod": paymentMethod
                  });
            }
          }).catchError((e) {
            pr.hide();
            print(e);
          });
        }
      }
    } else {
      pr.hide();
      Toast.show('Please Sign/Signature to continue.', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  void hitSeviced(cartID, cashAmt, ProgressDialog pr, context) async {
    var locale = AppLocalizations.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var dBoyId = pref.getInt('delivery_boy_id');
    if (_controller != null && _controller.isNotEmpty) {
      pr.show();
      var data = await _controller.toPngBytes();
      dynamic imageS = base64Encode(data);
      var delivery_out = resturant_delivery_completed;
      var client = http.Client();
      if (paymentMethod != "COD") {
        client.post(delivery_out, body: {
          'cart_id': '${cartID}',
          'user_signature': '${imageS}',
          'cash_amount': '0',
          'delivery_boy_id': '${dBoyId}',
        }).then((value) {
          pr.hide();
          print('${value.body}');
          if (value.statusCode == 200) {
            Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                arguments: {
                  "cart_id": cart_id,
                  "vendorName": vendorName,
                  "vendorAddress": vendorAddress,
                  "vendorlat": vendorlat,
                  "vendorlng": vendorlng,
                  "dlat": dlat,
                  "dlng": dlng,
                  "userName": userName,
                  "userAddress": userAddress,
                  "userphone": userphone,
                  "remprice": remprice,
                  "paymentstatus": paymentstatus,
                  "paymentMethod": paymentMethod
                });
          }
        }).catchError((e) {
          pr.hide();
          print(e);
        });
      } else {
        if (cashAmt.toString() == '') {
          pr.hide();
          Toast.show(locale.pleaseFillTheAmountYouHaveReceivedFromCustomer,
              context,
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        } else {
          client.post(delivery_out, body: {
            'cart_id': '${cartID}',
            'user_signature': '${imageS}',
            'cash_amount': '${cashAmt}',
            'delivery_boy_id': '${dBoyId}',
          }).then((value) {
            pr.hide();
            print('d ${value.body}');
            if (value.statusCode == 200) {
              Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                  arguments: {
                    "cart_id": cart_id,
                    "vendorName": vendorName,
                    "vendorAddress": vendorAddress,
                    "vendorlat": vendorlat,
                    "vendorlng": vendorlng,
                    "dlat": dlat,
                    "dlng": dlng,
                    "userName": userName,
                    "userAddress": userAddress,
                    "userphone": userphone,
                    "remprice": remprice,
                    "paymentstatus": paymentstatus,
                    "paymentMethod": paymentMethod
                  });
            }
          }).catchError((e) {
            pr.hide();
            print(e);
          });
        }
      }
    } else {
      pr.hide();
      Toast.show('Please Sign/Signature to continue.', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  void hitSevicep(cartID, cashAmt, ProgressDialog pr, context) async {
    var locale = AppLocalizations.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var dBoyId = pref.getInt('delivery_boy_id');
    if (_controller != null && _controller.isNotEmpty) {
      pr.show();
      var data = await _controller.toPngBytes();
      dynamic imageS = base64Encode(data);
      var delivery_out = parcel_delivery_completed;
      var client = http.Client();
      if (paymentMethod != "COD") {
        client.post(delivery_out, body: {
          'cart_id': '${cartID}',
          'user_signature': '${imageS}',
          'cash_amount': '0',
          'delivery_boy_id': '${dBoyId}',
        }).then((value) {
          pr.hide();
          if (value.statusCode == 200) {
            Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                arguments: {
                  "cart_id": cart_id,
                  "vendorName": vendorName,
                  "vendorAddress": vendorAddress,
                  "vendorlat": vendorlat,
                  "vendorlng": vendorlng,
                  "dlat": dlat,
                  "dlng": dlng,
                  "userName": userName,
                  "userAddress": userAddress,
                  "userphone": userphone,
                  "remprice": remprice,
                  "paymentstatus": paymentstatus,
                  "paymentMethod": paymentMethod
                });
          }
        }).catchError((e) {
          pr.hide();
          print(e);
        });
      } else {
        if (cashAmt.toString() == '') {
          pr.hide();
          Toast.show(locale.pleaseFillTheAmountYouHaveReceivedFromCustomer,
              context,
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        } else {
          client.post(delivery_out, body: {
            'cart_id': '${cartID}',
            'user_signature': '${imageS}',
            'cash_amount': '${cashAmt}',
            'delivery_boy_id': '${dBoyId}',
          }).then((value) {
            pr.hide();
            print('d ${value.body}');
            if (value.statusCode == 200) {
              Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                  arguments: {
                    "cart_id": cart_id,
                    "vendorName": vendorName,
                    "vendorAddress": vendorAddress,
                    "vendorlat": vendorlat,
                    "vendorlng": vendorlng,
                    "dlat": dlat,
                    "dlng": dlng,
                    "userName": userName,
                    "userAddress": userAddress,
                    "userphone": userphone,
                    "remprice": remprice,
                    "paymentstatus": paymentstatus,
                    "paymentMethod": paymentMethod
                  });
            }
          }).catchError((e) {
            pr.hide();
            print(e);
          });
        }
      }
    } else {
      pr.hide();
      Toast.show('Please Sign/Signature to continue.', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  void hitSeviceph(cartID, cashAmt, ProgressDialog pr, context) async {
    var locale = AppLocalizations.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var dBoyId = pref.getInt('delivery_boy_id');
    if (_controller != null && _controller.isNotEmpty) {
      pr.show();
      var data = await _controller.toPngBytes();
      dynamic imageS = base64Encode(data);
      var delivery_out = pharmacy_delivery_completed;
      var client = http.Client();
      if (paymentMethod != "COD") {
        client.post(delivery_out, body: {
          'cart_id': '${cartID}',
          'user_signature': '${imageS}',
          'cash_amount': '0',
          'delivery_boy_id': '${dBoyId}',
        }).then((value) {
          pr.hide();
          print('${value.body}');
          if (value.statusCode == 200) {
            Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                arguments: {
                  "cart_id": cart_id,
                  "vendorName": vendorName,
                  "vendorAddress": vendorAddress,
                  "vendorlat": vendorlat,
                  "vendorlng": vendorlng,
                  "dlat": dlat,
                  "dlng": dlng,
                  "userName": userName,
                  "userAddress": userAddress,
                  "userphone": userphone,
                  "remprice": remprice,
                  "paymentstatus": paymentstatus,
                  "paymentMethod": paymentMethod
                });
          }
        }).catchError((e) {
          pr.hide();
          print(e);
        });
      } else {
        if (cashAmt.toString() == '') {
          pr.hide();
          Toast.show(locale.pleaseFillTheAmountYouHaveReceivedFromCustomer,
              context,
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        } else {
          client.post(delivery_out, body: {
            'cart_id': '${cartID}',
            'user_signature': '${imageS}',
            'cash_amount': '${cashAmt}',
            'delivery_boy_id': '${dBoyId}',
          }).then((value) {
            pr.hide();
            if (value.statusCode == 200) {
              Navigator.popAndPushNamed(context, PageRoutes.deliverySuccessful,
                  arguments: {
                    "cart_id": cart_id,
                    "vendorName": vendorName,
                    "vendorAddress": vendorAddress,
                    "vendorlat": vendorlat,
                    "vendorlng": vendorlng,
                    "dlat": dlat,
                    "dlng": dlng,
                    "userName": userName,
                    "userAddress": userAddress,
                    "userphone": userphone,
                    "remprice": remprice,
                    "paymentstatus": paymentstatus,
                    "paymentMethod": paymentMethod
                  });
            }
          }).catchError((e) {
            pr.hide();
            print(e);
          });
        }
      }
    } else {
      pr.hide();
      Toast.show('Please Sign/Signature to continue.', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }
}
