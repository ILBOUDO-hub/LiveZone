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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
          appBar: toolbarBack("Feedbacks", context),
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
                        borderRadius: BorderRadius.circular(16.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Flutter Conference, Dart Analysis',
                                            style: boldLargeTextStyle),
                                        RatingBarIndicator(
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemSize: 20,
                                          rating: 5,
                                          unratedColor: Colors.transparent
                                              .withOpacity(0.1),
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, index) {
                                            switch (index) {
                                              case 0:
                                                return Image.asset(
                                                    'assets/a.png');
                                              case 1:
                                                return Image.asset(
                                                    'assets/b.png');
                                              case 2:
                                                return Image.asset(
                                                    'assets/c.png');
                                              case 3:
                                                return Image.asset(
                                                    'assets/d.png');
                                              case 4:
                                                return Image.asset(
                                                    'assets/e.png');
                                              default:
                                                return Container();
                                            }
                                          },
                                        ).addMarginTop(spacingStandard),
                                        Text('There is no one who loves pain itself, who seeks after it and wants to have it',
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: normalTextStyle)
                                            .addMarginTop(spacingStandard),
                                      ]).wrapPaddingAll(spacingContainer),
                                ),
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
                                    )).addMarginRight(spacingStandard)
                              ]),
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      );
                    })
                .wrapPadding(
                    padding: const EdgeInsets.only(
                        left: spacingContainer,
                        right: spacingContainer,
                        bottom: spacingContainer)),
          )),
    );
  }
}
