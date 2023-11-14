/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:eventpro/ui/event/event_details_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AttendeesProfileScreen extends StatefulWidget {
  const AttendeesProfileScreen({Key? key}) : super(key: key);

  @override
  _AttendeesProfileScreenState createState() => _AttendeesProfileScreenState();
}

class _AttendeesProfileScreenState extends State<AttendeesProfileScreen> {
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
          appBar: toolbarBack("Attendees Profile", context),
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
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('assets/man.png',
                            height: 100, fit: BoxFit.scaleDown),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mario',
                              style: boldLargeTextStyle.copyWith(
                                  fontSize: textSizeNormal)),
                          Text('Delhi, IN', style: normalTextStyle)
                              .addMarginTop(spacingControl),
                        ],
                      ).addMarginLeft(spacingStandard)
                    ],
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                    child: Row(children: [
                      Image.asset('assets/mail.png', height: 24, width: 24),
                      const SizedBox(width: spacingContainer),
                      Text('hello@sdreatech.com', style: mediumTextStyle)
                    ]),
                    onTap: () =>
                        launchURL('mailto:hello@sdreatech.com', context),
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                    child: Row(children: [
                      Image.asset('assets/telephone.png',
                          height: 24, width: 24),
                      const SizedBox(width: spacingContainer),
                      Text('+91 8879976594', style: mediumTextStyle),
                    ]),
                    onTap: () => launchURL('tel:8879976594', context),
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                    child: Row(children: [
                      Image.asset('assets/whatsapp.png', height: 24, width: 24),
                      const SizedBox(width: spacingContainer),
                      Text('+91 8879976594', style: mediumTextStyle),
                    ]),
                    onTap: () => openWhatsApp(context),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Attended Events',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingContainer),
                  ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: spacingContainer);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Flutter GetX Event",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                          style: boldLargeTextStyle.copyWith(
                                              fontSize: textSizeNormal)),
                                      Text("29th Nov, 2020, 12:00 PM",
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 1,
                                              style: mediumTextStyle)
                                          .addMarginTop(spacingControl),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/location.png',
                                              height: 16, width: 16),
                                          Expanded(
                                              child: Text('New York, US 10010',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      style: mediumTextStyle)
                                                  .addMarginLeft(
                                                      spacingControl)),
                                        ],
                                      ).addMarginTop(spacingControlHalf),
                                    ],
                                  ).addMarginLeft(spacingStandard)),
                                  Container(
                                      height: 20,
                                      width: 20,
                                      child: const Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 16,
                                          color: Colors.white),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      ))
                                ],
                              ).wrapPaddingAll(spacingStandard),
                            ),
                            // onTap: () => {
                            //       Navigator.of(context).push(SlideRightRoute(
                            //           page: const EventDetailsScreen()))
                            //     }
                                );
                      })
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
