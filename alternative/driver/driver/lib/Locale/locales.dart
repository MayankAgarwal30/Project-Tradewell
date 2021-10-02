import 'dart:async';

import 'package:driver/Locale/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static Languages language = Languages();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': language.english(),
    'hi': language.hindi(),
    'es': language.spanish(),
  };


  String get alertloc11 {
    return _localizedValues[locale.languageCode]['alertloc11'];
  }

  String get presstoallow {
    return _localizedValues[locale.languageCode]['presstoallow'];
  }

  String get locationheading {
    return _localizedValues[locale.languageCode]['locationheading'];
  }

  String get locationheadingSub {
    return _localizedValues[locale.languageCode]['locationheadingSub'];
  }

  String get spanish {
    return _localizedValues[locale.languageCode]['spanish'];
  }

  String get englishh {
    return _localizedValues[locale.languageCode]['englishh'];
  }

  String get hindi {
    return _localizedValues[locale.languageCode]['hindi'];
  }

  String get languages {
    return _localizedValues[locale.languageCode]['languages'];
  }

  String get selectPreferredLanguage {
    return _localizedValues[locale.languageCode]['selectPreferredLanguage'];
  }

  String get save {
    return _localizedValues[locale.languageCode]['save'];
  }

  String get bodyText1 {
    return _localizedValues[locale.languageCode]['bodyText1'];
  }

  String get bodyText2 {
    return _localizedValues[locale.languageCode]['bodyText2'];
  }

  String get mobileText {
    return _localizedValues[locale.languageCode]['mobileText'];
  }

  String get continueText {
    return _localizedValues[locale.languageCode]['continueText'];
  }

  String get vegetableText {
    return _localizedValues[locale.languageCode]['vegetableText'];
  }

  String get foodText {
    return _localizedValues[locale.languageCode]['foodText'];
  }

  String get meatText {
    return _localizedValues[locale.languageCode]['meatText'];
  }

  String get medicineText {
    return _localizedValues[locale.languageCode]['medicineText'];
  }

  String get petText {
    return _localizedValues[locale.languageCode]['petText'];
  }

  String get customText {
    return _localizedValues[locale.languageCode]['customText'];
  }

  String get homeText {
    return _localizedValues[locale.languageCode]['homeText'];
  }

  String get orderText {
    return _localizedValues[locale.languageCode]['orderText'];
  }

  String get accountText {
    return _localizedValues[locale.languageCode]['accountText'];
  }

  String get myAccount {
    return _localizedValues[locale.languageCode]['myAccount'];
  }

  String get savedAddresses {
    return _localizedValues[locale.languageCode]['savedAddresses'];
  }

  String get tnc {
    return _localizedValues[locale.languageCode]['tnc'];
  }

  String get support {
    return _localizedValues[locale.languageCode]['support'];
  }

  String get aboutUs {
    return _localizedValues[locale.languageCode]['aboutUs'];
  }

  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get orderHistory{
    return _localizedValues[locale.languageCode]["Order History"];
  }

  String get noGroceryOrderFound{
    return _localizedValues[locale.languageCode]['No grocery order found!'];
  }

  String get noResturantOrderFound{
    return _localizedValues[locale.languageCode]['No restaurant order found!'];
  }

  String get noPharmacyOrderFound{
    return _localizedValues[locale.languageCode]['No pharmacy order found!'];
  }

  String get noOrderFound{
    return _localizedValues[locale.languageCode]['No Order Found!'];
  }

  String get orders{
    return _localizedValues[locale.languageCode]['Orders'];
  }

  String get earnings{
    return _localizedValues[locale.languageCode]['Earnings'];
  }

  String get groceryOrders{
    return _localizedValues[locale.languageCode]['Grocery Orders'];
  }

  String get orderId{
    return _localizedValues[locale.languageCode]['Order Id - #'];
  }

  String get pickupAndDestination{
    return _localizedValues[locale.languageCode]['Pickup and Destination'];
  }

  String get restaurantOrders{
    return _localizedValues[locale.languageCode]['Restaurant Orders'];
  }

  String get pharmacyOrders{
    return _localizedValues[locale.languageCode]['Pharmacy Orders'];
  }

  String get parcelOrders{
    return _localizedValues[locale.languageCode]['Parcel Orders'];
  }

  String get vendorAddress{
    return _localizedValues[locale.languageCode]['Vendor Address'];
  }

  String get pickUpAddress{
    return _localizedValues[locale.languageCode]['Pickup Address'];
  }
  String get destinationAddress{
    return _localizedValues[locale.languageCode]['Destination Address'];
  }

  String get noHistoryFound{
    return _localizedValues[locale.languageCode]['No History found!'];
  }

  String get orWriteUsYourQueries{
    return _localizedValues[locale.languageCode]['Or Write us your queries'];
  }

  String get yourWordsMeansLotToUs{
    return _localizedValues[locale.languageCode]['Your words means a lot to us.'];
  }

  String get phoneNumber{
    return _localizedValues[locale.languageCode]['PHONE NUMBER'];
  }
  String get yourMessage{
    return _localizedValues[locale.languageCode]['YOUR MESSAGE'];
  }
  String get enterYourMessageHere{
    return _localizedValues[locale.languageCode]['Enter your message here'];
  }
  String get submit{
    return _localizedValues[locale.languageCode]['Submit'];
  }

  String get pleaseTryAgain{
    return _localizedValues[locale.languageCode]['Please try again!'];
  }
  String get pleaseEnterValidMobileNumber{
    return _localizedValues[locale.languageCode]['Please enter valid mobile no. and message is not less then 100 words'];
  }
  String get termAndCondition{
    return _localizedValues[locale.languageCode]['Terms & Conditions'];
  }
  String get termsOfUse{
    return _localizedValues[locale.languageCode]['Terms of use'];
  }
  String get locationPermissionIsRequired{
    return _localizedValues[locale.languageCode]['Location permission is required!'];
  }
  String get youAreOnline{
    return _localizedValues[locale.languageCode]['You\'re Online'];
  }
  String get goOffline{
    return _localizedValues[locale.languageCode]['Go Offline'];
  }
  String get goOnline{
    return _localizedValues[locale.languageCode]['Go Online'];
  }
  String get todayOrders{
    return _localizedValues[locale.languageCode]["Today Order's"];
  }
  String get tapToViewOrders{
    return _localizedValues[locale.languageCode]["Tap to view orders"];
  }

  String get nextDayOrders{
    return _localizedValues[locale.languageCode]["Next Day Order's"];
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String get home{
    return _localizedValues[locale.languageCode]['homeText'];
  }
  String get loggingOut{
    return _localizedValues[locale.languageCode]['Logging out'];
  }
  String get areYouSure{
    return _localizedValues[locale.languageCode]['Are you sure?'];
  }
  String get no{
    return _localizedValues[locale.languageCode]['No'];
  }
  String get yes{
    return _localizedValues[locale.languageCode]['Yes'];
  }
  String get enterValidMobileNumber{
    return _localizedValues[locale.languageCode]["Enter valid mobile number!"];
  }
  String get loadingPleaseWait{
    return _localizedValues[locale.languageCode]['Loading please wait!....'];
  }
  String get ok{
    return _localizedValues[locale.languageCode]['OK'];
  }

  String get notice{
    return _localizedValues[locale.languageCode]["Notice"];
  }

  String get yourNumberIsNotVerifiedYet{
    return _localizedValues[locale.languageCode]["Your number is not verified yet. Please contact with customer care."];
  }
 String get verification{
  return _localizedValues[locale.languageCode]['Verification'];
 }
  String get verifyYourPhoneNumber{
    return _localizedValues[locale.languageCode]['Verify your phone number'];
  }
  String get enterOtpCodeHere{
    return _localizedValues[locale.languageCode]["Enter your otp code here."];
  }
  String get didNotYouReceiveAnyCode{
    return _localizedValues[locale.languageCode]["Didn't you receive any code?"];
  }
  String get resendNewCode{
    return _localizedValues[locale.languageCode]["RESEND NEW CODE"];
  }
  String get verify{
    return _localizedValues[locale.languageCode]['Verify'];
  }
  String get profile{
    return _localizedValues[locale.languageCode]['Profile'];
  }
  String get featureImage{
    return _localizedValues[locale.languageCode]["FEATURE IMAGE"];
  }
  String get profileInfo{
    return _localizedValues[locale.languageCode]["PROFILE INFO"];
  }
  String get fullName{
    return _localizedValues[locale.languageCode]['FULL NAME'];
  }
  String get order{
    return _localizedValues[locale.languageCode]['Order - #'];
  }
  String get close{
    return _localizedValues[locale.languageCode]['Close'];
  }
  String get orderInfo{
    return _localizedValues[locale.languageCode]['Order Info'];
  }
  String get twentyMin{
    return _localizedValues[locale.languageCode]['(20 min)'];
  }
  String get direction{
    return _localizedValues[locale.languageCode]['Direction'];
  }
  String get markedAsPicked{
    return _localizedValues[locale.languageCode]["Marked as Picked"];
  }
  String get orderPicked{
    return _localizedValues[locale.languageCode]['Order Picked'];
  }
  String get someError{
    return _localizedValues[locale.languageCode]['Some error occurred please contact with store.'];
  }
  String get deliverySuccessfully{
    return _localizedValues[locale.languageCode]['Delivered Successfully !'];
  }
  String get thankYouForDeliverSafely{
    return _localizedValues[locale.languageCode]['Thank you for deliver safely & on time.'];
  }
  String get backToHome{
    return _localizedValues[locale.languageCode]['Back to home'];
  }
  String get newOrder{
    return _localizedValues[locale.languageCode]['New Order - #'];
  }
  String get acceptDelivery{
    return _localizedValues[locale.languageCode]["Accept Delivery"];
  }
  String get orderAccepted{
    return _localizedValues[locale.languageCode]['Order Accepted'];
  }
  String get orderNotAccepted{
    return _localizedValues[locale.languageCode]['Order Not Accepted'];
  }
  String get markAsDelivered{
    return _localizedValues[locale.languageCode]["Mark as Delivered"];
  }
  String get cod{
    return _localizedValues[locale.languageCode]["COD"];
  }
  String get cashOnDelivery{
    return _localizedValues[locale.languageCode]['Cash on Delivery'];
  }
  String get paymentStatus{
    return _localizedValues[locale.languageCode]['Payment Status'];
  }
  String get someErrorOccurredPleaseContactWithStore{
    return someError;
  }
  String get product{
    return _localizedValues[locale.languageCode]['Products'];
  }
  String get addons{
    return _localizedValues[locale.languageCode]['Addons'];
  }
  String get orderItemDetail{
    return _localizedValues[locale.languageCode]['Order Item Detail - #'];
  }
  String get deliveryContact{
    return _localizedValues[locale.languageCode]['Delivery Contact'];
  }

  String get getDirection{
    return _localizedValues[locale.languageCode]['Get Direction'];
  }
  String get todayDayOrders{
    return _localizedValues[locale.languageCode]['Today Day Orders'];
  }
  String get itemDetails{
    return _localizedValues[locale.languageCode]['Item Detail'];
  }
  String get productDetail{
    return _localizedValues[locale.languageCode]['Product Detail'];
  }
  String get clearView{
    return _localizedValues[locale.languageCode]['Clear View'];
  }
  String get enterCODAmount{
    return _localizedValues[locale.languageCode]['Enter COD Amount'];
  }
  String get youHaveFilledIncorrectAmount{
    return _localizedValues[locale.languageCode]['you have filled incorrect amount..'];
  }
  String get pleaseFillTheAmountYouHaveReceivedFromCustomer{
    return _localizedValues[locale.languageCode]['you have filled incorrect amount..'];
  }
  // String get pleaseTryAgain{
  //   return _localizedValues[locale.languageCode]['you have filled incorrect amount..'];
  // }


// 'Please tryAgain!.'

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
