import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:driver/Components/list_tile.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:driver/beanmodel/dutyonoff.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

 FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  '1232', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  _showNotification(flutterLocalNotificationsPlugin,
      '${message.notification.title}', '${message.notification.body}');
}

var scfoldKey = GlobalKey<ScaffoldState>();

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  var onOffLine = 'GO OFFLINE';
  var status = 0;
  dynamic lat;
  dynamic lng;
  SharedPreferences preferences;
  dynamic driverName = '';
  dynamic driverNumber = '';
  dynamic imageUrld = '';
  static const LatLng _center = const LatLng(45.343434, -122.545454);
  CameraPosition kGooglePlex = CameraPosition(
    target: _center,
    zoom: 12.151926,
  );
  bool isRun = false;
  bool isRingBell = false;
  Timer timer;
  var orderCount = 0;

  bool enterdFirst = false;

  @override
  void initState() {
    super.initState();
    setFirebase();
    getCurrency();
  }

  void setFirebase() async {
    try{
      await Firebase.initializeApp();
    }catch(e){

    }
    messaging = FirebaseMessaging.instance;
    iosPermission(messaging);
    var initializationSettingsAndroid =
        AndroidInitializationSettings('logo_user');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    messaging.getToken().then((value) {
      debugPrint('token: $value');
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        _showNotification(flutterLocalNotificationsPlugin,
            '${message.notification.title}', '${message.notification.body}');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'logo_user',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      _showNotification(flutterLocalNotificationsPlugin,
          '${message.notification.title}', '${message.notification.body}');
    });
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  void setTimerTask() async {
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (this.timer == null) {
        this.timer = timer;
      }
      hitTestServices();
    });
  }

  void hitStatusServiced(AppLocalizations locale) async {
    setState(() {
      isRun = true;
    });
    preferences = await SharedPreferences.getInstance();
    print('${status} - ${preferences.getInt('delivery_boy_id')}');
    var client = http.Client();
    var statusUrl = driverstatus;
    client.post(statusUrl, body: {
      'delivery_boy_id': '${preferences.getInt('delivery_boy_id')}'
    }).then((value) {
      setState(() {
        isRun = false;
      });
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        if (jsonData['status'] == "1") {
          var sat = jsonData['data']['delivery_boy_status'];
          print('${sat}');
          if (sat == "online") {
            preferences.setInt('duty', 1);
            setState(() {
              status = 1;
            });
          } else {
            preferences.setInt('duty', 0);
            setState(() {
              status = 0;
            });
          }
        }
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isRun = false;
      });
    });
  }

  void _getLocation(context, AppLocalizations locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool isLocationServiceEnableds =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnableds) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        double lat = position.latitude;
        double lng = position.longitude;
        setState(() {
          this.lat = lat;
          this.lng = lng;
        });
        prefs.setString("lat", lat.toString());
        prefs.setString("lng", lng.toString());
        setLocation(lat, lng);
      } else {
        showAlertDialog(context, locale, 'opens');
      }
    } else if (permission == LocationPermission.denied) {
      showAlertDialog(context, locale, 'openp');
    } else if (permission == LocationPermission.deniedForever) {
      showAlertDialog(context, locale, 'openas');
    }
  }

  void performAction(
      BuildContext context, AppLocalizations locale, String type) async {
    if (type == 'opens') {
      Geolocator.openLocationSettings().then((value) {
        if (value) {
          _getLocation(context, locale);
        } else {
          Toast.show(locale.locationPermissionIsRequired, context,
              duration: Toast.LENGTH_SHORT);
        }
      }).catchError((e) {
        Toast.show(locale.locationPermissionIsRequired, context,
            duration: Toast.LENGTH_SHORT);
      });
    } else if (type == 'openp') {
      Geolocator.requestPermission().then((permissiond) {
        if (permissiond == LocationPermission.whileInUse ||
            permissiond == LocationPermission.always) {
          _getLocation(context, locale);
        } else {
          Toast.show(locale.locationPermissionIsRequired, context,
              duration: Toast.LENGTH_SHORT);
        }
      });
    } else if (type == 'openas') {
      Geolocator.openAppSettings().then((value) {
        _getLocation(context, locale);
      }).catchError((e) {
        Toast.show(locale.locationPermissionIsRequired, context,
            duration: Toast.LENGTH_SHORT);
      });
    }
  }

  showAlertDialog(BuildContext context, AppLocalizations locale, String type) {
    Widget clear = GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        performAction(context, locale, type);
      },
      behavior: HitTestBehavior.opaque,
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
            locale.ok,
            style: TextStyle(fontSize: 13, color: kWhiteColor),
          ),
        ),
      ),
    );

    Widget no = GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
      behavior: HitTestBehavior.opaque,
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
            locale.no,
            style: TextStyle(fontSize: 13, color: kWhiteColor),
          ),
        ),
      ),
    );
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(locale.locationheading),
      content: Text(locale.locationheadingSub),
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

  // void _getLocation(AppLocalizations locale, BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always) {
  //     bool isLocationServiceEnableds =
  //         await Geolocator.isLocationServiceEnabled();
  //     if (isLocationServiceEnableds) {
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //       Timer(Duration(seconds: 5), () async {
  //         double lat = position.latitude;
  //         double lng = position.longitude;
  //         prefs.setString("lat", lat.toString());
  //         prefs.setString("lng", lng.toString());
  //         setLocation(lat, lng);
  //       });
  //       Geolocator.getPositionStream(
  //               distanceFilter: 1, intervalDuration: Duration(seconds: 15))
  //           .listen((positionNew) {
  //         double lat = positionNew.latitude;
  //         double lng = positionNew.longitude;
  //         setLocation(lat, lng);
  //       });
  //     } else {
  //       await Geolocator.openLocationSettings().then((value) {
  //         if (value) {
  //           _getLocation(locale,context);
  //         } else {
  //           Toast.show('Location permission is required!', context,
  //               duration: Toast.LENGTH_SHORT);
  //         }
  //       }).catchError((e) {
  //         Toast.show('Location permission is required!', context,
  //             duration: Toast.LENGTH_SHORT);
  //       });
  //     }
  //   } else if (permission == LocationPermission.denied) {
  //     LocationPermission permissiond = await Geolocator.requestPermission();
  //     if (permissiond == LocationPermission.whileInUse ||
  //         permissiond == LocationPermission.always) {
  //       _getLocation(locale,context);
  //     } else {
  //       Toast.show(locale.locationPermissionIsRequired, context,
  //           duration: Toast.LENGTH_SHORT);
  //     }
  //   } else if (permission == LocationPermission.deniedForever) {
  //     await Geolocator.openAppSettings().then((value) {
  //       _getLocation(locale,context);
  //     }).catchError((e) {
  //       Toast.show(locale.locationPermissionIsRequired, context,
  //           duration: Toast.LENGTH_SHORT);
  //     });
  //   }
  // }

  setLocation(lats, lngs) {
    setState(() {
      lat = lats;
      lng = lngs;
      kGooglePlex = CameraPosition(
        target: LatLng(lats, lngs),
        zoom: 19.151926,
      );
      _controller.future.then((value) {
        value.moveCamera(CameraUpdate.newCameraPosition(kGooglePlex));
      });
    });
  }

  void getSharedPref() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      driverName = preferences.getString('delivery_boy_name');
      driverNumber = preferences.getString('delivery_boy_phone');
      imageUrld = Uri.parse(
          '${imageBaseUrl}${preferences.getString('delivery_boy_image')}');
      print('${preferences.getInt('duty')}');
      setState(() {
        status = preferences.getInt('duty');
      });
    });
  }

  void getCurrency() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var currencyUrl = currency;
    var client = http.Client();
    client.get(currencyUrl).then((value) {
      var jsonData = jsonDecode(value.body);
      if (value.statusCode == 200 && jsonData['status'] == "1") {
        print('${jsonData['data'][0]['currency_sign']}');
        preferences.setString(
            'curency', '${jsonData['data'][0]['currency_sign']}');
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enterdFirst) {
      setState(() {
        enterdFirst = true;
      });
      _getLocation(context, locale);
      getSharedPref();
      hitStatusServiced(locale);
      setTimerTask();
    }
    return Scaffold(
      key: scfoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            automaticallyImplyLeading: true,
            leading: GestureDetector(
                onTap: () => scfoldKey.currentState.openDrawer(),
                // onTap: () => getSharedPref(),
                behavior: HitTestBehavior.opaque,
                child: Icon(Icons.menu)),
            title: Text(locale.youAreOnline,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500)),
            actions: <Widget>[
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
                    if (!isRun) {
                      hitStatusService();
                    }
                  },
                  child: Text(
                    '${status == 1 ? locale.goOffline : locale.goOnline}',
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
      ),
      drawer: Account(driverName, driverNumber, imageUrld),
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              mapToolbarEnabled: false,
              buildingsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Visibility(
            visible: isRingBell,
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(bottom: 85, right: 35),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ShakeAnimatedWidget(
                  enabled: isRingBell,
                  duration: Duration(milliseconds: 1500),
                  shakeAngle: Rotation.deg(z: 40),
                  curve: Curves.linear,
                  child: Container(
                    height: 30,
                    width: 25,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(Icons.notifications_active)),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            '${orderCount}',
                            style: TextStyle(
                                color: kGreen,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // child: Text('1'),
        onOpen: () {},
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.2,
        children: [
          MenuItem(
            title: locale.todayOrders,
            titleColor: kWhiteColor,
            subtitle: locale.tapToViewOrders,
            subTitleColor: kWhiteColor,
            backgroundColor: Colors.deepOrange,
            onTap: () => Navigator.pushNamed(context, PageRoutes.todayOrder)
                .then((value) {
              hitTestServices();
            }),
          ),
          MenuItem(
            title: locale.nextDayOrders,
            titleColor: Colors.white,
            subtitle: locale.tapToViewOrders,
            subTitleColor: kWhiteColor,
            backgroundColor: Colors.green,
            onTap: () => Navigator.pushNamed(context, PageRoutes.nextDayOrder)
                .then((value) {
              hitTestServices();
            }),
          ),
        ],
      ),
    );
  }

  void hitTestServices() async {
    preferences = await SharedPreferences.getInstance();
    var client = http.Client();
    var dboy_completed_orderd = today_order_count;
    client.post(dboy_completed_orderd, body: {
      'delivery_boy_id': '${preferences.getInt('delivery_boy_id')}'
    }).then((value) {
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        print('${jsonData.toString()}');
        if (jsonData['status'] == "1") {
          if (jsonData['data'] > 0) {
            orderCount = jsonData['data'];
          }
          if (orderCount > 0) {
            setState(() {
              isRingBell = true;
            });
          } else {
            setState(() {
              isRingBell = false;
            });
          }
        } else {
          if (orderCount > 0) {
            setState(() {
              isRingBell = true;
            });
          } else {
            setState(() {
              isRingBell = false;
            });
          }
        }
      }
    }).catchError((e) {
      if (orderCount > 0) {
        setState(() {
          isRingBell = true;
        });
      } else {
        setState(() {
          isRingBell = false;
        });
      }
      print(e);
    });
  }

  void hitStatusService() async {
    setState(() {
      isRun = true;
    });
    preferences = await SharedPreferences.getInstance();
    dynamic statuss = preferences.getInt('duty');
    var client = http.Client();
    var statusUrl = dboy_status;
    client.post(statusUrl, body: {
      'delivery_boy_id': '${preferences.getInt('delivery_boy_id')}',
      'status': '${statuss == 1 ? 0 : 1}'
    }).then((value) {
      setState(() {
        isRun = false;
      });
      if (value.statusCode == 200 && value.body != null) {
        var jsonData = jsonDecode(value.body);
        DutyOnOff dutyOnOff = DutyOnOff.fromJson(jsonData);
        switch (dutyOnOff.status.toString().trim()) {
          case '0':
            print('0');
            break;
          case '1':
            print('1');
            preferences.setInt('duty', 1);
            setState(() {
              status = preferences.getInt('duty');
            });
            break;
          case '2':
            print('2');
            preferences.setInt('duty', 0);
            setState(() {
              status = preferences.getInt('duty');
            });
            break;
        }
        Toast.show(dutyOnOff.message, context, duration: Toast.LENGTH_SHORT);
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isRun = false;
      });
    });
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // var message = jsonDecode('${payload}');
    _showNotification(flutterLocalNotificationsPlugin, '${title}', '${body}');
  }

  Future selectNotification(String payload) async {}

  void iosPermission(FirebaseMessaging firebaseMessaging) {
    if (Platform.isIOS) {
      firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    // firebaseMessaging.requestNotificationPermissions(
    //     IosNotificationSettings(sound: true, badge: true, alert: true));
    // firebaseMessaging.onIosSettingsRegistered.listen((event) {
    //   print('${event.provisional}');
    // });
  }
}

