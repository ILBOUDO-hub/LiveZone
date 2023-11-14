/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:eventpro/widgets/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
          appBar: toolbarBack("Contact Us", context),
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
                  Card(
                    color: Colors.white,
                    elevation: elevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Company Details',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const SizedBox(height: spacingContainer),
                        InkWell(
                          child: Row(children: [
                            Image.asset('assets/maps.png',
                                height: 24, width: 24),
                            const SizedBox(width: spacingContainer),
                            Text('Ahmedabad, IN 380015', style: mediumTextStyle)
                          ]),
                          onTap: () => launchURL(
                              'https://www.google.com/maps/search/?api=1&query=23.012349,72.522785',
                              context),
                        ),
                        const SizedBox(height: spacingContainer),
                        InkWell(
                          child: Row(children: [
                            Image.asset('assets/browser.png',
                                height: 24, width: 24),
                            const SizedBox(width: spacingContainer),
                            Text('www.sdreatech.com', style: mediumTextStyle),
                          ]),
                          onTap: () =>
                              launchURL('https://sdreatech.com', context),
                        ),
                        const SizedBox(height: spacingContainer),
                        InkWell(
                          child: Row(children: [
                            Image.asset('assets/telephone_no.png',
                                height: 24, width: 24),
                            const SizedBox(width: spacingContainer),
                            Text('+91 8879976594', style: mediumTextStyle),
                          ]),
                          onTap: () => launchURL('tel:8879976594', context),
                        ),
                        const SizedBox(height: spacingStandard),
                      ],
                    ).wrapPaddingAll(spacingContainer),
                  ),
                  const SizedBox(height: spacingContainer),
                  Card(
                    color: Colors.white,
                    elevation: elevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact Details',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const SizedBox(height: spacingContainer),
                        Text("Name", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(hintText: "Enter Your Name"),
                        const SizedBox(height: spacingContainer),
                        Text("Email", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(hintText: "Enter Email Address"),
                        const SizedBox(height: spacingContainer),
                        Text("Mobile No.", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(hintText: "Enter Mobile No."),
                        const SizedBox(height: spacingContainer),
                        Text("Message", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(
                          hintText: "Enter Your Message",
                          maxLines: 5,
                        ),
                        const SizedBox(height: spacingStandard),
                      ],
                    ).wrapPaddingAll(spacingContainer),
                  ),
                  const SizedBox(height: spacingLarge),
                  const ButtonWidget(text: "Submit"),
                  const SizedBox(height: spacingContainer),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
