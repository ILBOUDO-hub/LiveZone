/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:eventpro/widgets/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot Password",
                  style: boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                ),
                const SizedBox(height: spacingContainer),
                Text('Lorem Ipsum is simply dummy text of the printing',
                    style: normalLargeTextStyle),
                const SizedBox(height: spacingLarge),
                Text("Email", style: smallNormalTextStyle)
                    .addMarginLeft(spacingContainer),
                const TextFormWidget(hintText: "Enter Email Address"),
                const SizedBox(height: spacingContainer),
                const ButtonWidget(text: "Forgot Password")
                    .wrapPaddingAll(spacingContainer),
                InkWell(
                  child: Center(
                          child: Text("Back to login",
                              style: boldTextStyle.copyWith(
                                  fontSize: textSizeLargeMedium)))
                      .addMarginTop(spacingStandard),
                  onTap: () => {
                    Navigator.of(context).pushReplacement(
                        SlideRightRoute(page:  LoginScreen()))
                  },
                ),
              ],
            ).wrapPaddingAll(spacingContainer),
          )),
    );
  }
}
