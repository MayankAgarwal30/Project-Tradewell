import 'package:driver/Components/custom_button.dart';
import 'package:driver/Locale/language_cubit.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  LanguageCubit _languageCubit;
  bool islogin = false;
  List<int> radioButtons = [0, -1, -1, -1, -1];
  String selectedLanguage;
  int selectedIndex = -1;
  bool enteredFirst = false;
  var userName;
  List<String> languages = [];

  @override
  void initState() {
    super.initState();
    getSharedValue();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  void getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      islogin = prefs.getBool('islogin');
    });
  }

  getAsyncValue(List<String> languagesd, AppLocalizations locale) async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('language') &&
          prefs.getString('language').length > 0) {
        String langCode = prefs.getString('language');
        if (langCode == 'en') {
          selectedLanguage = locale.englishh;
        } else if (langCode == 'es') {
          selectedLanguage = locale.spanish;
        } else if (langCode == 'hi') {
          selectedLanguage = locale.hindi;
        } else {
          selectedLanguage = locale.englishh;
        }
        setState(() {
          selectedIndex = languages.indexOf(selectedLanguage);
        });
      } else {
        selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enteredFirst) {
      setState(() {
        enteredFirst = true;
      });
      languages = [locale.englishh, locale.spanish, locale.hindi];
      getAsyncValue(languages, locale);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.languages,
          style: TextStyle(color: kMainTextColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 16, right: 16, bottom: 16),
            child: Text(
              locale.languages,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                primary: true,
                child: ListView.builder(
                  itemCount: languages.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            print(selectedIndex);
                          });
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Radio(
                              activeColor: kMainColor,
                              value: index,
                              groupValue: selectedIndex,
                              toggleable: false,
                              onChanged: (valse) {
                                setState(() {
                                  selectedIndex = index;
                                  print(selectedIndex);
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${languages[index]}',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width / 2,
                height: 45,
                onPressed: () {
                  if (selectedIndex >= 0) {
                    setState(() {
                      selectedLanguage = languages[selectedIndex];
                    });
                    if (selectedLanguage == locale.englishh) {
                      _languageCubit.selectLanguage('en');
                    } else if (selectedLanguage == locale.spanish) {
                      _languageCubit.selectLanguage('es');
                    } else if (selectedLanguage == locale.hindi) {
                      _languageCubit.selectLanguage('hi');
                    }
                  }
                  Navigator.pop(context);
                },
                color: kMainColor,
                child: Text(
                  locale.continueText,
                  style: TextStyle(color: kWhiteColor, fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}


// class ChooseLanguage extends StatefulWidget {
//   @override
//   _ChooseLanguageState createState() => _ChooseLanguageState();
// }
//
// class _ChooseLanguageState extends State<ChooseLanguage> {
//   LanguageCubit _languageCubit;
//   List<int> radioButtons = [0, -1, -1, -1, -1];
//   String selectedLanguage;
//
//   @override
//   void initState() {
//     super.initState();
//     _languageCubit = BlocProvider.of<LanguageCubit>(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context);
//     List<String> languages = [
//       locale.englishh,
//       locale.hindi,
//       locale.spanish,
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(locale.languages,style: TextStyle(color:Theme.of(context). backgroundColor,),),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 20.0, left: 16, right: 16, bottom: 16),
//             child: Text(
//               locale.selectPreferredLanguage,
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle2
//                   .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//           ),
//           RadioButtonGroup(
//             activeColor: Theme.of(context).primaryColor,
//             labelStyle: Theme.of(context).textTheme.caption,
//             onSelected: (selectedLocale) {
//               setState(() {
//                 selectedLanguage = selectedLocale;
//               });
//             },
//             labels: languages,
//             itemBuilder: (Radio radioButton, Text title, int i) {
//               return Column(
//                 children: <Widget>[
//                   Container(
//                     height: 56.7,
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: ListTile(
//                         leading: radioButton,
//                         title: Text(
//                           languages[i],
//                           style: Theme.of(context)
//                               .textTheme
//                               .subtitle1
//                               .copyWith(fontSize: 19),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5.0)
//                 ],
//               );
//             },
//           ),
//           Spacer(),
//           CustomButton(
//             label: locale.save,
//             onTap: () {
//               if (selectedLanguage == locale.englishh) {
//                 _languageCubit.selectLanguage('en');
//               } else if (selectedLanguage == locale.hindi) {
//                 _languageCubit.selectLanguage('hi');
//               } else if (selectedLanguage == locale.spanish) {
//                 _languageCubit.selectLanguage('es');
//               }
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