Future<void> _showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    dynamic title,
    dynamic body) async {
  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('1232', 'Notify', 'Notify On Shopping',
          vibrationPattern: vibrationPattern,
          importance: Importance.max,
          priority: Priority.high,
          enableLights: true,
          enableVibration: true,
          playSound: true,
          ticker: 'ticker');
  final IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(presentSound: true);
  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
      0, '${title}', '${body}', platformChannelSpecifics,
      payload: 'item x');
}

class Account extends StatefulWidget {
  final dynamic driverName;
  final dynamic driverNumber;
  final dynamic imageUrld;

  Account(this.driverName, this.driverNumber, this.imageUrld);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String number;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: UserDetails(
                widget.driverName, widget.driverNumber, widget.imageUrld),
          ),
          Divider(
            color: kCardBackgroundColor,
            thickness: 8.0,
          ),
          BuildListTile(
              image: 'images/account/ic_menu_home.png',
              text: locale.home,
              onTap: () => Navigator.pop(context)),
          BuildListTile(
              image: 'images/account/ic_menu_tncact.png',
              text: locale.termAndCondition,
              onTap: () {
                scfoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(context, PageRoutes.tncPage);
              }),
          BuildListTile(
              image: 'images/account/ic_menu_supportact.png',
              text: locale.support,
              onTap: () {
                scfoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(context, PageRoutes.supportPage,
                    arguments: number);
              }),
          BuildListTile(
            image: 'images/account/ic_menu_aboutact.png',
            text: locale.aboutUs,
            onTap: () {
              scfoldKey.currentState.openEndDrawer();
              Navigator.pushNamed(context, PageRoutes.aboutUsPage);
            },
          ),
          BuildListTile(
              image: 'images/account/ic_menu_supportact.png',
              text: locale.languages,
              onTap: () {
                scfoldKey.currentState.openEndDrawer();
                Navigator.pushNamed(context, PageRoutes.language);
              }),
          Column(
            children: <Widget>[
              BuildListTile(
                  image: 'images/account/ic_menu_insight.png',
                  text: locale.orderHistory,
                  onTap: () {
                    scfoldKey.currentState.openEndDrawer();
                    Navigator.pushNamed(context, PageRoutes.insightPage);
                  }),
              LogoutTile(),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return BuildListTile(
      image: 'images/account/ic_menu_logoutact.png',
      text: locale.logout,
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(locale.loggingOut),
                content: Text(locale.areYouSure),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.clear().then((value) {
                        if (value) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text(
                      locale.no,
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: kTransparentColor)))
                        // RoundedRectangleBorder(
                        //     side: BorderSide(color: kTransparentColor)),
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.clear().then((value) {
                        if (value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              PageRoutes.loginRoot,
                              (Route<dynamic> route) => false);
                        }
                      });
                    },
                    child: Text(
                      locale.yes,
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: kTransparentColor)))
                        // RoundedRectangleBorder(
                        //     side: BorderSide(color: kTransparentColor)),
                        ),
                  )
                  // FlatButton(
                  //     child: ,
                  //     shape: RoundedRectangleBorder(
                  //         side: BorderSide(color: kTransparentColor)),
                  //     textColor: kMainColor,
                  //     onPressed: () async {
                  //       SharedPreferences pref =
                  //           await SharedPreferences.getInstance();
                  //       pref.clear().then((value) {
                  //         if (value) {
                  //           Navigator.pushAndRemoveUntil(context,
                  //               MaterialPageRoute(builder: (context) {
                  //             return LoginNavigator();
                  //           }), (Route<dynamic> route) => false);
                  //         }
                  //       });
                  //     })
                ],
              );
            });
      },
    );
  }
}

class UserDetails extends StatelessWidget {
  final dynamic driverName;
  final dynamic driverNumber;
  final dynamic imageUrld;

  UserDetails(this.driverName, this.driverNumber, this.imageUrld);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 32.0,
                  backgroundImage: NetworkImage('${imageUrld}'),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    scfoldKey.currentState.openEndDrawer();
                    Navigator.pushNamed(context, PageRoutes.editProfile);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('\n' + '${driverName}',
                          style: Theme.of(context).textTheme.bodyText1),
                      Text('\n' + '${driverNumber}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Color(0xff9a9a9a))),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
