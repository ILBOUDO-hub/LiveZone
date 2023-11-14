/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:eventpro/controllers/event_controller.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/event/search_screen.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/values.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'event_details_screen.dart';
import 'filter_screen.dart';

class EventListScreen extends StatefulWidget {
  final String? title;

  const EventListScreen({Key? key, this.title}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<String> eventList = [
    'assets/event_a.jpg',
    'assets/event_b.jpg',
  ];

  List<String> attendeesList = [
    'assets/woman.png',
    'assets/man.png',
  ];
  String research= "";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
          backgroundColor: backgroundColor,
          appBar: AppBar(title: Text(widget.title!,style: normalLargeTextStyle,),
          backgroundColor: Colors.white,
          leading: BackButton(color: primaryColor,onPressed: ()=>Get.off(HomeScreen()),),
          elevation: 0,) ,//toolbarBack(widget.title!, context),
          body:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height*0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: TextFormField(
                                        style: mediumTextStyle,
                                        cursorColor: primaryColor,
                                        onChanged: ((value) {
                                          
                                          setState(() {
                                            research = value;
                                          });
                                        }),
                                        decoration: InputDecoration(
                                            hintText: 'Recherhcer un evenement',
                                            enabled: true,
                                            border: InputBorder.none,
                                            hintStyle: mediumTextStyle))
                                    .wrapPadding(
                                        padding: const EdgeInsets.only(
                                            left: spacingContainer,
                                            right: spacingContainer)),
                              ),
                            ),
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                  EventController.instance.events.value.where((element) {
                      element as Event;
                      if(widget.title=="Evenements"){
                        if(research==""){
                          return true;
                        }else{
                          return element.name.contains(research);
                        }
                      }else{
                        if(research==""){
                      return element.category == widget.title ;
                      }
                      else{
                      return element.category == widget.title && element.name.contains(research);
                      }
                      }

                    }).isNotEmpty ? Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: (Get.height *0.6) * EventController.instance.events.value.where((element) {
                            element as Event;
                             if(widget.title=="Evenements"){
                              if(research==""){
                                return true;
                              }else{
                                return element.name.contains(research);
                              }
                            }else{
                              if(research==""){
                            return element.category == widget.title ;
                            }
                            else{
                            return element.category == widget.title && element.name.contains(research);
                            }
                            }
                          }).length ,
                          child: GridView.builder(
                            // padding: EdgeInsets.only(bottom: Get.height*0.5),
                            physics: NeverScrollableScrollPhysics(),
                            clipBehavior: Clip.none,
                          itemCount:  EventController.instance.events.value.where((element) {
                            element as Event;
                             if(widget.title=="Evenements"){
                              if(research==""){
                                return true;
                              }else{
                                return element.name.contains(research);
                              }
                            }else{
                              if(research==""){
                            return element.category == widget.title ;
                            }
                            else{
                            return element.category == widget.title && element.name.contains(research);
                            }
                            }
                          }).length ,
                          // shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1,
                              mainAxisSpacing: 16),
                          itemBuilder: (BuildContext context, int index) {
                              Event event = EventController.instance.events.where((element) {
                            element as Event;
                                                      if(widget.title=="Evenements"){
                              if(research==""){
                                return true;
                              }else{
                                return element.name.contains(research);
                              }
                            }else{
                              if(research==""){
                            return element.category == widget.title ;
                            }
                            else{
                            return element.category == widget.title && element.name.contains(research);
                            }}
                          }).elementAt(index);
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                                                  onTap: () {
                                  Navigator.of(context).push(SlideRightRoute(
                                      page:  EventDetailsScreen(event :event)));
                                },
                                    child:Card(
                                      color: Colors.white,
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32.0),
                                      ),
                                      child: SizedBox(
                                        width: Get.width*0.8,
                                        height: Get.height*0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(DateFormat("EEEE,d LLLL yyyy  H'h':m  ").format(event.startDate),
                                                style: normalTextStyle),
                                            const SizedBox(
                                                height: spacingStandard),
                                            Text(
                                                event.name,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: boldLargeTextStyle),
                                            const SizedBox(
                                                height: spacingStandard),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/location.png',
                                                    height: 20, width: 20),
                                                Text(event.nomLieu,
                                                        style: smallNormalTextStyle
                                                        ,
                                                        maxLines: 2,)
                                                    .addMarginLeft(
                                                        spacingControl),
                                              ],
                                            ),
                                            const SizedBox(
                                                height: spacingStandard),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                          itemCount: attendeesList
                                                              .length,
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          scrollDirection: Axis
                                                              .horizontal,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return index ==
                                                                    attendeesList
                                                                            .length -
                                                                        1
                                                                ? Align(
                                                                    widthFactor:
                                                                        0.7,
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                                .grey[
                                                                            700],
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                50)),
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          color: Colors
                                                                              .white,
                                                                          width:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      width: 40,
                                                                      height: 40,
                                                                      child: const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                  )
                                                                : InkWell(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                32.0),
                                                                    child: Align(
                                                                      widthFactor:
                                                                          0.7,
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child: Image
                                                                          .asset(
                                                                        attendeesList[
                                                                            index],
                                                                        width: 40,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  );
                                                          })
                                                      .wrapPadding(
                                                          padding: const EdgeInsets
                                                                  .only(
                                                              left:
                                                                  spacingContainer,
                                                              right:
                                                                  spacingStandard)),
                                                ),
                                                Ink(
                                                  decoration: const BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 85,
                                                            minHeight: 40),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${(event.typeTicket![0] as TypeTicket).prix} CFA',
                                                      textAlign: TextAlign.center,
                                                      style:
                                                          boldTextStyle.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ).wrapPadding(
                                            padding: const EdgeInsets.only(
                                                top: spacingLarge * 3,
                                                left: spacingContainer,
                                                right: spacingContainer,
                                                bottom: spacingContainer)),
                                      ),
                                    ).wrapPadding(
                                       
                                        padding: const EdgeInsets.only(
                                            top: spacingLarge * 2)),
                                  ),
                                  Positioned(
                                    top: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: FancyShimmerImage( imageUrl: event.coverPictures[0],
                                          // width: 230,
                                          height: 150,
                                           boxFit: BoxFit.contain),
                                    ),
                                  )
                                ],
                              ).wrapPadding(
                                  padding: const EdgeInsets.only(
                                      bottom: spacingContainer));
                            }),
                        ),
                      ),
                    ) : 
                      Container(
                        width: Get.width,
                        child: Column(

                          children: [
                            Text("Aucun evenements Disponible",style :mediumLargeTextStyle),

                            Image.asset("assets/magnifying-glass.png",width: Get.width*0.7,height: Get.width*0.7,),
                          ],
                        ),
                      ),
               
                ],
              )
          //   },
          // )
          ),
    );
  }
}
