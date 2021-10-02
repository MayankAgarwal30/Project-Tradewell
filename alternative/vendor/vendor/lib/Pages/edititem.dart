import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Components/bottom_bar.dart';
import 'package:vendor/Components/entry_field.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Themes/colors.dart';
import 'package:vendor/baseurl/baseurl.dart';
import 'package:vendor/orderbean/categorybean.dart';
import 'package:vendor/orderbean/productbean.dart';
import 'package:vendor/orderbean/subcartbean.dart';

class EditItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    Map<String, dynamic> dataLis = ModalRoute.of(context).settings.arguments;
    ProductBean productBean = dataLis['selectedItem'];
    dynamic currency = dataLis['currency'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: kMainColor),
        title:
            Text(locale.editpro, style: Theme.of(context).textTheme.bodyText1),
        titleSpacing: 0.0,
      ),
      body: Edit(productBean, currency),
    );
  }
}

class Edit extends StatefulWidget {
  ProductBean productBean;
  dynamic currency;

  Edit(this.productBean, this.currency);

  @override
  State<StatefulWidget> createState() {
    return EditState(productBean, currency);
  }
}

class EditState extends State<Edit> {
  ProductBean productBean;
  dynamic currency;
  SubCategoryList subCatString;
  List<SubCategoryList> subCatList = [];
  CategoryList catString;
  List<CategoryList> catList = [];
  File _image;
  final picker = ImagePicker();
  TextEditingController productNameC = TextEditingController();
  TextEditingController productQuantityC = TextEditingController();
  TextEditingController productUnitC = TextEditingController();
  TextEditingController productStoreC = TextEditingController();
  TextEditingController productMrpC = TextEditingController();
  TextEditingController productPriceC = TextEditingController();
  TextEditingController productDespC = TextEditingController();

