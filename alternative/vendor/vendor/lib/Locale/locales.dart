import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';
import 'package:vendor/Locale/languages.dart';

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
    'ms': language.malay(),
  };



  String get bahasa {
    return _localizedValues[locale.languageCode]['bahasa'];
  }

  String get restartyourapp {
    return _localizedValues[locale.languageCode]['restartyourapp'];
  }

  String get spanish {
    return _localizedValues[locale.languageCode]['spanish'];
  }

  String get wrongotp {
    return _localizedValues[locale.languageCode]['wrongotp'];
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

  String get commission {
    return _localizedValues[locale.languageCode]['commission'];
  }


  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  String get logout1 {
    return _localizedValues[locale.languageCode]['logout1'];
  }
  String get invalidnumber {
    return _localizedValues[locale.languageCode]['invalidnumber'];
  }
  String get loading {
    return _localizedValues[locale.languageCode]['loading'];
  }
  String get alert1 {
    return _localizedValues[locale.languageCode]['alert1'];
  }

  String get verify1 {
    return _localizedValues[locale.languageCode]['verify1'];
  }

  String get otp1 {
    return _localizedValues[locale.languageCode]['otp1'];
  }

  String get otp2 {
    return _localizedValues[locale.languageCode]['otp2'];
  }

  String get resend1 {
    return _localizedValues[locale.languageCode]['resend1'];
  }

  String get verification1 {
    return _localizedValues[locale.languageCode]['verification1'];
  }

  String get Verify1 {
    return _localizedValues[locale.languageCode]['Verify1'];
  }

  String get Orderh1 {
    return _localizedValues[locale.languageCode]['Orderh1'];
  }
  String get searchcategory {
    return _localizedValues[locale.languageCode]['searchcategory'];
  }

  String get Orderh2 {
    return _localizedValues[locale.languageCode]['Orderh2'];
  }

  String get fetching1 {
    return _localizedValues[locale.languageCode]['fetching1'];
  }

  String get norderh1 {
    return _localizedValues[locale.languageCode]['norderh1'];
  }

  String get please1 {
    return _localizedValues[locale.languageCode]['please1'];
  }

  String get incorectnum1 {
    return _localizedValues[locale.languageCode]['incorectnum1'];
  }


  String get support1 {
    return _localizedValues[locale.languageCode]['support1'];
  }

  String get yourqueries {
    return _localizedValues[locale.languageCode]['yourqueries'];
  }

  String get lot1 {
    return _localizedValues[locale.languageCode]['lot1'];
  }

  String get Submit1 {
    return _localizedValues[locale.languageCode]['Submit1'];
  }


  String get terms1 {
    return _localizedValues[locale.languageCode]['terms1'];
  }

  String get terms2 {
    return _localizedValues[locale.languageCode]['terms2'];
  }

  String get storeprofile {
    return _localizedValues[locale.languageCode]['storeprofile'];
  }

  String get  myaccount {
    return _localizedValues[locale.languageCode]['myaccount'];
  }

  String get  logging1 {
    return _localizedValues[locale.languageCode]['logging1'];
  }

  String get  sure1 {
    return _localizedValues[locale.languageCode]['sure1'];
  }

  String get  no1 {
    return _localizedValues[locale.languageCode]['no1'];
  }

  String get  yes1 {
    return _localizedValues[locale.languageCode]['yes1'];
  }

  String get  someitem1 {
    return _localizedValues[locale.languageCode]['someitem1'];
  }

  String get  Products1 {
    return _localizedValues[locale.languageCode]['Products1'];
  }

  String get  outofstock {
    return _localizedValues[locale.languageCode]['outofstock'];
  }

  String get  serverwait {
    return _localizedValues[locale.languageCode]['serverwait'];
  }

  String get  noproductf {
    return _localizedValues[locale.languageCode]['noproductf'];
  }

  String get  proceedorder {
    return _localizedValues[locale.languageCode]['proceedorder'];
  }

  String get  message1 {
    return _localizedValues[locale.languageCode]['message1'];
  }

  String get  deliverydate1 {
    return _localizedValues[locale.languageCode]['deliverydate1'];
  }

  String get  orderdetail {
    return _localizedValues[locale.languageCode]['orderdetail'];
  }

  String get  dateslot {
    return _localizedValues[locale.languageCode]['dateslot'];
  }

  String get  timeslot {
    return _localizedValues[locale.languageCode]['timeslot'];
  }

  String get  timeslot1 {
    return _localizedValues[locale.languageCode]['timeslot1'];
  }

  String get  timeslot2 {
    return _localizedValues[locale.languageCode]['timeslot2'];
  }

  String get  payementinfo {
    return _localizedValues[locale.languageCode]['payementinfo'];
  }

  String get  subtotal {
    return _localizedValues[locale.languageCode]['subtotal'];
  }

  String get  subtotal1 {
    return _localizedValues[locale.languageCode]['subtotal1'];
  }

  String get  servicefee {
    return _localizedValues[locale.languageCode]['servicefee'];
  }

  String get  amountpay {
    return _localizedValues[locale.languageCode]['amountpay'];
  }


  String get  deliveryadd {
    return _localizedValues[locale.languageCode]['deliveryadd'];
  }

  String get  outdateordalert1 {
    return _localizedValues[locale.languageCode]['outdateordalert1'];
  }

  String get  outdateordalert {
    return _localizedValues[locale.languageCode]['outdateordalert'];
  }

  String get  itemtitle1 {
    return _localizedValues[locale.languageCode]['itemtitle1'];
  }

  String get  itemcat21 {
    return _localizedValues[locale.languageCode]['itemcat21'];
  }

  String get  itemprice1 {
    return _localizedValues[locale.languageCode]['itemprice1'];
  }

  String get  itemprice2 {
    return _localizedValues[locale.languageCode]['itemprice2'];
  }

  String get  itemmrp1 {
    return _localizedValues[locale.languageCode]['itemmrp1'];
  }

  String get  itemmrp2 {
    return _localizedValues[locale.languageCode]['itemmrp2'];
  }

  String get  itemqnt1 {
    return _localizedValues[locale.languageCode]['itemqnt1'];
  }

  String get  itemqnt2 {
    return _localizedValues[locale.languageCode]['itemqnt2'];
  }

  String get  itemunit1 {
    return _localizedValues[locale.languageCode]['itemunit1'];
  }

  String get  itemunit2 {
    return _localizedValues[locale.languageCode]['itemunit2'];
  }

  String get  updateinfo {
    return _localizedValues[locale.languageCode]['updateinfo'];
  }

  String get  pw1 {
    return _localizedValues[locale.languageCode]['pw1'];
  }
  String get  stock1 {
    return _localizedValues[locale.languageCode]['stock1'];
  }

  String get  stock2 {
    return _localizedValues[locale.languageCode]['stock2'];
  }

  String get  itemtitle2 {
    return _localizedValues[locale.languageCode]['itemtitle2'];
  }

  String get  fetchingpro {
    return _localizedValues[locale.languageCode]['fetchingpro'];
  }

  String get  updatingpleasewait {
    return _localizedValues[locale.languageCode]['updatingpleasewait'];
  }

  String get  myorder {
    return _localizedValues[locale.languageCode]['myorder'];
  }

  String get  myorder1 {
    return _localizedValues[locale.languageCode]['myorder1'];
  }

  String get  fetchingdata {
    return _localizedValues[locale.languageCode]['fetchingdata'];
  }

  String get  fetchingdata1 {
    return _localizedValues[locale.languageCode]['fetchingdata1'];
  }

  String get  fetchingdata2 {
    return _localizedValues[locale.languageCode]['fetchingdata2'];
  }

  String get  deliveryboy1 {
    return _localizedValues[locale.languageCode]['deliveryboy1'];
  }

  String get  orderid1 {
    return _localizedValues[locale.languageCode]['orderid1'];
  }

  String get  item {
    return _localizedValues[locale.languageCode]['item'];
  }

  String get  orderprice {
    return _localizedValues[locale.languageCode]['orderprice'];
  }

  String get  remainamt {
    return _localizedValues[locale.languageCode]['remainamt'];
  }

  String get  paymethod {
    return _localizedValues[locale.languageCode]['paymethod'];
  }

  String get  paystatus {
    return _localizedValues[locale.languageCode]['paystatus'];
  }

  String get  delpartner {
    return _localizedValues[locale.languageCode]['delpartner'];
  }

  String get  delboy {
    return _localizedValues[locale.languageCode]['delboy'];
  }

  String get  timeupdated {
    return _localizedValues[locale.languageCode]['timeupdated'];
  }

  String get  somethingwent {
    return _localizedValues[locale.languageCode]['somethingwent'];
  }

  String get  addpv {
    return _localizedValues[locale.languageCode]['addpv'];
  }

  String get  addpv1 {
    return _localizedValues[locale.languageCode]['addpv1'];
  }

  String get  GoOffline {
    return _localizedValues[locale.languageCode]['GoOffline'];
  }

  String get  NEWORDERS {
    return _localizedValues[locale.languageCode]['NEWORDERS'];
  }

  String get  CREATEORDERS {
    return _localizedValues[locale.languageCode]['CREATEORDERS'];
  }

  String get  updateaddon {
    return _localizedValues[locale.languageCode]['updateaddon'];
  }

  String get  NEXTDAYORDERS {
    return _localizedValues[locale.languageCode]['NEXTDAYORDERS'];
  }

  String get  addadon {
    return _localizedValues[locale.languageCode]['addadon'];
  }

  String get  addadontitle {
    return _localizedValues[locale.languageCode]['addadontitle'];
  }

  String get  addadontitle1 {
    return _localizedValues[locale.languageCode]['addadontitle1'];
  }


  String get  GoOnline {
    return _localizedValues[locale.languageCode]['GoOnline'];
  }

  String get  deliveryboy {
    return _localizedValues[locale.languageCode]['deliveryboy'];
  }


  String get  updatecharges {
    return _localizedValues[locale.languageCode]['updatecharges'];
  }

  String get  updatecharges1 {
    return _localizedValues[locale.languageCode]['updatecharges1'];
  }

  String get  aredelcharge {
    return _localizedValues[locale.languageCode]['aredelcharge'];
  }


  String get  AddCityCharge {
    return _localizedValues[locale.languageCode]['AddCityCharge'];
  }

  String get  AddCityCharge1 {
    return _localizedValues[locale.languageCode]['AddCityCharge1'];
  }

  String get  imgupdate {
    return _localizedValues[locale.languageCode]['imgupdate'];
  }

  String get  editprofile {
    return _localizedValues[locale.languageCode]['editprofile'];
  }

  String get  photolibrary {
    return _localizedValues[locale.languageCode]['photolibrary'];
  }

  String get  Camera {
    return _localizedValues[locale.languageCode]['Camera'];
  }

  String get  featureimg {
    return _localizedValues[locale.languageCode]['featureimg'];
  }

  String get  uploadpic {
    return _localizedValues[locale.languageCode]['uploadpic'];
  }

  String get  storeinfo {
    return _localizedValues[locale.languageCode]['storeinfo'];
  }

  String get  address {
    return _localizedValues[locale.languageCode]['address'];
  }

  String get  storetiming {
    return _localizedValues[locale.languageCode]['storetiming'];
  }

  String get  openingtime {
    return _localizedValues[locale.languageCode]['openingtime'];
  }

  String get  closingtime {
    return _localizedValues[locale.languageCode]['closingtime'];
  }

  String get  updatestore {
    return _localizedValues[locale.languageCode]['updatestore'];
  }

  String get  addproduct {
    return _localizedValues[locale.languageCode]['addproduct'];
  }

  String get  itemimg {
    return _localizedValues[locale.languageCode]['itemimg'];
  }

  String get  iteminfo {
    return _localizedValues[locale.languageCode]['iteminfo'];
  }

  String get  itemcat {
    return _localizedValues[locale.languageCode]['itemcat'];
  }

  String get  itemcat1 {
    return _localizedValues[locale.languageCode]['itemcat1'];
  }

  String get  itemcat2 {
    return _localizedValues[locale.languageCode]['itemcat2'];
  }

  String get  itemcat3 {
    return _localizedValues[locale.languageCode]['itemcat3'];
  }

  String get  productadd {
    return _localizedValues[locale.languageCode]['productadd'];
  }

  String get  addprodetail {
    return _localizedValues[locale.languageCode]['addprodetail'];
  }

  String get  somethingwent1 {
    return _localizedValues[locale.languageCode]['somethingwent1'];
  }

  String get  comissionorder {
    return _localizedValues[locale.languageCode]['comissionorder'];
  }

  String get  claim {
    return _localizedValues[locale.languageCode]['claim'];
  }

  String get  productupdate {
    return _localizedValues[locale.languageCode]['productupdate'];
  }

  String get  enterproduct {
    return _localizedValues[locale.languageCode]['enterproduct'];
  }

  String get  editpro {
    return _localizedValues[locale.languageCode]['editpro'];
  }

  String get  alert {
    return _localizedValues[locale.languageCode]['alert'];
  }

  String get  delpro {
    return _localizedValues[locale.languageCode]['delpro'];
  }

  String get  myproduct {
    return _localizedValues[locale.languageCode]['myproduct'];
  }

  String get  addvariant {
    return _localizedValues[locale.languageCode]['addvariant'];
  }

  String get  nodatacat {
    return _localizedValues[locale.languageCode]['nodatacat'];
  }

  String get  addprovariant {
    return _localizedValues[locale.languageCode]['addprovariant'];
  }

  String get  provaradd {
    return _localizedValues[locale.languageCode]['provaradd'];
  }

  String get  enterpro1 {
    return _localizedValues[locale.languageCode]['enterpro1'];
  }

  String get  charadd {
    return _localizedValues[locale.languageCode]['charadd'];
  }

  String get  addcharge {
    return _localizedValues[locale.languageCode]['addcharge'];
  }

  String get  citylist {
    return _localizedValues[locale.languageCode]['citylist'];
  }

  String get  charpricedes {
    return _localizedValues[locale.languageCode]['charpricedes'];
  }

  String get  countrycharlist {
    return _localizedValues[locale.languageCode]['countrycharlist'];
  }

  String get  cureentcharupdate {
    return _localizedValues[locale.languageCode]['cureentcharupdate'];
  }

  String get  editchar {
    return _localizedValues[locale.languageCode]['editchar'];
  }

  String get  pickupadd {
    return _localizedValues[locale.languageCode]['pickupadd'];
  }

  String get  destinationadd {
    return _localizedValues[locale.languageCode]['destinationadd'];
  }

  String get  parcelweight {
    return _localizedValues[locale.languageCode]['parcelweight'];
  }

  String get  distance {
    return _localizedValues[locale.languageCode]['distance'];
  }

  String get  driveoffnow {
    return _localizedValues[locale.languageCode]['driveoffnow'];
  }

  String get  oneparcel {
    return _localizedValues[locale.languageCode]['oneparcel'];
  }

  String get  addoninfo {
    return _localizedValues[locale.languageCode]['addoninfo'];
  }

  String get  updateproduct {
    return _localizedValues[locale.languageCode]['updateproduct'];
  }

  String get  addaddon {
    return _localizedValues[locale.languageCode]['addaddon'];
  }

  String get  deladdon {
    return _localizedValues[locale.languageCode]['deladdon'];
  }

  String get  novarproduct {
    return _localizedValues[locale.languageCode]['novarproduct'];
  }

  String get  addon1 {
    return _localizedValues[locale.languageCode]['addon1'];
  }

  String get  addonupdate {
    return _localizedValues[locale.languageCode]['addonupdate'];
  }

  String get  proupd1 {
    return _localizedValues[locale.languageCode]['proupd1'];
  }

  String get  pwd1 {
    return _localizedValues[locale.languageCode]['pwd1'];
  }

  String get  customer {
    return _localizedValues[locale.languageCode]['customer'];
  }

  String get  invoiceprint {
    return _localizedValues[locale.languageCode]['invoiceprint'];
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

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi', 'es','ms'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
