import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:eventpro/models/ticket.dart';
import 'package:eventpro/ui/event/ticket/ticket_list.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EventBookScreen extends StatelessWidget {
  Ticket ticket;
  bool isOk = true;
  EventBookScreen({Key? key, required this.ticket, required this.isOk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenTypeLayout.builder(
        desktop: (_) => Scaffold(
            backgroundColor: backgroundColor,
            appBar: null, //toolbarBack("Event Booking", context),
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
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/success.png',
                          width: Get.height * 0.15,
                          height: Get.height * 0.15,
                        ),
                      ),
                      const SizedBox(height: spacingContainer),
                      Text("Succès de l'achat du ticket",
                          style: mediumLargeTextStyle),
                      const SizedBox(height: spacingContainer),
                      Text(
                        "Vous avez Achetez un ticket ${ticket.typeTicket.name} valable à partir du ${DateFormat("EEEE,d LLL HH'h':mm").format(ticket.typeTicket.dateDebutValidite)}",
                        style: mediumTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      QrImageView(
                        data: ticket.code,
                        version: QrVersions.auto,
                        size: 150,
                        gapless: false,
                        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
                        foregroundColor: primaryColor,
                      ).addMarginTop(spacingStandard),
                      ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          Get.offAll(HomeScreen());
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                              minHeight: buttonHeight),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/share.png',
                              //   color: Colors.white,
                              //   height: 34,
                              //   width: 34,
                              // ),
                              Text(
                                'Retour',
                                textAlign: TextAlign.center,
                                style: boldLargeTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: textSizeNormal),
                              ).addMarginLeft(16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: spacingContainer),
                      ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          Get.offAll(MyPassScreen());
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                              minHeight: buttonHeight),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/share.png',
                              //   color: Colors.white,
                              //   height: 34,
                              //   width: 34,
                              // ),
                              Text(
                                'Mes tickets',
                                textAlign: TextAlign.center,
                                style: boldLargeTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: textSizeNormal),
                              ).addMarginLeft(16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: spacingContainer),
                      ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          Add2Calendar.addEvent2Cal(Event(
                              title: "${ticket.event.name}",
                              description:
                                  "La date de ${ticket.event.name} est proche",
                              startDate: ticket.typeTicket.dateDebutValidite,
                              endDate: ticket.typeTicket.dateFinValidite,
                              allDay: false,
                              iosParams:
                                  IOSParams(reminder: Duration(hours: 1)),
                              androidParams: AndroidParams()));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                              minHeight: buttonHeight),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/share.png',
                              //   color: Colors.white,
                              //   height: 34,
                              //   width: 34,
                              // ),
                              Text(
                                'Ajouter à mon agenda',
                                textAlign: TextAlign.center,
                                style: boldLargeTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: textSizeNormal),
                              ).addMarginLeft(16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).wrapPaddingAll(spacingContainer),
                ),
              ),
            )),
        mobile: (_) => Scaffold(
            backgroundColor: backgroundColor,
            appBar: null, //toolbarBack("Event Booking", context),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/success.png',
                        width: Get.height * 0.15,
                        height: Get.height * 0.15,
                      ),
                    ),
                    const SizedBox(height: spacingContainer),
                    Text("Succès de l'achat du ticket",
                        style: mediumLargeTextStyle),
                    const SizedBox(height: spacingContainer),
                    Text(
                      "Vous avez Achetez un ticket ${ticket.typeTicket.name} valable à partir du ${DateFormat("EEEE,d LLL HH'h':mm").format(ticket.typeTicket.dateDebutValidite)}",
                      style: mediumTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    QrImageView(
                      data: ticket.code,
                      size: 150,
                    ).addMarginTop(spacingStandard),
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Get.offAll(HomeScreen());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5,
                            minHeight: buttonHeight),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //   'assets/share.png',
                            //   color: Colors.white,
                            //   height: 34,
                            //   width: 34,
                            // ),
                            Text(
                              'Retour',
                              textAlign: TextAlign.center,
                              style: boldLargeTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: textSizeNormal),
                            ).addMarginLeft(16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: spacingContainer),
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Get.offAll(MyPassScreen());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5,
                            minHeight: buttonHeight),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //   'assets/share.png',
                            //   color: Colors.white,
                            //   height: 34,
                            //   width: 34,
                            // ),
                            Text(
                              'Mes tickets',
                              textAlign: TextAlign.center,
                              style: boldLargeTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: textSizeNormal),
                            ).addMarginLeft(16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: spacingContainer),
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Add2Calendar.addEvent2Cal(Event(
                            title: "${ticket.event.name}",
                            description:
                                "La date de ${ticket.event.name} est proche",
                            startDate: ticket.typeTicket.dateDebutValidite,
                            endDate: ticket.typeTicket.dateFinValidite,
                            allDay: false,
                            iosParams: IOSParams(reminder: Duration(hours: 1)),
                            androidParams: AndroidParams()));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: buttonHeight),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //   'assets/share.png',
                            //   color: Colors.white,
                            //   height: 34,
                            //   width: 34,
                            // ),
                            Text(
                              'Ajouter à mon agenda',
                              textAlign: TextAlign.center,
                              style: boldLargeTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: textSizeNormal),
                            ).addMarginLeft(16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).wrapPaddingAll(spacingContainer),
              ),
            )),
      ),
    );
  }
}
