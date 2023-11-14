/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventpro/ui/attendees/attendees_profile_screen.dart';
import 'package:eventpro/ui/attendees/attendees_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventViewScreen extends StatefulWidget {
  const EventViewScreen({Key? key}) : super(key: key);

  @override
  _EventViewScreenState createState() => _EventViewScreenState();
}

class _EventViewScreenState extends State<EventViewScreen> {
  List<String> banner = [
    'assets/event_a.jpg',
    'assets/event_b.jpg',
    'assets/event_c.jpg'
  ];

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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Center(
                          child: Image.asset(
                        "assets/arrow.png",
                        height: 24,
                        width: 24,
                      )),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('Event View',
                          style: appBarStyle,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis)
                      .addMarginLeft(spacingContainer),
                ]),
                InkWell(
                  borderRadius: BorderRadius.circular(32.0),
                  child: Image.asset('assets/share.png',
                      height: 32, width: 32, color: primaryColor),
                  onTap: () => {},
                )
              ],
            ).wrapPaddingAll(spacingContainer),
          ),
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
                  CarouselSlider(
                    options: CarouselOptions(
                        height: kIsWeb || Platform.isWindows ? 300 : 200,
                        enableInfiniteScroll: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            // _current = index;
                          });
                        }),
                    items: banner
                        .map((item) => GestureDetector(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: Center(
                                    child: Image.asset(item,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, url, error) =>
                                            const Icon(Icons.error),
                                        width:
                                            MediaQuery.of(context).size.width)),
                              ),
                              onTap: () {},
                            ))
                        .toList(),
                  ),
                  Text("Flutter Conference, Dart Analysis",
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeLarge))
                      .addMarginTop(spacingContainer),
                  Text('29th Nov, 2020, 12:00 PM', style: mediumTextStyle)
                      .addMarginTop(spacingStandard),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(children: [
                          Image.asset('assets/location.png',
                              height: 20, width: 20),
                          Expanded(
                            child: Text('New York, US 10010',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: mediumTextStyle)
                                .addMarginLeft(spacingControl),
                          )
                        ]),
                      ),
                      const Icon(Icons.directions,
                          color: primaryColor, size: 34)
                    ],
                  ),
                  Text('\$ 500',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingStandard),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Attendees (10)',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const Icon(Icons.more_horiz_rounded,
                            color: primaryColor, size: 32)
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context)
                          .push(SlideRightRoute(page: const AttendeesScreen()));
                    },
                  ),
                  const SizedBox(height: spacingStandard),
                  SizedBox(
                    height: 105,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                        },
                      ),
                      child: ListView.separated(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: spacingStandard);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset('assets/man.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover),
                                  ),
                                  Text('Mario', style: mediumTextStyle)
                                      .addMarginTop(spacingControl)
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(SlideRightRoute(
                                    page: const AttendeesProfileScreen()));
                              },
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Details',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingStandard),
                  Text(
                      'Join us for our second Data & Drinks meet-up in NYC! This event will be an informal event to discuss ideas for the group, and we will have a few fireside/speaker corner chats on Data Discoverability and Data Literacy. The main focus will be on networking and meeting fellow data people based in NYC. \n\nWe\'d love for anyone to join, and we will have a small sign on the table to identify the group. \n\nPlease RSVP in advance, so we can be sure to have the appropriate number of tables. Hopefully, we will have enough to join a few tables (..... bad, SQL joke) \n\nHope to see you all there!',
                      style: normalTextStyle),
                  const SizedBox(height: spacingContainer),
                  Center(
                    child: QrImageView(
                      data: 'https://sdreatech.com/',
                      version: QrVersions.auto,
                      size: 150,
                      gapless: false,
                      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
                      foregroundColor: primaryColor,
                    ),
                  ),
                  const ButtonWidget(text: "Download Ticket")
                      .wrapPaddingAll(spacingContainer),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
