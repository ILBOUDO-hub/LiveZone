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

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<String> eventList = [
    'Event Pro',
    'Event Media',
    'Event Talk',
    'Event Movie',
    'Social Post',
    'GDE Event',
    'Laugh With RR',
    'Kite Festival'
  ];
  var items = [];

  @override
  void initState() {
    super.initState();
    items.addAll(eventList);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: toolbarBack("Search", context),
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: context.width,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: TextFormField(
                                  controller: searchController,
                                  style: mediumLargeTextStyle,
                                  cursorColor: primaryColor,
                                  onChanged: (String? search) {
                                    if (search != null && search.length >= 3) {
                                      filterSearchResults(search);
                                    } else {
                                      filterSearchResults('');
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Search event',
                                      border: InputBorder.none,
                                      hintStyle: mediumLargeTextStyle))
                              .wrapPadding(
                                  padding: const EdgeInsets.only(
                                      left: spacingContainer,
                                      right: spacingLarge * 1.3)),
                        ),
                      ),
                      Positioned(
                        child: InkWell(
                            child: const Icon(Icons.cancel_rounded,
                                color: primaryColor),
                            onTap: () {
                              searchController.clear();
                              filterSearchResults('');
                            }),
                        right: 16,
                      )
                    ],
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      width: context.width,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ListView.separated(
                          itemCount: items.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: spacingContainer);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child:
                                  Text(items[index], style: boldLargeTextStyle)
                                      .wrapPadding(
                                          padding: const EdgeInsets.only(
                                              right: spacingContainer)),
                              onTap: () {
                                Navigator.pop(context, items[index]);
                              },
                            );
                          }).wrapPaddingAll(spacingContainer),
                    ),
                  )
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(eventList);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(eventList);
      });
    }
  }
}
