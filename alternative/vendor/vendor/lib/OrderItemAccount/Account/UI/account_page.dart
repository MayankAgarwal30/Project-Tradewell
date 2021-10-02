import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vendor/Components/list_tile.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/baseurl/baseurl.dart';

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

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.myaccount, style: Theme.of(context).textTheme.bodyText1),
        centerTitle: true,
      ),
      body: Account(),
    );
  }
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String number;
  dynamic storeId;
  dynamic storeName;
  dynamic storeOwnerName;
  dynamic storeNumber;
  dynamic vendorLoc;
  dynamic storeImage;
  dynamic uiType;
  String _date = "Not set";
  String _time = "Not set";

  @override
  void initState() {
    getStoreDetails();
    super.initState();
    setFirebase();
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
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
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

  void getStoreDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      storeId = pref.getInt("vendor_id");
      storeName = pref.getString("vendor_name");
      storeOwnerName = pref.getString("owner");
      storeNumber = pref.getString("vendor_phone");
      vendorLoc = pref.getString("vendor_loc");
      storeImage = pref.getString("vendor_logo");
      uiType = pref.getString("ui_type");
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return ListView(
      children: <Widget>[
        StoreDetails(storeId, storeName, storeOwnerName, storeNumber, vendorLoc,
            storeImage),
        Divider(
          color: kCardBackgroundColor,
          thickness: 8.0,
        ),
        BuildListTile(
            image: 'images/account/ic_menu_tncact.png',
            text: locale.terms2,
            onTap: () => Navigator.pushNamed(context, PageRoutes.tncPage)),
        BuildListTile(
            image: 'images/account/ic_menu_supportact.png',
            text: locale.support,
            onTap: () => Navigator.pushNamed(context, PageRoutes.supportPage,
                arguments: number)),
        BuildListTile(
          image: 'images/account/ic_menu_aboutact.png',
          text: locale.aboutUs,
          onTap: () => Navigator.pushNamed(context, PageRoutes.aboutUsPage),
        ),
        BuildListTile(
          image: 'images/account/ic_menu_aboutact.png',
          text: locale.commission,
          onTap: () => Navigator.pushNamed(context, PageRoutes.commission),
        ),
        BuildListTile(
            image: 'images/account/ic_menu_supportact.png',
            text: locale.languages,
            onTap: () => Navigator.pushNamed(context, PageRoutes.language)),
        Column(
          children: <Widget>[
            BuildListTile(
                image: 'images/account/ic_menu_insight.png',
                text: locale.Orderh1,
                onTap: () async {
                  await SharedPreferences.getInstance().then((value) {
                    uiType = value.getString("ui_type");
                    if (uiType != null && uiType == "2") {
                      Navigator.pushNamed(context, PageRoutes.insightpagerest);
                    }
                    if (uiType != null && uiType == "3") {
                      Navigator.pushNamed(
                          context, PageRoutes.insightpagepharma);
                    }
                    if (uiType != null && uiType == "4") {
                      Navigator.pushNamed(
                          context, PageRoutes.insightpageparcel);
                    } else if (uiType != null && uiType == "1") {
                      Navigator.pushNamed(context, PageRoutes.insightPage);
                    }
                  });
                }),
            LogoutTile(),
          ],
        ),
      ],
    );
  }
}

class LogoutTile extends StatelessWidget {
  const LogoutTile({
    Key key,
  }) : super(key: key);

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
                title: Text(locale.logging1),
                content: Text(locale.sure1),
                actions: <Widget>[
                  FlatButton(
                    child: Text(locale.no1),
                    textColor: kMainColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                      child: Text(locale.yes1),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: kTransparentColor)),
                      textColor: kMainColor,
                      onPressed: () async {
                        // Phoenix.rebirth(context);
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.clear().then((value) {
                          if (value) {
                            Navigator.of(context).pushNamedAndRemoveUntil(PageRoutes.loginRoot, (route) => false);
                          }
                        });
                      })
                ],
              );
            });
      },
    );
  }
}

class StoreDetails extends StatefulWidget {
  final dynamic storeId;
  final dynamic storeName;
  final dynamic storeOwnerName;
  final dynamic storeNumber;
  final dynamic vendorLoc;
  final dynamic storeImage;

  StoreDetails(this.storeId, this.storeName, this.storeOwnerName,
      this.storeNumber, this.vendorLoc, this.storeImage);

  @override
  State<StatefulWidget> createState() {
    return StoreDetailsState();
  }
}

class StoreDetailsState extends State<StoreDetails> {
  dynamic storeImg;

  @override
  void initState() {
    storeImg = widget.storeImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 98.0,
            width: 98.0,
            child: (storeImg != null)
                ? Image.network('${imageBaseUrl}${storeImg}')
                : Image.asset('images/layer_1.png'),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.storeName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 15.0, fontWeight: FontWeight.w500)),
                SizedBox(height: 8.0),
                Text('${widget.vendorLoc}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Color(0xff4a4b48), fontSize: 13.3)),
                GestureDetector(
                    child: Text(
                      '\n' + locale.storeprofile,
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: 13.3,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, PageRoutes.storeProfile)
                            .then((value) async {
                          SharedPreferences profilePref =
                              await SharedPreferences.getInstance();
                          setState(() {
                            storeImg = profilePref.getString("vendor_logo");
                          });
                        })),
              ],
            ),
          ),
        ],
      ),
    );
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
  AndroidNotificationDetails('7458', 'Notify', 'Notify On Shopping',
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