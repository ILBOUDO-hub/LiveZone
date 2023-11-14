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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddFeedbackScreen extends StatefulWidget {
  const AddFeedbackScreen({Key? key}) : super(key: key);

  @override
  _AddFeedbackScreenState createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
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
          appBar: toolbarBack("Add Feedback", context),
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
                      'This survey enables you to provide feedback on the value and outcomes of the event you have just attended.',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: itemSpacing),
                  Text(
                      '1. Information provided at this event is related to you',
                      style: mediumTextStyle),
                  const SizedBox(height: spacingStandard),
                  RatingBar.builder(
                    initialRating: 5,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 32,
                    unratedColor: Colors.transparent.withOpacity(0.1),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Image.asset('assets/a.png');
                        case 1:
                          return Image.asset('assets/b.png');
                        case 2:
                          return Image.asset('assets/c.png');
                        case 3:
                          return Image.asset('assets/d.png');
                        case 4:
                          return Image.asset('assets/e.png');
                        default:
                          return Container();
                      }
                    },
                    onRatingUpdate: (rating) {
                      setState(() {});
                    },
                    updateOnDrag: true,
                  ),
                  const SizedBox(height: spacingContainer),
                  Text(
                      '2. Information provided at this event is related to you',
                      style: mediumTextStyle),
                  const SizedBox(height: spacingStandard),
                  RatingBar.builder(
                      initialRating: 3,
                      itemCount: 5,
                      unratedColor: Colors.grey,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (BuildContext? context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      },
                      onRatingUpdate: (rating) {}),
                  const SizedBox(height: spacingContainer),
                  Text(
                      '3. Information provided at this event is related to you',
                      style: mediumTextStyle),
                  const SizedBox(height: spacingStandard),
                  RatingBar(
                    initialRating: 3,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 32,
                    ratingWidget: RatingWidget(
                      full:
                          Image.asset('assets/heart.png', color: primaryColor),
                      half: Image.asset('assets/heart_half.png',
                          color: primaryColor),
                      empty: Image.asset('assets/heart_border.png',
                          color: primaryColor),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: spacingContainer),
                  Text(
                      '4. Information provided at this event is related to you',
                      style: mediumTextStyle),
                  const SizedBox(height: spacingStandard),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 34,
                    unratedColor: Colors.grey.withOpacity(0.5),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: spacingContainer),
                  Text(
                      '5. Information provided at this event is related to you',
                      style: mediumTextStyle),
                  const TextFormWidget(
                    maxLines: 2,
                  ),
                  const SizedBox(height: spacingContainer),
                  Text(
                      '6. Information provided at this event is related to you',
                      style: mediumTextStyle),
                  const TextFormWidget(
                    maxLines: 5,
                  ),
                  const SizedBox(height: spacingLarge),
                  const ButtonWidget(text: "Submit"),
                  const SizedBox(height: spacingContainer)
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
