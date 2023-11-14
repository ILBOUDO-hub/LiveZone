

import 'dart:async';

import 'package:eventpro/controllers/phone_auth_controller.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class VerifyOTPScreen extends StatelessWidget {
  var controller = TextEditingController();
  
  var hasError = false;
  String phone;
  String code="";
  RxBool resend = false.obs;


  VerifyOTPScreen({Key? key, required this.phone}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  Timer(Duration(seconds: 5), (){
    resend.value = true;
  });
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
                    "Vérification OTP",
                    style:
                        boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text("Entrez le code recu par sms",
                      style: normalLargeTextStyle),
                  const SizedBox(height: spacingLarge),
                  Text("Entrer l'OTP", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  Center(
                    child: PinCodeTextField(
                        autofocus: true,
                        controller: controller,
                        highlight: true,
                        defaultBorderColor: primaryColor,
                        highlightPinBoxColor: primaryColor,
                        pinBoxColor: Colors.white,
                        hasTextBorderColor: primaryColor,
                        highlightColor: primaryColor,
                        pinBoxBorderWidth: 2,
                        maxLength: 6,
                        hasError: hasError,
                        onTextChanged: (text) {
                          code = text;
                        },
                        onDone: (text) async{
                          OtpController.instance.otpVerify(text, {});
                        },
                        pinBoxWidth: Get.width < 475 ? Get.width/8:475/8,
                        pinBoxHeight: 64,
                        hasUnderline: false,
                        pinBoxRadius: 7,
                        wrapAlignment: WrapAlignment.spaceBetween,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: const TextStyle(fontSize: 22.0),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.amber,
                        keyboardType: TextInputType.number),
                  ).addMarginTop(spacingContainer),
                  const SizedBox(height: spacingContainer),
                  
                 resend.value ? Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Code non recu ?",
                          style: normalTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Renvoyer le code',
                                style: boldLargeTextStyle.copyWith(
                                    color: btnBgColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    OtpController.instance.verifyPhone(phone);
                                  })
                          ]),
                    ),
                  ) 
                  :SizedBox(),
                  const SizedBox(height: spacingContainer),
                  const SizedBox(height: spacingContainer),

                   Center(
                     child: CupertinoButton(
                      color: primaryColor ,child: Text("Verifier",style: mediumLargeTextStylewhite,) ,onPressed: (){
                        if (code.length==6) {
                        OtpController.instance.otpVerify(code, {});
                          
                        }
                  },
                  padding: 
                  EdgeInsets.symmetric(horizontal: 50),
                  ),
                   )
                     
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