  EditState(productBean, currency) {
    this.productBean = productBean;
    this.currency = currency;
    catString = CategoryList(
        this.productBean.category_id,
        this.productBean.cityadmin_id,
        this.productBean.category_name,
        this.productBean.category_image,
        this.productBean.home,
        this.productBean.created_at,
        this.productBean.updated_at,
        this.productBean.vendor_id);
    catList.add(catString);
    subCatString = SubCategoryList(
        this.productBean.subcat_id,
        this.productBean.category_id,
        this.productBean.subcat_name,
        this.productBean.subcat_image,
        this.productBean.created_at,
        this.productBean.updated_at);
    subCatList.add(subCatString);
    productNameC.text = this.productBean.product_name;
    productDespC.text = this
        .productBean
        .varient_details[this.productBean.selectedItem]
        .description;
    productPriceC.text =
        '${this.productBean.varient_details[this.productBean.selectedItem].price}';
    productMrpC.text =
        '${this.productBean.varient_details[this.productBean.selectedItem].strick_price}';
    productQuantityC.text =
        '${this.productBean.varient_details[this.productBean.selectedItem].quantity}';
    productUnitC.text =
        '${this.productBean.varient_details[this.productBean.selectedItem].unit}';
    productStoreC.text =
        '${this.productBean.varient_details[this.productBean.selectedItem].stock}';
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    var catUrl = store_category;
    var client = http.Client();
    client.post(catUrl, body: {'vendor_id': '${productBean.vendor_id}'}).then(
        (value) {
      print('${value.body}');
      if (value.statusCode == 200) {
        var jsonData = jsonDecode(value.body);
        var jsonList = jsonData['data'] as List;
        List<CategoryList> catbean =
            jsonList.map((e) => CategoryList.fromJson(e)).toList();
        if (catbean.length > 0) {
          catList.clear();
          setState(() {
            catString = catbean[0];
            catList = List.from(catbean);
          });
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  void getSubCategoryList(catId) async {
    var catUrl = store_subcategory;
    var client = http.Client();
    client.post(catUrl, body: {'category_id': '${catId}'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = jsonDecode(value.body);
        var jsonList = jsonData['data'] as List;
        List<SubCategoryList> catbean =
            jsonList.map((e) => SubCategoryList.fromJson(e)).toList();
        if (catbean.length > 0) {
          subCatList.clear();
          setState(() {
            subCatString = catbean[0];
            subCatList = List.from(catbean);
          });
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    picker.getImage(source: ImageSource.gallery).then((pickedFile) {
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }).catchError((e) => print(e));
  }

  void _showPicker(context, AppLocalizations locale) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(locale.photolibrary),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(locale.Camera),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: <Widget>[
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          locale.itemimg,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.67,
                              color: kHintColor),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context,locale);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 99.0,
                            width: 99.0,
                            child: _image != null
                                ? Image.file(_image)
                                : Image.network(
                                    '${imageBaseUrl}${productBean.product_image}'),
                          ),
                          SizedBox(width: 30.0),
                          Icon(
                            Icons.camera_alt,
                            color: kMainColor,
                            size: 19.0,
                          ),
                          SizedBox(width: 14.3),
                          Text(locale.uploadpic,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kMainColor)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.3,
                    )
                  ],
                ),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        locale.iteminfo,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.67,
                            color: kHintColor),
                      ),
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.itemtitle1,
                      hint: locale.itemtitle2,
                      controller: productNameC,
                      // initialValue: '${productBean.product_name}',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.itemcat,
                            style: TextStyle(fontSize: 13, color: kHintColor),
                          ),
                          DropdownButton<CategoryList>(
                            isExpanded: true,
                            value: catString,
                            underline: Container(
                              height: 1.0,
                              color: kMainTextColor,
                            ),
                            items: catList.map((values) {
                              return DropdownMenuItem<CategoryList>(
                                value: values,
                                child: Text(values.category_name),
                              );
                            }).toList(),
                            onChanged: (area) {
                              setState(() {
                                catString = area;
                              });
                              getSubCategoryList(area.category_id);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.itemcat1,
                            style: TextStyle(fontSize: 13, color: kHintColor),
                          ),
                          DropdownButton<SubCategoryList>(
                            value: subCatString,
                            isExpanded: true,
                            underline: Container(
                              height: 1.0,
                              color: kMainTextColor,
                            ),
                            items: subCatList.map((values) {
                              return DropdownMenuItem<SubCategoryList>(
                                value: values,
                                child: Text(values.subcat_name),
                              );
                            }).toList(),
                            onChanged: (area) {
                              setState(() {
                                subCatString = area;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        locale.itemcat2,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.67,
                            color: kHintColor),
                      ),
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.itemcat2,
                      hint: locale.itemcat21,
                      controller: productDespC,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        locale.itemcat3,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.67,
                            color: kHintColor),
                      ),
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.itemprice1,
                      hint: locale.itemprice2,
                      controller: productPriceC,
                      keyboardType: TextInputType.number,
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.itemmrp1,
                      hint: locale.itemmrp2,
                      controller: productMrpC,
                      keyboardType: TextInputType.number,
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.itemqnt1,
                      hint: locale.itemqnt2,
                      controller: productQuantityC,
                      keyboardType: TextInputType.number,
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.itemunit1,
                      controller: productUnitC,
                      hint: locale.itemunit2,
                    ),
                    EntryField(
                      textCapitalization: TextCapitalization.words,
                      label: locale.stock1,
                      controller: productStoreC,
                      hint: locale.stock2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomBar(
            text: locale.updateinfo,
            onTap: () {
              showProgressDialog(locale.updatingpleasewait, pr);
              newHitService(pr, context,locale);
            },
          ),
        )
      ],
    );
  }

  showProgressDialog(String text, ProgressDialog pr) {
    pr.style(
        message: '${text}',
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
  }

  void newHitService(ProgressDialog pr, BuildContext contexts, AppLocalizations locale) async {
    if (productMrpC.text.isNotEmpty &&
        productPriceC.text.isNotEmpty &&
        productStoreC.text.isNotEmpty &&
        productUnitC.text.isNotEmpty &&
        productQuantityC.text.isNotEmpty &&
        productDespC.text.isNotEmpty) {
      pr.show();
      String fid = "";
      if (_image != null) {
        fid = _image.path.split('/').last;
      }

      var storeEditUrl = store_updatenewproduct;
      var request = http.MultipartRequest("POST",storeEditUrl);
      request.fields["product_id"] = '${productBean.product_id}';
      request.fields["varient_id"] =
          '${productBean.varient_details[productBean.selectedItem].varient_id}';
      request.fields["subcat_id"] = '${subCatString.subcat_id}';
      request.fields["product_name"] = '${productNameC.text}';
      request.fields["strick_price"] = '${productMrpC.text}';
      request.fields["price"] = '${productPriceC.text}';
      request.fields["stock"] = '${productStoreC.text}';
      request.fields["unit"] = '${productUnitC.text}';
      request.fields["quantity"] = '${productQuantityC.text}';
      request.fields["description"] = '${productDespC.text}';
      if (_image != null) {
        http.MultipartFile.fromPath(
                "product_image", (_image != null) ? _image.path : "",
                filename: fid)
            .then((pic) {
          request.files.add(pic);
          request.send().then((values) {
            values.stream.toBytes().then((value) {
              var responseString = String.fromCharCodes(value);
              var jsonData = jsonDecode(responseString);
              pr.hide();
              if (jsonData['status'] == "1") {
                Toast.show(locale.productupdate, contexts,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                productNameC.clear();
                productDespC.clear();
                productPriceC.clear();
                productMrpC.clear();
                productQuantityC.clear();
                productUnitC.clear();
                productStoreC.clear();
                setState(() {
                  _image = null;
                });
                Navigator.of(context).pop();
              } else {
                Toast.show(locale.somethingwent, contexts,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              }
            });
          }).catchError((e) {
            pr.hide();
            print(e);
            Toast.show(locale.somethingwent, contexts,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          });
        }).catchError((e1) {
          pr.hide();
          print(e1);
          Toast.show(locale.somethingwent, contexts,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        });
      } else {
        request.fields["product_image"] = '';
        request.send().then((values) {
          values.stream.toBytes().then((value) {
            var responseString = String.fromCharCodes(value);
            var jsonData = jsonDecode(responseString);
            pr.hide();
            if (jsonData['status'] == "1") {
              Toast.show(locale.productupdate, contexts,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              productNameC.clear();
              productDespC.clear();
              productPriceC.clear();
              productMrpC.clear();
              productQuantityC.clear();
              productUnitC.clear();
              productStoreC.clear();
              setState(() {
                _image = null;
              });
              Navigator.of(context).pop();
            } else {
              Toast.show(locale.somethingwent, contexts,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            }
          });
        }).catchError((e) {
          pr.hide();
          print(e);
          Toast.show(locale.somethingwent, contexts,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        });
      }
    } else {
      pr.hide();
      Toast.show(locale.enterproduct, contexts,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }
}
