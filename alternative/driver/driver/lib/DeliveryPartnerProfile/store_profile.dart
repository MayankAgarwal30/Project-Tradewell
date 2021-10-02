import 'package:driver/Components/entry_field.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:driver/baseurl/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final String phoneNumber;

  ProfilePage({this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          locale.profile,
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),

      //this column contains 3 textFields and a bottom bar
      body: RegisterForm(phoneNumber),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final String phoneNumber;

  RegisterForm(this.phoneNumber);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController nameC = TextEditingController();
  TextEditingController numberC = TextEditingController();
  dynamic name;
  dynamic number;
  dynamic image;

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  void getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('delivery_boy_name');
      image =
          Uri.parse('${imageBaseUrl}${prefs.getString('delivery_boy_image')}');
      number = prefs.getString('delivery_boy_phone');
      nameC.text = name;
      numberC.text = number;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          locale.featureImage,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.67,
                              color: kHintColor),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 99.0,
                          width: 99.0,
                          //color: kCardBackgroundColor,
                          child: Image.network('${image}'),
                        ),
                        SizedBox(width: 30.0),
                      ],
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
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          locale.profileInfo,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.67,
                              color: kHintColor),
                        ),
                      ),
                    ),
                    EntryField(
                      controller: nameC,
                      textCapitalization: TextCapitalization.words,
                      label: locale.fullName,
                      readOnly: true,
                    ),
                    //phone textField
                    EntryField(
                      controller: numberC,
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
