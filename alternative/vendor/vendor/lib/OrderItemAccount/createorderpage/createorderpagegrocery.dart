
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Components/bottom_bar.dart';
import 'package:vendor/Components/custom_appbar.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/baseurl/baseurl.dart';
import 'package:vendor/orderbean/productbean.dart';
import 'package:vendor/orderbyimage/beanmodel/createorderbean.dart';
import 'package:vendor/orderbyimage/beanmodel/productimagebeam.dart';
import 'package:http/http.dart' as http;

class CreateOrderPageGrocery extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CreateOrderPageGroceryState();
  }

}

class CreateOrderPageGroceryState extends State<CreateOrderPageGrocery> {
  bool isSearchOpen = false;
  bool isFetch = false;
  dynamic imageUrl;
  dynamic curency;
  COImageDataBean orderDetails;
  List<ProductCartItemV> cartitemList = [];
  TextEditingController searchController = TextEditingController();
  List<ProductNameList> orederImageList = [];



  var indexSelected = 0;

  int selectedQnty = 0;

  void setList2() {
    if (searchController != null && searchController.text.length > 0) {
      setState(() {
        searchController.clear();
        // productVarientList.clear();
        // productVarientList = List.from(productVarientListSearch);
      });
    } else {
      setState(() {
        isSearchOpen = false;
        // productVarientList.clear();
        // productVarientList = List.from(productVarientListSearch);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getImageOrderList();
  }


  void getImageOrderList() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isFetch = true;
      curency = pref.getString('curency');
    });
    orederImageList = [];
    var vendorId = pref.getInt('vendor_id');
    var ui_type = pref.getString('ui_type');
    print('vendor_id ${vendorId}');
    var client = http.Client();
    dynamic todayOrderUrl = "";
    if(ui_type == "1"){
     todayOrderUrl = store_allproduct;
    }else if(ui_type == "3"){
      todayOrderUrl = pharmacy_allproducts;
    }

    client
        .post(todayOrderUrl, body: {'vendor_id': '${vendorId}'}).then((value) {
      print('${value.body}');
      if (value.statusCode == 200) {
        if (value.body
            .toString()
            .contains("[{\"order_details\":\"no orders found\"}]") ||
            value.body
                .toString()
                .contains("[{\"no_order\":\"no orders found\"}]")) {
          setState(() {
            orederImageList.clear();
            isFetch = false;
          });
        } else {
          ProductB orderImageBean = ProductB.fromJson(jsonDecode(value.body));
          List<ProductNameList> oreder = orderImageBean.data;
          print('${oreder.toString()}');
          if (oreder != null && oreder.length > 0) {
            setState(() {
              isFetch = false;
              orederImageList = List.from(oreder);
            });
          } else {
            setState(() {
              orederImageList.clear();
              isFetch = false;
            });
          }
        }
      }
      else {
        setState(() {
          orederImageList.clear();
          isFetch = false;
        });
      }
    }).catchError((e) {
      setState(() {
        isFetch = false;
      });
      print(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    double appbarsize = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    final Map<String, Object> dataObject = ModalRoute.of(context).settings.arguments;
    setState(() {
      orderDetails = dataObject['orderdetails'];
      curency = dataObject['curency'];
    });

    return WillPopScope(
      onWillPop: () async {
        if (isSearchOpen) {
          // setList2();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            PreferredSize(
              preferredSize: Size.fromHeight(appbarsize),
              child: Stack(
                children: [
                  CustomAppBar(
                    leading: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(Icons.arrow_back_ios_rounded,size: 25,color: kMainTextColor,),
                    ),
                    titleWidget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text(locale.Products1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: kMainTextColor)),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: kHintColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isSearchOpen = !isSearchOpen;
                              });
                            }),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isSearchOpen,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: appbarsize,
                      color: kWhiteColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: scaffoldBgColor,
                        ),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: kHintColor,
                            ),
                            hintText: locale.searchcategory,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSearchOpen = !isSearchOpen;
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: kHintColor,
                              ),
                            ),
                          ),
                          cursorColor: kMainColor,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              // productVarientList = productVarientListSearch
                              //     .where((element) => element.product_name
                              //     .toString()
                              //     .toLowerCase()
                              //     .contains(value.toLowerCase()))
                              //     .toList();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 270,
                width: MediaQuery.of(context).size.width,
                child:
                ClipRect(
                  child: PhotoView(
                    imageProvider:  NetworkImage('${Uri.parse('${imageBaseUrl}${orderDetails.list_photo}')}'),
                    // loadFailedChild: Image.asset('images/logos/logo_store.png'),
                    loadingBuilder: (context,_){
                      return Align(
                        widthFactor: 50,
                        heightFactor: 50,
                        child: CircularProgressIndicator(),
                      );
                    },
                    backgroundDecoration: BoxDecoration(
                      color: kWhiteColor
                    ),
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                    minScale: PhotoViewComputedScale.contained,
                    initialScale: PhotoViewComputedScale.contained,
                  ),
                )
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: (orederImageList!=null && orederImageList.length>0)?ListView.builder(
                      itemCount: orederImageList.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                          color: kWhiteColor,
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10.0),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: kWhiteColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('${orederImageList[index].product_name}${(orederImageList[index].variant!=null && orederImageList[index].variant.length>0)? ' - ${orederImageList[index].variant[orederImageList[index].selectedVarient].quantity}':''}${(orederImageList[index].variant!=null && orederImageList[index].variant.length>0)?orederImageList[index].variant[orederImageList[index].selectedVarient].unit:''}',style: Theme.of(
                                      context)
                                      .textTheme
                                      .caption.copyWith(
                                      fontSize: 16,
                                      color: kMainColor
                                  )),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 30.0,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            color: kCardBackgroundColor,
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                          ),
                                          child: (orederImageList[index].variant!=null && orederImageList[index].variant.length>0)
                                              ? DropdownButton<PIVarient>(
                                              underline: Container(
                                                height: 0.0,
                                                color:
                                                kCardBackgroundColor,
                                              ),
                                              value: orederImageList[index].variant[orederImageList[index].selectedVarient],
                                              items: orederImageList[index].variant.map((e) {
                                                return DropdownMenuItem<PIVarient>(
                                                  child: Text(
                                                    '${e.quantity} ${e.unit}',
                                                    style:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                  ),
                                                  value: e,
                                                );
                                              }).toList(),
                                              onChanged: (vale) {
                                                setState(() {
                                                  int indexd =
                                                  orederImageList[index].variant.indexOf(vale);
                                                  if (indexd != -1) {
                                                    orederImageList[index].selectedVarient = indexd;
                                                    int indid = cartitemList.indexOf(ProductCartItemV(orederImageList[index].product_id, orederImageList[index].variant[orederImageList[index].selectedVarient].varient_id, orederImageList[index].product_name,orederImageList[index].variant[orederImageList[index].selectedVarient].price,'${orederImageList[index].variant[orederImageList[index].selectedVarient].quantity}${orederImageList[index].variant[orederImageList[index].selectedVarient].unit}',orederImageList[index].qnty));
                                                    if(indid>-1){
                                                      orederImageList[index].qnty = cartitemList[indid].qnty;
                                                    }else{
                                                      orederImageList[index].qnty = 0;
                                                    }
                                                  }
                                                });
                                              })
                                              : Container(
                                            width: 80,
                                              child: Text('')),
                                        ),
                                      ),
                                      (orederImageList[index].variant!=null && orederImageList[index].variant.length>0)?Text('${curency} ${orederImageList[index].variant[orederImageList[index].selectedVarient].price}'):Text('${curency} 0.0'),
                                      Stack(
                                        children: [
                                          Visibility(
                                            visible:(orederImageList[index].variant!=null && orederImageList[index].variant.length>0)?false:true,
                                            child: Text(locale.outofstock,style: TextStyle(
                                                color: kMainColor
                                            ),),
                                          ),
                                          Visibility(
                                            visible:(orederImageList[index].variant!=null && orederImageList[index].variant.length>0)?true:false,
                                            child: Container(
                                              height: 30.0,
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 11.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kMainColor),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(30.0),
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {

                                                        if(orederImageList[index].qnty>0){
                                                          int indid = cartitemList.indexOf(ProductCartItemV(orederImageList[index].product_id, orederImageList[index].variant[orederImageList[index].selectedVarient].varient_id, orederImageList[index].product_name,orederImageList[index].variant[orederImageList[index].selectedVarient].price,'${orederImageList[index].variant[orederImageList[index].selectedVarient].quantity}${orederImageList[index].variant[orederImageList[index].selectedVarient].unit}',orederImageList[index].qnty));
                                                          orederImageList[index].qnty = orederImageList[index].qnty-1;
                                                          if(orederImageList[index].qnty == 0){
                                                            cartitemList.removeAt(indid);
                                                          }else{
                                                            if(indid>-1){
                                                              cartitemList[indid].qnty = orederImageList[index].qnty;
                                                            }
                                                          }
                                                        }

                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: kMainColor,
                                                      size: 20.0,
                                                      //size: 23.3,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                      '${orederImageList[index].qnty}',
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .caption),
                                                  SizedBox(width: 8.0),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
print('${orederImageList[index].qnty}');
                                                        if(orederImageList[index].qnty>0){
                                                          int indid = cartitemList.indexOf(ProductCartItemV(orederImageList[index].product_id, orederImageList[index].variant[orederImageList[index].selectedVarient].varient_id, orederImageList[index].product_name,orederImageList[index].variant[orederImageList[index].selectedVarient].price,'${orederImageList[index].variant[orederImageList[index].selectedVarient].quantity}${orederImageList[index].variant[orederImageList[index].selectedVarient].unit}',orederImageList[index].qnty));
                                                          orederImageList[index].qnty = orederImageList[index].qnty+1;
                                                          if(indid>-1){
                                                            cartitemList[indid].qnty = orederImageList[index].qnty;
                                                          }
                                                        }else{
                                                          orederImageList[index].qnty = orederImageList[index].qnty+1;
                                                          cartitemList.add(ProductCartItemV(orederImageList[index].product_id, orederImageList[index].variant[orederImageList[index].selectedVarient].varient_id, orederImageList[index].product_name,orederImageList[index].variant[orederImageList[index].selectedVarient].price,'${orederImageList[index].variant[orederImageList[index].selectedVarient].quantity}${orederImageList[index].variant[orederImageList[index].selectedVarient].unit}',orederImageList[index].qnty));
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: kMainColor,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }):Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isFetch ? CircularProgressIndicator() : Container(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            isFetch
                                ? locale.serverwait
                                : locale.noproductf,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 3,),
            BottomBar(text: locale.proceedorder, onTap: () {
              if(cartitemList.length>0){
print(cartitemList.toString());
                Navigator.pushNamed(context, PageRoutes.createOrderDetails,
                    arguments: {
                      'cartitemlist': cartitemList,
                      'orderdetails': orderDetails,
                      'curency': curency,
                    }).then((value){
                      if(value){
                        Navigator.of(context).pop();
                      }
                });
              }else{
                Toast.show(locale.someitem1, context,duration: Toast.LENGTH_SHORT,gravity: Toast.CENTER);
              }
            }),
          ],
        )),
      ),
    );
  }


}