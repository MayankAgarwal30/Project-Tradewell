import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/Auth/MobileNumber/UI/phone_number.dart';
import 'package:vendor/Auth/Verification/UI/verification_page.dart';

import 'package:vendor/OrderItemAccount/Account/UI/ListItems/about_us_page.dart';
import 'package:vendor/OrderItemAccount/Account/UI/ListItems/insight_page.dart';
import 'package:vendor/OrderItemAccount/Account/UI/ListItems/support_page.dart';
import 'package:vendor/OrderItemAccount/Account/UI/ListItems/tnc_page.dart';
import 'package:vendor/OrderItemAccount/Account/UI/account_page.dart';
import 'package:vendor/OrderItemAccount/Order/UI/order_page.dart';
import 'package:vendor/OrderItemAccount/Order/UI/orderinfo_page.dart';
import 'package:vendor/OrderItemAccount/StoreProfile/store_profile.dart';
import 'package:vendor/OrderItemAccount/createorderpage/createorderpagegrocery.dart';
import 'package:vendor/OrderItemAccount/createorderpage/orderdetailgrocery.dart';
import 'package:vendor/OrderItemAccount/order_item_account.dart';
import 'package:vendor/Pages/additem.dart';
import 'package:vendor/Pages/commissionpae.dart';
import 'package:vendor/Pages/edititem.dart';
import 'package:vendor/Pages/invoicepage.dart';
import 'package:vendor/Pages/items.dart';
import 'package:vendor/Pages/parcelinvoicepdf.dart';
import 'package:vendor/Pages/restinvoicepage.dart';
import 'package:vendor/Pages/varaintadd.dart';
import 'package:vendor/UI/select_language.dart';
import 'package:vendor/parcel/addcharges.dart';
import 'package:vendor/parcel/editcharge.dart';
import 'package:vendor/parcel/orderhistoryparcel.dart';
import 'package:vendor/parcel/parcelmainpage.dart';
import 'package:vendor/parcel/parcelorderinfo.dart';
import 'package:vendor/pharmacy/addaddonpharma.dart';
import 'package:vendor/pharmacy/additemrestpharma.dart';
import 'package:vendor/pharmacy/addvarientpharma.dart';
import 'package:vendor/pharmacy/edititempharma.dart';
import 'package:vendor/pharmacy/order_item_account_pharma.dart';
import 'package:vendor/pharmacy/orderhistorypagepharma.dart';
import 'package:vendor/pharmacy/updateaddonpharma.dart';
import 'package:vendor/pharmacy/updateitempharma.dart';
import 'package:vendor/restaturant/addaddon.dart';
import 'package:vendor/restaturant/additemrest.dart';
import 'package:vendor/restaturant/addvarientrest.dart';
import 'package:vendor/restaturant/edititemrest.dart';
import 'package:vendor/restaturant/order_item_account_rest.dart';
import 'package:vendor/restaturant/orderhistorypage.dart';
import 'package:vendor/restaturant/orderinforest.dart';
import 'package:vendor/restaturant/updateaddon.dart';
import 'package:vendor/restaturant/updateitemrest.dart';

