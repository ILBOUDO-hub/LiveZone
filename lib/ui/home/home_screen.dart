import 'dart:io';
// import 'package:pwa_install/pwa_install.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/controllers/event_controller.dart';
import 'package:eventpro/controllers/story_controller.dart' as st;
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/event/event_details_screen.dart';
import 'package:eventpro/ui/event/ticket/ticket_list.dart';
import 'package:eventpro/ui/home/live.dart';
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/ui/setting/settings_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:status_view/status_view.dart';
import 'package:story_view/story_view.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:url_launcher/url_launcher.dart' as urlaunch;
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   void initDynamicLinks() async {
//
//   FirebaseDynamicLinks.instance.onLink(
//   onSuccess: (PendingDynamicLinkData dynamicLink) async {
//   final Uri deepLink = dynamicLink?.link;
//   print("deeplink found");
//   if (deepLink != null) {
//   print(deepLink);
//   Get.offAll(() => LogInPage(title: 'firebase_dynamic_link  navigation'));
//   }
//   }, onError: (OnLinkErrorException e) async {
//   print("deeplink error");
//   print(e.message);
//   });
// }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _animationController;

  List<String> attendeesList = [
    'assets/woman.png',
    'assets/man.png',
    'assets/woman_a.png'
  ];

  int selectedIndex = 0;
  String research = "";
  RxString categorie = "".obs;
  static String collectionDbName = 'stories';
  var controller = StoryController();

  //TODO: add possibility get data from any API
  CollectionReference dbInstance =
      FirebaseFirestore.instance.collection(collectionDbName);

  var screens = [
    // const EventListScreen(title: "Evenements",),
    MyPassScreen(),
    SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    final newVersion = NewVersionPlus(
      iOSId: 'com.easyPass.client',
      androidId: 'com.easyPass.eventpro_flutter',
    );
//  if(PWAInstall ().installPromptEnabled){
//   PWAInstall().promptInstall_();
//  }
    // advancedStatusCheck(newVersion);
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    try {
      final status = await newVersion.getVersionStatus();

      debugPrint(status!.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      if (status != null && status.storeVersion != status.localVersion) {
        newVersion.showUpdateDialog(
          launchModeVersion: LaunchModeVersion.external,
          context: context,
          versionStatus: status,
          dialogTitle: 'Mise à jour disponible',
          dialogText:
              'Mettez à jour votre application, pour profiter de ses nouvelles fonctionnalités',
          updateButtonText: "Màj",
          dismissButtonText: "plutard",
          allowDismissal: EventController.instance.updatefroce.value,
          dismissAction: () {
            Get.back();
          },
        );
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      bottomNavigationBar: ScreenTypeLayout.builder(mobile: (context) {
        return FloatingNavbar(
          borderRadius: 15,
          itemBorderRadius: 10,
          width: (Get.width > 475 ? 475 : Get.width) * 0.9,
          backgroundColor: primaryColor,
          onTap: (int val) async {
            //returns tab id which is user tapped
            if (MyAuthController.instance.firebaseUser.value != null) {
              setState(() {
                selectedIndex = val;
              });
            } else {
              Get.snackbar("Identification requise",
                  "Vous devez vous identifier avant de poursuivre",
                  backgroundColor: Colors.white, colorText: Colors.black);
              Get.to(() => LoginScreen());
            }
          },
          currentIndex: selectedIndex,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Accueil'),
            FloatingNavbarItem(icon: Icons.qr_code_2, title: 'Tickets'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Profiles')
          ],
        );
      }, desktop: (context) {
        return FloatingNavbar(
          borderRadius: 15,
          itemBorderRadius: 10,
          width: 400,
          backgroundColor: primaryColor,
          onTap: (int val) async {
            //returns tab id which is user tapped
            if (MyAuthController.instance.firebaseUser.value != null) {
              setState(() {
                selectedIndex = val;
              });
            } else {
              Get.snackbar(
                "Identification requise",
                "Vous devez vous identifiez avant de pouvoir continuer !",
                snackPosition: SnackPosition.TOP,
              );
              Get.to(() => LoginScreen());
            }
          },
          currentIndex: selectedIndex,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Accueil'),
            FloatingNavbarItem(icon: Icons.qr_code_2, title: 'Tickets'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Profiles')
          ],
        );
      }),
      extendBody: true,
      body: SafeArea(
        child: Obx(
          () => ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                },
              ),
              child: selectedIndex == 0
                  ? EventController.instance.isLoading == false
                      ? RefreshIndicator(
                          onRefresh: () async {
                            EventController.instance.geteventList();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: (Get.width > 475 ? 475 : Get.width),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Obx(() => SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...st.StoryController.instance
                                                  .stories
                                                  .where((p) => p.date
                                                      .isAfter(DateTime.now()))
                                                  .map(((element) => InkWell(
                                                        onTap: () {
                                                          Get.offAll(
                                                              () => StoryView(
                                                                    onComplete:
                                                                        () {
                                                                      st
                                                                          .StoryController
                                                                          .instance
                                                                          .prefs!
                                                                          .setInt(
                                                                              element.title,
                                                                              element.elements.length);
                                                                      Get.back();
                                                                    },
                                                                    onStoryShow:
                                                                        ((value) {
                                                                      //  int index_status =(element
                                                                      //             .elements
                                                                      //         as List<StoryItem>).indexOf(value);
                                                                      //         st.StoryController.instance.prefs!.setInt(element.title, index_status);
                                                                    }),
                                                                    indicatorColor:
                                                                        primaryColor,
                                                                    onVerticalSwipeComplete:
                                                                        (direction) {
                                                                      if (direction ==
                                                                          Direction
                                                                              .down) {
                                                                        Get.back();
                                                                      }
                                                                    },
                                                                    controller:
                                                                        controller,
                                                                    storyItems: element
                                                                            .elements
                                                                        as List<
                                                                            StoryItem>,
                                                                  ));
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: StatusView(
                                                            radius: 32,
                                                            spacing: 15,
                                                            strokeWidth: 2,
                                                            indexOfSeenStatus:
                                                                2,
                                                            numberOfStatus:
                                                                element.elements
                                                                    .length,
                                                            padding: 4,
                                                            centerImageUrl:
                                                                element
                                                                    .previewImage,
                                                            seenColor:
                                                                Colors.grey,
                                                            unSeenColor:
                                                                primaryColor,
                                                          ),
                                                        ),
                                                      )))
                                                  .toList()
                                            ],
                                          ),
                                        ))),


                                Text('LiveZone'),
                                Container(
                                  height: 100,
                                  child: livegram(),
                                ),

                                
                                InkWell(
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      width:
                                          (Get.width > 475 ? 475 : Get.width),
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(17.5)),
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
                                                  research =
                                                      value.toLowerCase();
                                                });
                                              }),
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Rechercher un evenement',
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
                                const SizedBox(height: spacingContainer),
                                SizedBox(
                                  height: 50,
                                  child: Obx(() => ListView.separated(
                                      itemCount: EventController
                                              .instance.categoriesList.length +
                                          1,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                            width: spacingStandard);
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 0) {
                                          return InkWell(
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: categorie.value == ""
                                                    ? primaryColor
                                                    : backgroundColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(45)),
                                                border: Border.all(
                                                  color: primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("Tous",
                                                        maxLines: 1,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: categorie
                                                                    .value ==
                                                                ""
                                                            ? boldTextStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white)
                                                            : boldTextStyle)
                                                    .wrapPaddingAll(12),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                categorie.value = "";
                                              });
                                            },
                                          );
                                        } else {
                                          return InkWell(
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: categorie.value ==
                                                        EventController
                                                            .instance
                                                            .categoriesList[
                                                                index - 1]
                                                            .catName!
                                                    ? primaryColor
                                                    : backgroundColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(45)),
                                                border: Border.all(
                                                  color: primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                        EventController
                                                            .instance
                                                            .categoriesList[
                                                                index - 1]
                                                            .catName!,
                                                        maxLines: 1,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: categorie
                                                                    .value ==
                                                                EventController
                                                                    .instance
                                                                    .categoriesList[
                                                                        index -
                                                                            1]
                                                                    .catName!
                                                            ? boldTextStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white)
                                                            : boldTextStyle)
                                                    .wrapPaddingAll(12),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                categorie.value =
                                                    EventController
                                                        .instance
                                                        .categoriesList[
                                                            index - 1]
                                                        .catName!;
                                              });
                                            },
                                          );
                                        }
                                      })),
                                ),
                                const SizedBox(height: spacingContainer),
                                const SizedBox(height: spacingContainer),
                                Obx(
                                  () => Container(
                                    height: 400.0 *
                                        (EventController.instance.events.value
                                                .where((element) {
                                              element as Event;
                                              return element.endDate
                                                  .isAfter(DateTime.now());
                                            }).where((element) {
                                              element as Event;
                                              if (categorie.value == "") {
                                                if (research == "") {
                                                  return true;
                                                } else {
                                                  return element.name
                                                      .toLowerCase()
                                                      .contains(research);
                                                }
                                              } else {
                                                if (research == "") {
                                                  return element.category ==
                                                      categorie.value;
                                                } else {
                                                  return element.category ==
                                                          categorie.value &&
                                                      element.name
                                                          .toLowerCase()
                                                          .contains(research);
                                                }
                                              }
                                            }).length +
                                            1),
                                    child: EventController.instance.events.value
                                            .where((element) {
                                      element as Event;
                                      return element.endDate
                                          .isAfter(DateTime.now());
                                    }).where((element) {
                                      element as Event;
                                      if (categorie.value == "") {
                                        if (research == "") {
                                          return true;
                                        } else {
                                          return element.name
                                              .toLowerCase()
                                              .contains(research);
                                        }
                                      } else {
                                        if (research == "") {
                                          return element.category ==
                                              categorie.value;
                                        } else {
                                          return element.category ==
                                                  categorie.value &&
                                              element.name
                                                  .toLowerCase()
                                                  .contains(research);
                                        }
                                      }
                                    }).isNotEmpty
                                        ? ListView.separated(
                                            itemCount: EventController
                                                .instance.events.value
                                                .where((element) {
                                              element as Event;
                                              return element.endDate.isAfter(
                                                  DateUtils.dateOnly(
                                                      DateTime.now()));
                                            }).where((element) {
                                              element as Event;
                                              if (categorie.value == "") {
                                                if (research == "") {
                                                  return true;
                                                } else {
                                                  return element.name
                                                      .toLowerCase()
                                                      .contains(research);
                                                }
                                              } else {
                                                if (research == "") {
                                                  return element.category ==
                                                      categorie.value;
                                                } else {
                                                  return element.category ==
                                                          categorie.value &&
                                                      element.name
                                                          .toLowerCase()
                                                          .contains(research);
                                                }
                                              }
                                            }).length,
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const SizedBox(
                                                  width: spacingContainer);
                                            },
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Event event = EventController
                                                  .instance.events.value
                                                  .where((element) {
                                                element as Event;
                                                return element.endDate.isAfter(
                                                    DateUtils.dateOnly(
                                                        DateTime.now()));
                                              }).where((element) {
                                                element as Event;
                                                if (categorie.value == "") {
                                                  if (research == "") {
                                                    return true;
                                                  } else {
                                                    return element.name
                                                        .toLowerCase()
                                                        .contains(research);
                                                  }
                                                } else {
                                                  if (research == "") {
                                                    return element.category ==
                                                        categorie.value;
                                                  } else {
                                                    return element.category ==
                                                            categorie.value &&
                                                        element.name
                                                            .toLowerCase()
                                                            .contains(research);
                                                  }
                                                }
                                              }).elementAt(index);
                                              int prix_min = 999999999999999;
                                              try {
                                                event.typeTicket!.forEach(
                                                  (element) {
                                                    element as TypeTicket;
                                                    if (element.prix <=
                                                        prix_min) {
                                                      prix_min = element.prix;
                                                    }
                                                  },
                                                );
                                              } catch (e) {}

                                              return InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Card(
                                                      color: Colors.white,
                                                      elevation: 8,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32.0),
                                                      ),
                                                      child: Container(
                                                        width: (Get.width > 475
                                                                ? 475
                                                                : Get.width) *
                                                            0.9,
                                                        constraints:
                                                            BoxConstraints(
                                                                minHeight: 275),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                DateFormat(
                                                                        "EEEE,d LLLL yyyy  H'h':m  ")
                                                                    .format(event
                                                                        .startDate),
                                                                style:
                                                                    normalTextStyle),
                                                            const SizedBox(
                                                                height:
                                                                    spacingStandard),
                                                            Text(event.name,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: true,
                                                                style:
                                                                    boldLargeTextStyle),
                                                            const SizedBox(
                                                                height:
                                                                    spacingStandard),
                                                            SizedBox(
                                                              width: (Get.width >
                                                                      475
                                                                  ? 475
                                                                  : Get.width),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                      'assets/location.png',
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          20),
                                                                  Expanded(
                                                                    child: Text(
                                                                      event
                                                                          .nomLieu,
                                                                      style:
                                                                          smallNormalTextStyle,
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height:
                                                                    spacingStandard),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  height: 40,
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: attendeesList
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          itemBuilder: (BuildContext context,
                                                                              int
                                                                                  index) {
                                                                            return index == attendeesList.length - 1
                                                                                ? Align(
                                                                                    widthFactor: 0.7,
                                                                                    alignment: Alignment.bottomRight,
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.grey[700],
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                                                        border: Border.all(
                                                                                          color: Colors.white,
                                                                                          width: 2,
                                                                                        ),
                                                                                      ),
                                                                                      width: 40,
                                                                                      height: 40,
                                                                                      child: const Icon(Icons.add, color: Colors.white),
                                                                                    ),
                                                                                  )
                                                                                : InkWell(
                                                                                    borderRadius: BorderRadius.circular(32.0),
                                                                                    child: Align(
                                                                                      widthFactor: 0.7,
                                                                                      alignment: Alignment.bottomRight,
                                                                                      child: Image.asset(
                                                                                        attendeesList[index],
                                                                                        width: 40,
                                                                                        fit: BoxFit.fill,
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () {
                                                                                      setState(() {});
                                                                                    },
                                                                                  );
                                                                          }).wrapPadding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              spacingContainer,
                                                                          right:
                                                                              spacingStandard)),
                                                                ),
                                                                Ink(
                                                                  decoration: const BoxDecoration(
                                                                      color:
                                                                          primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(30))),
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    constraints: const BoxConstraints(
                                                                        minWidth:
                                                                            85,
                                                                        minHeight:
                                                                            40),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      event.isfree ==
                                                                              true
                                                                          ? 'Entrée libre'
                                                                          : '${prix_min < 99999999 ? prix_min : (event.typeTicket![0] as TypeTicket).prix} CFA',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: boldTextStyle.copyWith(
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
                                                                top:
                                                                    spacingLarge *
                                                                        3,
                                                                left:
                                                                    spacingContainer,
                                                                right:
                                                                    spacingContainer,
                                                                bottom:
                                                                    spacingContainer)),
                                                      ),
                                                    ).wrapPadding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: spacingLarge *
                                                                2)),
                                                    Positioned(
                                                      top: 0,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        child:
                                                            FancyShimmerImage(
                                                          imageUrl: event
                                                              .coverPictures[0],
                                                          // width: 230,
                                                          height: 150,
                                                          boxFit: BoxFit.cover,
                                                          boxDecoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            // shape: BoxShape.circle
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ).wrapPadding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        bottom:
                                                            spacingContainer)),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      SlideRightRoute(
                                                          page:
                                                              EventDetailsScreen(
                                                                  event:
                                                                      event)));
                                                },
                                              );
                                            })
                                        : Container(
                                            width: (Get.width > 475
                                                ? 475
                                                : Get.width),
                                            height: Get.height * 0.4,
                                            child: Column(
                                              children: [
                                                Text(
                                                    "Aucun evenements pour le moment",
                                                    style:
                                                        mediumLargeTextStyle),
                                                Image.asset(
                                                  "assets/magnifying-glass.png",
                                                  width: (Get.width > 475
                                                          ? 475
                                                          : Get.width) *
                                                      0.7,
                                                  height: (Get.width > 475
                                                          ? 475
                                                          : Get.width) *
                                                      0.7,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    EventController.instance
                                                        .geteventList();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Rafraîchir la liste",
                                                          style:
                                                              mediumLargeTextStyle),
                                                      Icon(Icons
                                                          .refresh_outlined),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ).wrapPaddingAll(spacingContainer),
                          ),
                        )
                      : Center(
                          child: LoadingAnimationWidget.twistingDots(
                            leftDotColor: const Color.fromARGB(255, 0, 0, 0),
                            rightDotColor: primaryColor,
                            size: 150,
                          ),
                        )
                  : screens[selectedIndex - 1]),
        ),
      ),
    );
  }

  _navItem(String logoPath, String title) {
    return Row(children: [
      Image.asset(
        logoPath,
        height: 26,
        width: 26,
      ),
      Text(title, style: boldLargeTextStyle.copyWith(color: Colors.white))
          .addMarginLeft(spacingContainer)
    ]);
  }
}

class Categories {
  String? catName;
  bool? isSelect = false;

  Categories(this.catName, this.isSelect);
}
