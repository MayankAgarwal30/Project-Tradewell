import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class PhoneNumber_New extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhoneNumber(),
    );
  }
}

class PhoneNumber extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhoneNumberState();
  }
}

class PhoneNumberState extends State<PhoneNumber> {
  static const String id = 'phone_number';
  final TextEditingController _controller = TextEditingController();
  String isoCode = '--';
  int numberLimit = 10;
  bool showDialogBox = false;
  bool enteredFirst = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getCountryCode() async{
    setState(() {
      showDialogBox = true;
    });
    var url = country_code;
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('${response.body}');
        if ('${jsonData['status']}' == '1') {
          var tagObjsJson = jsonData['Data'] as List;
          if (tagObjsJson.isNotEmpty) {
            setState(() {
              showDialogBox = false;
              numberLimit = int.parse('${tagObjsJson[0]['number_limit']}');
              isoCode = tagObjsJson[0]['country_code'];
            });
          } else {
            setState(() {
              showDialogBox = false;
            });
          }
        } else {
          setState(() {
            showDialogBox = false;
          });
        }
      } else {
        setState(() {
          showDialogBox = false;
        });
      }
    }).catchError((e) {
      print(e);
      setState(() {
        showDialogBox = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    double widthRender = MediaQuery.of(context).size.width;
    if(!enteredFirst){
      setState(() {
        enteredFirst = true;
      });
      getCountryCode();
    }
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: () {
          return _handlePopBack();
        },
        child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, PageRoutes.language);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(locale.selectPreferredLanguage,style: TextStyle(
                              color: kMainColor
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left:5,right: 8),
                            child: Icon(Icons.arrow_forward_ios,color: kMainColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: widthRender,
                        child: Image.asset(
                          "images/logos/logo_delivery.png",
                          height: 130.0,
                          width: 99.7,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: widthRender,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0, bottom: 0),
                              child: Text(
                                appname,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kMainTextColor,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            //text on page
                            Text(locale.bodyText1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(
                              locale.bodyText2,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Visibility(
                      visible: showDialogBox,
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Align(
                      widthFactor: widthRender,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "images/logos/Delivery.gif",
                        fit: BoxFit.fill,//footer image
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(isoCode),
                        SizedBox(
                          width: 5.0,
                        ),
                        //takes phone number as input
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 52,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              readOnly: false,
                              textAlign: TextAlign.left,
                              enabled: !showDialogBox,
                              decoration: InputDecoration(
                                hintText: locale.mobileText,
                                border: InputBorder.none,
                                counter: Offstage(),
                                contentPadding: EdgeInsets.only(left: 30),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kHintColor,
                                    fontSize: 16),
                              ),
                              maxLength: numberLimit,
                            ),
                          ),
                        ),
                        RaisedButton(
                          child: Text(
                            locale.continueText,
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.w400),
                          ),
                          color: kMainColor,
                          highlightColor: kMainColor,
                          focusColor: kMainColor,
                          splashColor: kMainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            if (!showDialogBox) {
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              setState(() {
                                showDialogBox = true;
                              });
                              if (_controller.text.length < numberLimit) {
                                setState(() {
                                  showDialogBox = false;
                                });
                                Toast.show(locale.enterValidMobileNumber, context,
                                    gravity: Toast.BOTTOM);
                              } else {
                                hitService(isoCode,_controller.text,context);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void hitService(
      String isoCode, String phoneNumber, BuildContext context) async {
    var url = delievery_boy_phone_verify;
    var client = http.Client();
    client.post(url, body: {'phone': '${isoCode}${phoneNumber}'}).then((response) async {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        Toast.show(jsonData['message'], context, gravity: Toast.BOTTOM);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("delivery_boy_phone", '${isoCode}${phoneNumber}');
        setState(() {
          showDialogBox = false;
        });
        if ('${jsonData['status']}' == '1') {
          Navigator.pushNamed(context, PageRoutes.verification);
        } else {
          showAlertDialog(context);
        }
      } else {
        setState(() {
          showDialogBox = false;
        });
      }
    }).catchError((e) {
      print(e);
      setState(() {
        showDialogBox = false;
      });
    });
  }

  showAlertDialog(BuildContext context) {
    var locale = AppLocalizations.of(context);
    Widget remindButton = FlatButton(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(locale.ok),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(locale.notice),
      content: Text(
          locale.yourNumberIsNotVerifiedYet),
      actions: [
        remindButton,
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  buildButton(CountryCode isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  Future<bool> _handlePopBack() async {
    bool isVal = false;
    if (showDialogBox) {
      setState(() {
        showDialogBox = false;
      });
    } else {
      isVal = true;
    }
    return isVal;
  }

}