class PageRoutes {
  static const String locationPage = 'location_page';
  static const String orderItemAccountPage = 'order_item_account';
  static const String orderItemAccountPageRest = 'order_item_account_rest';
  static const String accountPage = 'account_page';
  static const String orderPage = 'order_page';
  static const String orderInfoPage = 'orderinfo_page';
  static const String orderInfoPageRest = 'orderinfo_pagerest';
  static const String tncPage = 'tnc_page';
  static const String aboutUsPage = 'about_us_page';
  static const String savedAddressesPage = 'saved_addresses_page';
  static const String supportPage = 'support_page';
  static const String insightPage = 'insight_page';
  static const String storeProfile = 'store_profile';
  static const String addItem = 'additem';
  static const String addcharges = 'addcharges';
  static const String addItemRest = 'addItemRest';
  static const String editItem = 'edititem';
  static const String editcharge = 'editcharge';
  static const String editItemRest = 'editItemRest';
  static const String Items = 'items';
  static const String addVaraintItem = 'addVaraintItem';
  static const String addVaraintItemRest = 'addVaraintItemRest';
  static const String commission = 'commission';
  static const String insightpagerest = 'insightpagerest';
  static const String addItemaddonrest = 'addItemaddonrest';
  static const String updaterestaddon = 'updaterestaddon';
  static const String updateitemrest = 'updateitemrest';
  static const String createOrderPageGrocery = 'createOrderPageGrocery';
  static const String createOrderDetails = 'createOrderDetails';
  static const String language = 'language';
  static const String invoicepdf = 'invoicepdf';
  static const String invoicepdfrest = 'invoicepdfrest';
  static const String invoicepdfparcel = 'invoicepdfparcel';

//pharma
  static const String addItemPharma = 'addItemPharma';
  static const String insightpagepharma = 'insightpagepharma';
  static const String editItemPharma = 'editItemPharma';
  static const String addVaraintItemPharma = 'addVaraintItemPharma';
  static const String addItemaddonpharma = 'addItemaddonpharma';
  static const String updateitempharma = 'updateitempharma';
  static const String updatepharmaaddon = 'updatepharmaaddon';
  static const String orderItemAccountPharma = 'orderItemAccountPharma';

  //parcel
  static const String orderItemAccountparcel = 'orderItemAccountparcel';
  static const String insightpageparcel = 'insightpageparcel';
  static const String orderInfoPageparcel = 'orderInfoPageparcel';

  static const String loginRoot = 'login/';
  static const String verification = 'login/verification';

  Map<String, WidgetBuilder> routes() {
    return {
      orderPage: (context) => OrderPage(),
      orderInfoPage: (context) => OrderInfo(),
      orderInfoPageRest: (context) => OrderInfoRest(),
      orderInfoPageparcel: (context) => OrderInfoParcel(),
      accountPage: (context) => AccountPage(),
      tncPage: (context) => TncPage(),
      aboutUsPage: (context) => AboutUsPage(),
      supportPage: (context) => SupportPage(),
      insightPage: (context) => InsightPage(),
      storeProfile: (context) => ProfilePage(),
      addItem: (context) => AddItem(),
      addItemRest: (context) => AddItemRest(),
      addItemPharma: (context) => AddItemPharma(),
      editItem: (context) => EditItem(),
      editItemRest: (context) => EditItemRest(),
      editItemPharma: (context) => EditItemPharma(),
      Items: (context) => ItemsPage(),
      orderItemAccountPage: (context) => OrderItemAccount(),
      orderItemAccountPageRest: (context) => OrderItemAccountRest(),
      orderItemAccountPharma: (context) => OrderItemAccountPharma(),
      addVaraintItem: (context) => AddVaraintItem(),
      addVaraintItemRest: (context) => AddVaraintRestItem(),
      addVaraintItemPharma: (context) => AddVaraintPharmaItem(),
      commission: (context) => CommissionPage(),
      insightpagerest: (context) => InsightPageRest(),
      insightpagepharma: (context) => InsightPagePharma(),
      addItemaddonrest: (context) => AddItemAddOnRest(),
      addItemaddonpharma: (context) => AddItemAddOnPharma(),
      updaterestaddon: (context) => UpdateAddOnRest(),
      updatepharmaaddon: (context) => UpdateAddOnPharma(),
      updateitemrest: (context) => UpdateItemRest(),
      updateitempharma: (context) => UpdateItemPharma(),
      addcharges: (context) => AddChargesStateless(),
      editcharge: (context) => EditChargesStateless(),
      orderItemAccountparcel: (context) => OrderParcelItemAccount(),
      insightpageparcel: (context) => InsightPageParcel(),
      createOrderPageGrocery: (context) => CreateOrderPageGrocery(),
      createOrderDetails: (context) => CartOrderDetails(),
      language: (context) => ChooseLanguage(),
      invoicepdf: (context) => MyInvoicePdf(),
      invoicepdfrest: (context) => MyInvoiceRestPdf(),
      invoicepdfparcel: (context) => MyParcelInvoicePdf(),
      loginRoot: (context) => PhoneNumber(),
      verification: (context) => VerificationPage(),
    };
  }
}
