import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/email_checker.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/auth_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/custom_app_bar.dart';
import 'package:flutter_grocery/view/base/custom_button.dart';
import 'package:flutter_grocery/view/base/custom_snackbar.dart';
import 'package:flutter_grocery/view/base/custom_text_field.dart';
import 'package:flutter_grocery/view/base/main_app_bar.dart';
import 'package:flutter_grocery/view/screens/forgot_password/verification_screen.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)? MainAppBar(): CustomAppBar(title: getTranslated('forgot_password', context)),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: 1170,
              child: Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  return Column(
                    children: [
                      SizedBox(height: 55),
                      Image.asset(Images.close_lock, width: 142, height: 142, color: Theme.of(context).primaryColor),
                      SizedBox(height: 40),
                      Center(
                          child: Text(
                        getTranslated('please_enter_your_number_to', context),
                        textAlign: TextAlign.center,
                        style: poppinsRegular.copyWith(color: ColorResources.getHintColor(context)),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              getTranslated('email', context),
                              style: poppinsRegular.copyWith(color: ColorResources.getHintColor(context)),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            CustomTextField(
                              hintText: getTranslated('demo_gmail', context),
                              isShowBorder: true,
                              controller: _emailController,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.done,
                            ),
                            SizedBox(height: 24),
                            !auth.isForgotPasswordLoading
                                ? SizedBox(
                                    width: double.infinity,
                                    child: CustomButton(
                                      buttonText: getTranslated('send', context),
                                      onPressed: () {
                                        String _email = _emailController.text.trim();
                                        if (_email.isEmpty) {
                                          showCustomSnackBar(getTranslated('enter_email_address', context), context);
                                        }else if (EmailChecker.isNotValid(_email)) {
                                          showCustomSnackBar(getTranslated('enter_valid_email', context), context);
                                        }else {
                                          Provider.of<AuthProvider>(context, listen: false).forgetPassword(_email).then((value) {
                                            if (value.isSuccess) {
                                              Navigator.of(context).pushNamed(
                                                RouteHelper.getVerifyRoute('forget-password', _email),
                                                arguments: VerificationScreen(emailAddress: _email),
                                              );
                                            } else {
                                              showCustomSnackBar(value.message, context);
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
