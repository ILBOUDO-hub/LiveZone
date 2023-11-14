
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/ui/register/verify_otp_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/strings.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:eventpro/widgets/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool selectTerms = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: toolbarBack("", context),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style:
                        boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Lorem Ipsum is simply dummy text of the printing',
                      style: normalLargeTextStyle),
                  const SizedBox(height: spacingLarge),
                  Text("Username", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  const TextFormWidget(hintText: "Enter Username"),
                  const SizedBox(height: spacingContainer),
                  Text("Email", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  const TextFormWidget(hintText: "Enter Email Address"),
                  const SizedBox(height: spacingContainer),
                  Text("Password", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  const TextFormWidget(hintText: "Enter Password"),
                  const SizedBox(height: spacingContainer),
                  Text("Confirm Password", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  const TextFormWidget(hintText: "Enter Confirm Password"),
                  const SizedBox(height: spacingContainer),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: primaryColor,
                        fillColor: MaterialStateProperty.all(primaryColor),
                        hoverColor: primaryColor.withOpacity(0.3),
                        value: selectTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            selectTerms = value!;
                          });
                        },
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'I read and agree with ',
                            style: normalTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms & Conditions',
                                  style: boldTextStyle.copyWith(
                                      color: btnBgColor,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchURL(termsCondition, context);
                                    })
                            ]),
                      ).wrapPaddingAll(spacingStandard),
                    ],
                  ),
                  // InkWell(
                  //   child: const ButtonWidget(text: "Register")
                  //       .wrapPaddingAll(spacingContainer),
                  //   onTap: () => Navigator.of(context).pushReplacement(
                  //       SlideRightRoute(page:  VerifyOTPScreen())),
                  // ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style: normalTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Login',
                                style: boldLargeTextStyle.copyWith(
                                    color: btnBgColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(SlideRightRoute(
                                        page:  LoginScreen()));
                                  })
                          ]),
                    ).addMarginBottom(spacingLarge),
                  ).addMarginTop(spacingStandard),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
