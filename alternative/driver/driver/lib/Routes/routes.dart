import 'package:driver/Account/UI/ListItems/about_us_page.dart';
import 'package:driver/Account/UI/ListItems/insight_page.dart';
import 'package:driver/Account/UI/ListItems/support_page.dart';
import 'package:driver/Account/UI/ListItems/tnc_page.dart';
import 'package:driver/Account/UI/account_page.dart';
import 'package:driver/Auth/MobileNumber/UI/phone_number.dart';
import 'package:driver/Auth/Verification/UI/verification_page.dart';

import 'package:driver/DeliveryPartnerProfile/store_profile.dart';
import 'package:driver/Locale/select_language.dart';
import 'package:driver/OrderMap/UI/accepted.dart';
import 'package:driver/OrderMap/UI/delivery_successful.dart';
import 'package:driver/OrderMap/UI/new_delivery.dart';
import 'package:driver/OrderMap/UI/onway.dart';
import 'package:driver/orderpage/itemdetailspage.dart';
import 'package:driver/orderpage/nextdayorder.dart';
import 'package:driver/orderpage/restaurantorderpage/acceptpagerest.dart';
import 'package:driver/orderpage/restaurantorderpage/newdelivery_rest.dart';
import 'package:driver/orderpage/restaurantorderpage/restonwaypage.dart';
import 'package:driver/orderpage/todayorderpage.dart';
import 'package:driver/parcel/acceptparcelpage.dart';
import 'package:driver/parcel/itemdetailparcel.dart';
import 'package:driver/parcel/newdeliveryparcelpage.dart';
import 'package:driver/parcel/onwayparcelpage.dart';
import 'package:driver/pharmacy/acceptpharmapage.dart';
import 'package:driver/pharmacy/newdeliverypharmapage.dart';
import 'package:driver/pharmacy/onwaypharmapage.dart';
import 'package:driver/pharmacy/pharmaitemdetails.dart';
import 'package:driver/signature/signatureview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String accountPage = 'account_page';
  static const String tncPage = 'tnc_page';
  static const String aboutUsPage = 'about_us_page';
  static const String supportPage = 'support_page';
  static const String deliverySuccessful = 'delivery_successful';
  static const String insightPage = 'insight_page';
  static const String editProfile = 'store_profile';
  static const String newDeliveryPage = 'new_delivery_page';
  static const String acceptedPage = 'accepted_page';
  static const String onWayPage = 'on_way_page';
  static const String todayOrder = 'todayOrder';
  static const String nextDayOrder = 'nextDayOrder';
  static const String itemDetails = 'itemDetails';
  static const String signatureView = 'signatureView';
  static const String restonway = 'restonway';
  static const String restacceptpage = 'restacceptpage';
  static const String pharmaacceptpage = 'pharmaacceptpage';
  static const String newdeliveryrest = 'newdeliveryrest';
  static const String newdeliverypharma = 'newdeliverypharma';
  static const String pharmaonway = 'pharmaonway';
  static const String parcelonway = 'parcelonway';
  static const String newdeliveryparcel = 'newdeliveryparcel';
  static const String parcelacceptpage = 'parcelacceptpage';
  static const String itemDetailsparcel = 'itemDetailsparcel';
  static const String itemDetailsPh = 'itemDetailsph';
  static const String language = 'language';
  static const String loginRoot = 'login/';
  static const String verification = 'login/verification';

  Map<String, WidgetBuilder> routes() {
    return {
      accountPage: (context) => AccountPage(),
      tncPage: (context) => TncPage(),
      aboutUsPage: (context) => AboutUsPage(),
      supportPage: (context) => SupportPage(),
      deliverySuccessful: (context) => DeliverySuccessful(),
      insightPage: (context) => InsightPage(),
      editProfile: (context) => ProfilePage(),
      newDeliveryPage: (context) => NewDeliveryPage(),
      acceptedPage: (context) => AcceptedPage(),
      onWayPage: (context) => OnWayPage(),
      todayOrder: (context) => TodayDayOrder(),
      nextDayOrder: (context) => NextDayOrder(),
      itemDetails: (context) => ItemDetails(),
      signatureView: (context) => SignatureView(),
      restonway: (context) => OnWayPageRest(),
      pharmaonway: (context) => OnWayPagePharma(),
      restacceptpage: (context) => AcceptedPageRest(),
      pharmaacceptpage: (context) => AcceptedPagePharma(),
      newdeliveryrest: (context) => NewDeliveryRestPage(),
      newdeliverypharma: (context) => NewDeliveryPharmaPage(),
      parcelonway: (context) => OnWayPageParcel(),
      newdeliveryparcel: (context) => NewDeliveryParcelPage(),
      parcelacceptpage: (context) => AcceptedPageParcel(),
      itemDetailsparcel: (context) => ItemDetailsParcel(),
      itemDetailsPh: (context) => OrderInfoDetailsPharma(),
      language: (context) => ChooseLanguage(),
      loginRoot: (context) => PhoneNumber(),
      verification: (context) => VerificationPage(),
    };
  }
}
