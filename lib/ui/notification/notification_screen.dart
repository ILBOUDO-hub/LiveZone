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

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          appBar: toolbarBack("Notifications", context),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: spacingContainer);
                },
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('assets/event_a.jpg',
                            width: 100, height: 100, fit: BoxFit.cover),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/location.png',
                                  height: 16, width: 16),
                              Expanded(
                                  child: Text('New Delhi, IN 38520',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                          style: mediumTextStyle)
                                      .addMarginLeft(spacingControl)),
                            ],
                          ).addMarginTop(spacingControlHalf),
                          Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text("24 Oct 2021",
                                      style: smallNormalTextStyle))
                              .addMarginTop(spacingControlHalf),
                        ],
                      ).addMarginLeft(12)),
                    ],
                  ));
                }).wrapPaddingAll(spacingContainer),
          )),
    );
  }
}
