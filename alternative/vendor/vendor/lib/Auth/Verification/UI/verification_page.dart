import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/Themes/style.dart';
import 'package:vendor/baseurl/baseurl.dart';
import 'package:vendor/orderbean/vendorprofilebean.dart';



class VerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          locale.verification1,
          style: headingStyle,
        ),
      ),
      body: OtpVerify(),
    );
  }
}

class OtpVerify extends StatefulWidget {
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _controller = TextEditingController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  bool isDialogShowing = false;
  var deviceToken = '';
  var showDialogBox = false;
  var verificaitonPin = "";
  var firebaseAuth;
  var actualCode;
  int resendT;

  bool firebaseOtp = false;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    try {
      await Firebase.initializeApp();
      firebaseMessaging = FirebaseMessaging.instance;
      firebaseMessaging.getToken().then((value) {
        deviceToken = value;
      });
    } catch (e) {}
    getFIrebaseStatus();
  }

  void getFIrebaseStatus() async {
    setState(() {
      showDialogBox = true;
    });
    var url = firebase;
    http.get(url).then((response) {
      print(response);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('${response.body}');
        if ('${jsonData['status']}' == '1') {
          var tagObjsJson = jsonData['data']['status'];
          print('fd ${tagObjsJson}');
          if (tagObjsJson != null && (tagObjsJson == '1' || tagObjsJson == 1)) {
            setState(() {
              firebaseOtp = true;
            });
            initialAuth();
          } else {
            setState(() {
              firebaseOtp = false;
              showDialogBox = false;
            });
          }
        } else {
          setState(() {
            firebaseOtp = false;
            showDialogBox = false;
          });
        }
      } else {
        setState(() {
          firebaseOtp = false;
          showDialogBox = false;
        });
      }
    }).catchError((e) {
      print(e);
      setState(() {
        firebaseOtp = false;
        showDialogBox = false;
      });
    });
  }

  initialAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userNumber = prefs.getString('store_phone');
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        setState(() {
          showDialogBox = false;
        });
      },
      codeSent: (String verificationId, int resendToken) {
        setState(() {
          resendT = resendToken;
          showDialogBox = false;
          actualCode = verificationId;
        });
        print('code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  initialAuthResend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userNumber = prefs.getString('store_phone');
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: userNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          setState(() {
            showDialogBox = false;
          });
        },
        codeSent: (String verificationId, int resendToken) {
          setState(() {
            resendT = resendToken;
            showDialogBox = false;
            actualCode = verificationId;
          });
          print('code sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: resendT
    );
  }

  _signInWithPhoneNumber(String smsCode, BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);
    auth.signInWithCredential(credential).then((value) {
      if (value != null) {
        User userd = value.user;
        if (userd != null) {
          hitFirebaseSuccessStatus('success', context);
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
      print('user null + $e');
      setState(() {
        showDialogBox = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 5, right: 80, left: 80),
                      child: Center(
                        child: Text(
                          locale.verify1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kMainTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        locale.otp1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          PinCodeTextField(
                            autofocus: true,
                            controller: _controller,
                            hideCharacter: false,
                            highlight: true,
                            highlightColor: kHintColor,
                            defaultBorderColor: kMainColor,
                            hasTextBorderColor: kMainColor,
                            maxLength: firebaseOtp ? 6 : 4,
                            pinBoxRadius: firebaseOtp ? 30 : 40,
                            onDone: (text) {
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              verificaitonPin = text;
                            },
                            pinBoxWidth: firebaseOtp ? 45 : 60,
                            pinBoxHeight: firebaseOtp ? 45 : 60,
                            hasUnderline: false,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .roundedPinBoxDecoration,
                            pinTextStyle:
                            TextStyle(fontSize: firebaseOtp ? 18.0 : 22.0),
                            pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                            pinTextAnimatedSwitcherDuration:
                            Duration(milliseconds: 300),
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 15.0),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              locale.otp2,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     locale.resend1,
                          //     textDirection: TextDirection.ltr,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         color: kMainColor,
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: (){
                              if(!showDialogBox){
                                setState(() {
                                  showDialogBox = true;
                                });
                                hitResend();
                              }else{
                                Toast.show('still in progress wait till complete', context,gravity: Toast.CENTER,duration: Toast.LENGTH_SHORT);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                locale.resend1,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )),
            Positioned(
              bottom: 12,
              left: 20,
              right: 20.0,
              child: InkWell(
                onTap: () {
                  if (!showDialogBox) {
                    setState(() {
                      showDialogBox = true;
                    });
                    if (firebaseOtp) {
                      if (verificaitonPin != null && actualCode != null) {
                        _signInWithPhoneNumber(verificaitonPin, context);
                      } else {
                        Toast.show(locale.wrongotp, context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      }
                    } else {
                      hitService(verificaitonPin, context);
                    }
                  }else{
                    Toast.show('still in progress wait till complete', context,gravity: Toast.CENTER,duration: Toast.LENGTH_SHORT);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: kMainColor),
                  child: Text(
                    locale.Verify1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Visibility(
                  visible: showDialogBox,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 100,
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            color: kWhiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    locale.loading,
                                    style: TextStyle(
                                        color: kMainTextColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void hitService(String verificaitonPin, BuildContext context) async {
    if (deviceToken != null && deviceToken.length > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = storelogin;
      http.post(url, body: {
        'store_phone': prefs.getString('store_phone'),
        'otp': verificaitonPin,
        'device_id': '${deviceToken}'
      }).then((response) {
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          if (jsonData['status'] == 1) {
            VendorProfile profile = VendorProfile.fromJson(jsonData['data']);
            CurrencyData currencyData =
            CurrencyData.fromJson(jsonData['currency']);
            print('${profile.toString()}');
            print('${currencyData.toString()}');
            prefs.setString("curency", '${currencyData.currency_sign}');
            var venId = int.parse('${profile.vendor_id}');
            prefs.setInt("vendor_id", venId);
            prefs.setString("vendor_name", profile.vendor_name);
            prefs.setString("vendor_logo", profile.vendor_logo);
            prefs.setString("vendor_phone", profile.vendor_phone);
            prefs.setString("vendor_pass", profile.vendor_pass);
            prefs.setString("owner", profile.owner);
            prefs.setString("device_id", profile.device_id);
            prefs.setString("comission", '${profile.comission}');
            prefs.setString("delivery_range", '${profile.delivery_range}');
            prefs.setString(
                "vendor_category_id", '${profile.vendor_category_id}');
            prefs.setString("opening_time", '${profile.opening_time}');
            prefs.setString("closing_time", '${profile.closing_time}');
            prefs.setString("vendor_loc", '${profile.vendor_loc}');
            prefs.setString("lat", '${profile.lat}');
            prefs.setString("lng", '${profile.lng}');
            prefs.setString("cityadmin_id", profile.cityadmin_id);
            var uiType = int.parse('${profile.ui_type}');
            prefs.setString("ui_type", '$uiType');
            var phone_verified = int.parse('${profile.phone_verified}');
            prefs.setInt("phoneverifed", phone_verified);
            prefs.setBool("islogin", true);
            Toast.show(jsonData['message'], context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            hitNavitgator(context);
          } else {
            prefs.setInt("phoneverifed", 0);
            prefs.setBool("islogin", false);
            setState(() {
              showDialogBox = false;
            });
          }
        }
      });
    } else {
      firebaseMessaging.getToken().then((value) {
        deviceToken = value;
        hitService(verificaitonPin, context);
      });
    }
  }

  hitNavitgator(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String uiType = pref.getString("ui_type");
    if (uiType != null && uiType == "2") {
      Navigator.of(context).pushNamedAndRemoveUntil(
          PageRoutes.orderItemAccountPageRest, (route) => false);
    } else if (uiType != null && uiType == "3") {
      Navigator.of(context).pushNamedAndRemoveUntil(
          PageRoutes.orderItemAccountPharma, (route) => false);
    } else if (uiType != null && uiType == "4") {
      Navigator.of(context).pushNamedAndRemoveUntil(
          PageRoutes.orderItemAccountparcel, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          PageRoutes.orderItemAccountPage, (route) => false);
    }
  }

  void hitFirebaseSuccessStatus(String status, BuildContext context) async {
    print('entered');
    if (deviceToken != null && deviceToken.toString().length > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = verifyotpfirebase;
      await http.post(url, body: {
        'store_phone': prefs.getString('store_phone'),
        'status': status,
        'device_id': '${deviceToken}'
      }).then((response) {
        print('Response Body: - ${response.body}');
        if (response.statusCode == 200) {
          // print('Response Body: - ${response.body}');
          var jsonData = jsonDecode(response.body);
          if ('${jsonData['status']}' == '1') {
            VendorProfile profile = VendorProfile.fromJson(jsonData['data']);
            CurrencyData currencyData =
            CurrencyData.fromJson(jsonData['Currency']);
            print('${profile.toString()}');
            print('${currencyData.toString()}');
            prefs.setString("curency", '${currencyData.currency_sign}');
            var venId = int.parse('${profile.vendor_id}');
            prefs.setInt("vendor_id", venId);
            prefs.setString("vendor_name", profile.vendor_name);
            prefs.setString("vendor_logo", profile.vendor_logo);
            prefs.setString("vendor_phone", profile.vendor_phone);
            prefs.setString("vendor_pass", profile.vendor_pass);
            prefs.setString("owner", profile.owner);
            prefs.setString("device_id", profile.device_id);
            prefs.setString("comission", '${profile.comission}');
            prefs.setString("delivery_range", '${profile.delivery_range}');
            prefs.setString(
                "vendor_category_id", '${profile.vendor_category_id}');
            prefs.setString("opening_time", '${profile.opening_time}');
            prefs.setString("closing_time", '${profile.closing_time}');
            prefs.setString("vendor_loc", '${profile.vendor_loc}');
            prefs.setString("lat", '${profile.lat}');
            prefs.setString("lng", '${profile.lng}');
            prefs.setString("cityadmin_id", profile.cityadmin_id);
            var uiType = int.parse('${profile.ui_type}');
            prefs.setString("ui_type", '$uiType');
            var phone_verified = int.parse('${profile.phone_verified}');
            prefs.setInt("phoneverifed", phone_verified);
            prefs.setBool("islogin", true);
            Toast.show(jsonData['message'], context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            hitNavitgator(context);
          } else {
            prefs.setInt("phoneverifed", 0);
            prefs.setBool("islogin", false);
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
    } else {
      firebaseMessaging.getToken().then((value) {
        deviceToken = value;
        hitFirebaseSuccessStatus(status, context);
      });
    }
  }

  void hitResend() async{
    if(firebaseOtp){
      initialAuthResend();
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.post(resendOtpVendor,body: {
        'store_phone':prefs.getString('store_phone')
      }).then((value){
        var js = jsonDecode(value.body);
        setState(() {
          showDialogBox = false;
        });
      }).catchError((e){
        setState(() {
          showDialogBox = false;
        });
      });
    }
  }
}
