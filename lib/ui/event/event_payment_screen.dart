/*
 * *
 *  * Created by Vishal Patolia on 9/29/21, 7:32 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/29/21, 7:32 PM
 *
 */

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:eventpro/ui/event/event_book_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EventPaymentScreen extends StatefulWidget {
  String description;

  EventPaymentScreen({Key? key, required this.description}) : super(key: key);

  @override
  _EventPaymentScreenState createState() => _EventPaymentScreenState();
}

class _EventPaymentScreenState extends State<EventPaymentScreen> {
  int val = -1;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: backgroundColor,
        child: SafeArea(
          bottom: false,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: context.width,
                        height: 60,
                        alignment: Alignment.center,
                        child: Text("Choose Payment Option",
                                style: boldLargeTextStyle.copyWith(
                                    fontSize: textSizeNormal,
                                    color: Colors.white))
                            .wrapPaddingAll(spacingContainer),
                        color: primaryColor),
                    Text(
                      widget.description,
                      style: mediumLargeTextStyle,
                    ),
                    // Theme(
                    //   data: ThemeData(
                    //     unselectedWidgetColor: primaryColor,
                    //   ),
                    //   child: RadioListTile(
                    //     value: 1,
                    //     groupValue: val,
                    //     activeColor: primaryColor,
                    //     onChanged: (int? value) {
                    //       setState(() {
                    //         val = value!;
                    //       });
                    //     },
                    //     title: Text("Stripe", style: boldTextStyle),
                    //   ),
                    // ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: primaryColor,
                      ),
                      child: RadioListTile(
                        value: 2,
                        groupValue: val,
                        activeColor: primaryColor,
                        onChanged: (int? value) {
                          setState(() {
                            val = value!;
                          });
                        },
                        title: Text("Razorpay", style: boldTextStyle),
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: primaryColor,
                      ),
                      child: RadioListTile(
                        value: 3,
                        groupValue: val,
                        activeColor: primaryColor,
                        onChanged: (int? value) {
                          setState(() {
                            val = value!;
                          });
                        },
                        title:
                            Text("Cash On Salon (COS)", style: boldTextStyle),
                      ),
                    ),
                    InkWell(
                      child: Center(
                        child: const ButtonWidget(text: "Pay")
                            .wrapPaddingAll(spacingContainer),
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.of(context).push(
                        //     // SlideRightRoute(page: EventBookScreen()));
                      },
                    ),
                  ],
                )),
          ),
        ));
  }
}
