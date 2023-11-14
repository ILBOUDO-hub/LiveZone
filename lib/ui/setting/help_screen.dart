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
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
          appBar: toolbarBack("Help & Support", context),
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
                      'We\'re here to help you with anything and everything on EventPro',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingStandard),
                  Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                      style: normalTextStyle),
                  const SizedBox(height: spacingContainer),
                  Container(
                    width: context.width,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                        color: primaryColor,
                        width: 1,
                      ),
                    ),
                    child: Row(children: [
                      const SizedBox(width: spacingContainer),
                      Icon(Icons.search_rounded,
                          color: primaryColor.withOpacity(0.8)),
                      const SizedBox(width: spacingStandard),
                      Expanded(
                        child: TextFormField(
                            style: mediumTextStyle,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                                hintText: 'Search help',
                                border: InputBorder.none,
                                hintStyle: mediumTextStyle)),
                      ),
                    ]),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('FAQ',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingStandard),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 3,
                      separatorBuilder: (context, i) {
                        return Container(height: 1, color: primaryColor);
                      },
                      itemBuilder: (context, i) {
                        return ExpansionTile(
                            iconColor: primaryColor,
                            collapsedIconColor: primaryColor,
                            expandedAlignment: Alignment.topLeft,
                            tilePadding: const EdgeInsets.all(0.0),
                            childrenPadding: const EdgeInsets.only(
                                left: spacingStandard,
                                right: spacingStandard,
                                bottom: spacingContainer),
                            title: Text('What\'s the EventPro?',
                                style: mediumTextStyle),
                            children: [
                              Text(
                                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
                                  style: smallNormalTextStyle)
                            ]).addMarginLeft(spacingStandard);
                      }),
                  const SizedBox(height: spacingContainer),
                  Text('Still Stuck? More help',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingContainer),
                  Row(children: [
                    InkWell(
                      onTap: () => {openWhatsApp(context)},
                      child: Image.asset(
                        'assets/whatsapp.png',
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(width: spacingContainer),
                    InkWell(
                      onTap: () => {launchURL('tel:8879976594', context)},
                      child: Image.asset(
                        'assets/telephone.png',
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(width: spacingContainer),
                    InkWell(
                      onTap: () =>
                          {launchURL('mailto:hello@sdreatech.com', context)},
                      child: Image.asset(
                        'assets/mail.png',
                        height: 35,
                        width: 35,
                      ),
                    )
                  ])
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
