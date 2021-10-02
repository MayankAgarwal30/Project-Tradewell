import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class TncPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TncPageState();
  }
}

class TncPageState extends State<TncPage> {
  dynamic htmlString = '';

  @override
  void initState() {
    super.initState();
    getTnc();
  }

  void getTnc() async {
    var client = http.Client();
    var url = termcondition;
    client.get(url).then((value) {
      print('${value.body}');
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == "1") {
        var jsonData = jsonDecode(value.body);
        var dataList = jsonData['data'] as List;
        setState(() {
          htmlString = dataList[0]['termcondition'];
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(locale.termAndCondition,
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: kCardBackgroundColor,
                child: Image(
                  image: AssetImage("images/logos/logo_delivery.png"),
                  centerSlice: Rect.largest,
                  fit: BoxFit.fill,
                  height: 220,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      locale.termsOfUse,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    (htmlString!=null)?
                    Html(
                      data: htmlString,
                      style: {
                        "html": Style(
                          fontSize: FontSize.large,
//              color: Colors.white,
                        ),
                      },
                    ):Container(),
                    // Text(
                    //   '\n${htmlString}',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .caption
                    //       .copyWith(fontSize: 16),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
