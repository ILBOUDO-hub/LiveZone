/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:eventpro/widgets/date_range_picker.dart' as date_range_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Categories> categoriesList = [
    Categories('Technology', false),
    Categories('Sports', false),
    Categories('Talk', false),
    Categories('Funny', false),
    Categories('Devotional', false)
  ];
  String? dateRange;
  final DateTime _startDate = DateTime.now();
  final DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();
    dateRange =
        '${DateFormat('dd MMM yy').format(_startDate)} - ${DateFormat('dd MMM yy').format(_endDate)}';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future displayDateRangePicker(BuildContext context) async {
    List<DateTime>? picked = await date_range_picker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        dateRange =
            '${DateFormat('dd MMM yy').format(picked[0])} - ${DateFormat('dd MMM yy').format(picked[1])}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: toolbarBack("Filter", context),
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
                  Text('Date',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingStandard),
                  Text('Select Date Range', style: mediumTextStyle)
                      .addMarginLeft(spacingStandard),
                  const SizedBox(height: spacingControl),
                  GestureDetector(
                    child: Text(dateRange!, style: boldTextStyle)
                        .addMarginLeft(spacingStandard),
                    onTap: () {
                      displayDateRangePicker(context);
                    },
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Categories',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingContainer),
                  GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2.8,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: categoriesList.length,
                      semanticChildCount: 2,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: categoriesList[index].isSelect == true
                                  ? primaryColor
                                  : backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(categoriesList[index].catName!,
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          categoriesList[index].isSelect == true
                                              ? boldTextStyle.copyWith(
                                                  color: Colors.white)
                                              : boldTextStyle)
                                  .wrapPaddingAll(12),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (categoriesList[index].isSelect == true) {
                                categoriesList[index].isSelect = false;
                              } else {
                                categoriesList[index].isSelect = true;
                              }
                            });
                          },
                        );
                      }),
                  const SizedBox(height: spacingContainer),
                  Text('Prices',
                      style: boldLargeTextStyle.copyWith(
                          fontSize: textSizeNormal)),
                  const SizedBox(height: spacingContainer),
                  SliderTheme(
                      data: ThemeData.light().sliderTheme.copyWith(
                          valueIndicatorColor: primaryColor,
                          rangeTickMarkShape:
                              const RoundRangeSliderTickMarkShape(
                                  tickMarkRadius: 3),
                          rangeThumbShape: const RoundRangeSliderThumbShape(
                              enabledThumbRadius: 12,
                              elevation: 8,
                              pressedElevation: 16),
                          trackHeight: 5,
                          valueIndicatorTextStyle: const TextStyle(
                              backgroundColor: Colors.transparent,
                              color: Colors.white)),
                      child: RangeSlider(
                        values: _currentRangeValues,
                        min: 0,
                        max: 1000,
                        activeColor: primaryColor,
                        inactiveColor: primaryColor.withOpacity(0.5),
                        divisions: 10,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      )),
                  const SizedBox(height: spacingContainer),
                  const ButtonWidget(text: "Apply")
                      .wrapPaddingAll(spacingContainer),
                  const ButtonWidget(text: "Clear").wrapPadding(
                      padding: const EdgeInsets.only(
                          left: spacingContainer,
                          right: spacingContainer,
                          bottom: spacingContainer)),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
