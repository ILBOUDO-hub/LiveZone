import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/event/event_book_screen.dart';
import 'package:eventpro/ui/event/ticket/type_ticket_screen.dart';
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EventDetailsScreen extends StatelessWidget {
  Event event;
  var controller = ScrollController();
  EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int prix_min = 999999;
    int prix_max = 0;
    for (var e in event.typeTicket!) {
      e as TypeTicket;
      if (e.prix > prix_max) {
        prix_max = e.prix;
      }
      if (e.prix < prix_min) {
        prix_min = e.prix;
      }
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // print(event.typeTicket);
    return ScreenTypeLayout.builder(
        desktop: (p0) => Center(
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch,
                    },
                  ),
                  child: SafeArea(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                        ),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: Get.width,
                                // height: Get.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                          height: kIsWeb || Platform.isWindows
                                              ? 300
                                              : Get.height * 0.375,
                                          enableInfiniteScroll: true,
                                          aspectRatio: 16 / 9,
                                          enlargeCenterPage: true,
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          scrollDirection: Axis.horizontal,
                                          onPageChanged: (index, reason) {}),
                                      items: event.coverPictures
                                          .map((item) => GestureDetector(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                  child: Center(
                                                      child: FancyShimmerImage(
                                                          imageUrl: item,
                                                          boxFit: BoxFit.cover,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width)),
                                                ),
                                                onTap: () {},
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Chip(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            backgroundColor: primaryColor,
                                            label: Text(
                                              event.category,
                                              style: mediumLargeTextStylewhite,
                                            )),
                                        //                       IconButton(onPressed: () async{

                                        //                             final DynamicLinkParameters parameters = DynamicLinkParameters(
                                        //                               uriPrefix: 'https://easypass.page.link',
                                        //                               link: Uri.parse(
                                        //                                 "https://easypass.page.link/?link=https://easypass.page.link?${event.name.toUpperCase().trim().replaceAll(' ', '')}&apn=com.easyPass.eventpro_flutter&isi=6444022839&ibi=com.easyPass.client"
                                        //                                 ),
                                        //                              longDynamicLink: Uri.parse("https://easypass.page.link/?link=https://easypass.page.link?${event.name.toUpperCase().trim().replaceAll(' ', '')}&apn=com.easyPass.eventpro_flutter&isi=6444022839&ibi=com.easyPass.client"),

                                        //                               androidParameters: const AndroidParameters(
                                        //                                 packageName: 'com.easyPass.eventpro_flutter',
                                        //                                 minimumVersion: 5,
                                        //                               ),
                                        //                               iosParameters: const IOSParameters(
                                        //                                 bundleId: 'com.easyPass.client',
                                        //                                 minimumVersion: "3.1",
                                        //                                 appStoreId: "6444022839"
                                        //                               ),
                                        //                             );
                                        //                             String? _deepLink;
                                        //  final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance .buildShortLink(parameters);
                                        //  Uri url = shortLink.shortUrl;
                                        //    _deepLink = url.toString();
                                        //    debugPrint(_deepLink);
                                        //    Share.share("Salut ! Je voulais juste partager avec vous le lien pour acheter des billets pour ${event.name} incroyable qui arrive bientôt. Vous pouvez obtenir vos billets ici :  ${_deepLink}. Ne manquez pas cette opportunité de vivre une expérience unique et passionnante ");
                                        //                       }, icon: const Icon(Icons.share))
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width,
                                      // height: Get.height * 0.1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(event.name,
                                                  style: mediumLargeTextStyle)
                                              .addMarginTop(spacingContainer),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.date_range,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          !DateUtils.isSameDay(event.endDate,
                                                  event.startDate)
                                              ? " Du ${DateFormat("EEEE,d LLLL yyyy 'a' H'h':mm ").format(event.startDate)}"
                                              : DateFormat(
                                                      "EEEE,d LLLL yyyy 'a' H'h':mm ")
                                                  .format(event.startDate),
                                          style: smallMediumTextStyle,
                                          maxLines: 2,
                                        ).addMarginTop(spacingStandard),
                                      ],
                                    ),
                                    !DateUtils.isSameDay(
                                            event.endDate, event.startDate)
                                        ? Row(
                                            children: [
                                              const Icon(
                                                Icons.date_range,
                                                color: primaryColor,
                                              ),
                                              Text(
                                                !DateUtils.isSameDay(
                                                        event.endDate,
                                                        event.startDate)
                                                    ? "au ${DateFormat("EEEE,d LLLL yyyy 'a' H'h':mm ").format(event.endDate)}"
                                                    : DateFormat(
                                                            "EEEE,d LLLL yyyy 'a' H'h':mm ")
                                                        .format(event.endDate),
                                                style: smallMediumTextStyle,
                                                maxLines: 2,
                                              ).addMarginTop(spacingStandard),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(height: spacingStandard),
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              Image.asset('assets/location.png',
                                                  height: 20, width: 20),
                                              Expanded(
                                                child: Text(event.nomLieu,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        style: mediumTextStyle)
                                                    .addMarginLeft(
                                                        spacingControl),
                                              )
                                            ]),
                                          ),
                                          Column(children: [
                                            IconButton(
                                              onPressed: (() async {
                                                try {
                                                  // debutPrint("Map redirect");
                                                  final availableMaps =
                                                      await MapLauncher
                                                          .installedMaps;
                                                  if (kDebugMode) {} // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                                  await availableMaps.first
                                                      .showMarker(
                                                    coords: Coords(
                                                        event.lieu!.latitude,
                                                        event.lieu!.longitude),
                                                    title: event.nomLieu,
                                                  );
                                                } catch (e) {
                                                  Get.showSnackbar(
                                                      const GetSnackBar(
                                                    title:
                                                        "Lieu non repertorié",
                                                    message:
                                                        "Ce Lieu est introuvables sur la carte!",
                                                    duration:
                                                        Duration(seconds: 5),
                                                  ));
                                                }
                                              }),
                                              icon: const Icon(Icons.directions,
                                                  color: primaryColor,
                                                  size: 34),
                                            ),
                                            Text(
                                              "Voir le lieu",
                                              style: smallBoldTextStyle,
                                            )
                                          ])
                                        ],
                                      ),
                                    ),
                                    Text('Details',
                                        style: boldLargeTextStyle.copyWith(
                                            fontSize: textSizeNormal)),
                                    const SizedBox(height: spacingStandard),
                                    Text(event.description,
                                        style: normalTextStyle),
                                    const SizedBox(height: spacingContainer),
                                  ],
                                ).wrapPaddingAll(spacingContainer),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                appBar: PreferredSize(
                  preferredSize: Size(500, 100),
                  child: Center(
                    child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: Text(
                        "Organisé par :${event.organisateur.name}",
                        style: mediumLargeTextStyle,
                      ),
                      leadingWidth: 50,
                      leading: BackButton(
                        color: primaryColor,
                        onPressed: (() {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                          Navigator.pop(context);
                        }),
                      ),
                      // child: Container(
                      //   width: 40,
                      //   height: 40,
                      //   decoration: const BoxDecoration(
                      //       shape: BoxShape.circle, color: primaryColor),
                      //   child: Center(
                      //       child: Image.asset(
                      //     "assets/arrow.png",
                      //     height: 24,
                      //     width: 24,
                      //   )),
                      // ),

                      //       BackButton(
                      //                  color: primaryColor,
                      //                   onPressed: () {
                      //                      SystemChrome.setPreferredOrientations([
                      //   DeviceOrientation.landscapeRight,
                      //   DeviceOrientation.landscapeLeft,
                      //   DeviceOrientation.portraitUp,
                      //   DeviceOrientation.portraitDown,
                      // ]);
                      //                     Navigator.pop(context);

                      //                   },
                      //                 ).wrapPaddingAll(spacingContainer),
                    ),
                  ),
                ),
                bottomNavigationBar: event.isfree == true
                    ? event.need_reservation == true
                        ? Container(
                            padding: EdgeInsets.zero,
                            width: 500,
                            height: Get.height * 0.1,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                      spreadRadius: 0)
                                ]),
                            child: Center(
                              child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  color: primaryColor,
                                  child: Text(
                                    "Reserver ma place",
                                    style: mediumLargeTextStylewhite,
                                  ),
                                  onPressed: () async {
                                    if (MyAuthController
                                            .instance.firebaseUser.value ==
                                        null) {
                                      Get.showSnackbar(GetSnackBar(
                                        title: "Connection requise",
                                        message:
                                            "Veuillez vous connectez pour poursuivre l'achet de vos ticket",
                                        duration: Duration(seconds: 10),
                                      ));

                                      Get.to(() => LoginScreen());
                                    } else {
                                      var ticket;

                                      ticket = await TicketController.instance
                                          .createFreeTicket(
                                              event.id!,
                                              TypeTicket(
                                                  prix: 0,
                                                  name: "Reservation",
                                                  description: "",
                                                  dateDebutValidite:
                                                      event.startDate,
                                                  dateFinValidite:
                                                      event.endDate),
                                              event.coverPictures[0],
                                              event,
                                              context);

                                      Get.to(() => EventBookScreen(
                                            ticket: ticket,
                                            isOk: true,
                                          ));
                                    }
                                  }),
                            ))
                        : null
                    : Container(
                        padding: EdgeInsets.zero,
                        width: 500,
                        height: Get.height * 0.1,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ]),
                        child: Center(
                          child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              color: primaryColor,
                              child: Text(
                                "Acheter un ticket",
                                style: mediumLargeTextStylewhite,
                              ),
                              onPressed: () {
                                Get.to(() => TypeTicketScreen(
                                      e: event,
                                    ));
                              }),
                        ),
                      ),
              ),
            ),
        mobile: (context) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                },
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width,
                        // height: Get.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: kIsWeb || Platform.isWindows
                                      ? 300
                                      : Get.height * 0.375,
                                  enableInfiniteScroll: true,
                                  aspectRatio: 16 / 9,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {}),
                              items: event.coverPictures
                                  .map((item) => GestureDetector(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0)),
                                          child: Center(
                                              child: FancyShimmerImage(
                                                  imageUrl: item,
                                                  boxFit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width)),
                                        ),
                                        onTap: () {},
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    backgroundColor: primaryColor,
                                    label: Text(
                                      event.category,
                                      style: mediumLargeTextStylewhite,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      final DynamicLinkParameters parameters =
                                          DynamicLinkParameters(
                                        uriPrefix: 'https://easypass.page.link',
                                        link: Uri.parse(
                                            "https://easypass.page.link/?link=https://easypass.page.link?${event.name.toUpperCase().trim().replaceAll(' ', '')}&apn=com.easyPass.eventpro_flutter&isi=6444022839&ibi=com.easyPass.client"),
                                        longDynamicLink: Uri.parse(
                                            "https://easypass.page.link/?link=https://easypass.page.link?${event.name.toUpperCase().trim().replaceAll(' ', '')}&apn=com.easyPass.eventpro_flutter&isi=6444022839&ibi=com.easyPass.client"),
                                        androidParameters:
                                            const AndroidParameters(
                                          packageName:
                                              'com.easyPass.eventpro_flutter',
                                          minimumVersion: 5,
                                        ),
                                        iosParameters: const IOSParameters(
                                            bundleId: 'com.easyPass.client',
                                            minimumVersion: "3.1",
                                            appStoreId: "6444022839"),
                                      );
                                      String? _deepLink;
                                      final ShortDynamicLink shortLink =
                                          await FirebaseDynamicLinks.instance
                                              .buildShortLink(parameters);
                                      Uri url = shortLink.shortUrl;
                                      _deepLink = url.toString();
                                      debugPrint(_deepLink);
                                      Share.share(
                                          "Salut ! Je voulais juste partager avec vous le lien pour acheter des billets pour ${event.name} incroyable qui arrive bientôt. Vous pouvez obtenir vos billets ici :  ${_deepLink}. Ne manquez pas cette opportunité de vivre une expérience unique et passionnante ");
                                    },
                                    icon: const Icon(Icons.share))
                              ],
                            ),
                            SizedBox(
                              width: Get.width,
                              // height: Get.height * 0.1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(event.name, style: mediumLargeTextStyle)
                                      .addMarginTop(spacingContainer),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: primaryColor,
                                ),
                                Text(
                                  !DateUtils.isSameDay(
                                          event.endDate, event.startDate)
                                      ? " Du ${DateFormat("EEEE,d LLLL yyyy 'a' H'h':mm ").format(event.startDate)}"
                                      : DateFormat(
                                              "EEEE,d LLLL yyyy 'a' H'h':mm ")
                                          .format(event.startDate),
                                  style: smallMediumTextStyle,
                                  maxLines: 2,
                                ).addMarginTop(spacingStandard),
                              ],
                            ),
                            !DateUtils.isSameDay(event.endDate, event.startDate)
                                ? Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        !DateUtils.isSameDay(
                                                event.endDate, event.startDate)
                                            ? "au ${DateFormat("EEEE,d LLLL yyyy 'a' H'h':mm ").format(event.endDate)}"
                                            : DateFormat(
                                                    "EEEE,d LLLL yyyy 'a' H'h':mm ")
                                                .format(event.endDate),
                                        style: smallMediumTextStyle,
                                        maxLines: 2,
                                      ).addMarginTop(spacingStandard),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(height: spacingStandard),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(children: [
                                      Image.asset('assets/location.png',
                                          height: 20, width: 20),
                                      Expanded(
                                        child: Text(event.nomLieu,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: mediumTextStyle)
                                            .addMarginLeft(spacingControl),
                                      )
                                    ]),
                                  ),
                                  Column(children: [
                                    IconButton(
                                      onPressed: (() async {
                                        try {
                                          // debutPrint("Map redirect");
                                          final availableMaps =
                                              await MapLauncher.installedMaps;
                                          if (kDebugMode) {} // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                          await availableMaps.first.showMarker(
                                            coords: Coords(event.lieu!.latitude,
                                                event.lieu!.longitude),
                                            title: event.nomLieu,
                                          );
                                        } catch (e) {
                                          Get.showSnackbar(const GetSnackBar(
                                            title: "Lieu non repertorié",
                                            message:
                                                "Ce Lieu est introuvables sur la carte!",
                                            duration: Duration(seconds: 5),
                                          ));
                                        }
                                      }),
                                      icon: const Icon(Icons.directions,
                                          color: primaryColor, size: 34),
                                    ),
                                    Text(
                                      "Voir le lieu",
                                      style: smallBoldTextStyle,
                                    )
                                  ])
                                ],
                              ),
                            ),
                            Text('Details',
                                style: boldLargeTextStyle.copyWith(
                                    fontSize: textSizeNormal)),
                            const SizedBox(height: spacingStandard),
                            Text(event.description, style: normalTextStyle),
                            const SizedBox(height: spacingContainer),
                          ],
                        ).wrapPaddingAll(spacingContainer),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Organisé par :${event.organisateur.name}",
                style: mediumLargeTextStyle,
              ),
              leadingWidth: 50,
              leading: BackButton(
                color: primaryColor,
                onPressed: (() {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                  Navigator.pop(context);
                }),
              ),
              // child: Container(
              //   width: 40,
              //   height: 40,
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.circle, color: primaryColor),
              //   child: Center(
              //       child: Image.asset(
              //     "assets/arrow.png",
              //     height: 24,
              //     width: 24,
              //   )),
              // ),

              //       BackButton(
              //                  color: primaryColor,
              //                   onPressed: () {
              //                      SystemChrome.setPreferredOrientations([
              //   DeviceOrientation.landscapeRight,
              //   DeviceOrientation.landscapeLeft,
              //   DeviceOrientation.portraitUp,
              //   DeviceOrientation.portraitDown,
              // ]);
              //                     Navigator.pop(context);

              //                   },
              //                 ).wrapPaddingAll(spacingContainer),
            ),
            bottomNavigationBar: event.isfree == true
                ? event.need_reservation == true
                    ? Container(
                        padding: EdgeInsets.zero,
                        width: Get.width,
                        height: Get.height * 0.1,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ]),
                        child: Center(
                          child: CupertinoButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              color: primaryColor,
                              child: Text(
                                "Reserver ma place",
                                style: mediumLargeTextStylewhite,
                              ),
                              onPressed: () async {
                                if (MyAuthController
                                        .instance.firebaseUser.value ==
                                    null) {
                                  Get.showSnackbar(GetSnackBar(
                                    title: "Connection requise",
                                    message:
                                        "Veuillez vous connectez pour poursuivre l'achet de vos ticket",
                                    duration: Duration(seconds: 10),
                                  ));

                                  Get.to(() => LoginScreen());
                                } else {
                                  var ticket;

                                  ticket = await TicketController.instance
                                      .createFreeTicket(
                                          event.id!,
                                          TypeTicket(
                                              prix: 0,
                                              name: "Reservation",
                                              description: "",
                                              dateDebutValidite:
                                                  event.startDate,
                                              dateFinValidite: event.endDate),
                                          event.coverPictures[0],
                                          event,
                                          context);

                                  Get.to(() => EventBookScreen(
                                        ticket: ticket,
                                        isOk: true,
                                      ));
                                }
                              }),
                        ))
                    : null
                : Container(
                    padding: EdgeInsets.zero,
                    width: Get.width,
                    height: Get.height * 0.1,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ]),
                    child: Center(
                      child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          color: primaryColor,
                          child: Text(
                            "Acheter un ticket",
                            style: mediumLargeTextStylewhite,
                          ),
                          onPressed: () {
                            if (MyAuthController.instance.firebaseUser.value ==
                                null) {
                              print(MyAuthController
                                  .instance.selected_event_before_auth.value);
                              print(event.name);
                              MyAuthController
                                  .instance
                                  .selected_event_before_auth
                                  .value = event.name;
                              Get.showSnackbar(GetSnackBar(
                                title: "Connection requise",
                                message:
                                    "Veuillez vous connectez pour poursuivre l'achet de vos ticket",
                                duration: Duration(seconds: 10),
                              ));
                              print(MyAuthController
                                  .instance.selected_event_before_auth.value);
                              Get.to(() => LoginScreen());
                            } else {
                              Get.to(() => TypeTicketScreen(
                                    e: event,
                                  ));
                            }
                          }),
                    ),
                  ),
          );
        });
  }
}
