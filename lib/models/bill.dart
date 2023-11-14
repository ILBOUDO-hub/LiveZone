import 'package:eventpro/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/firebase_messaging.dart';
import 'package:eventpro/models/ticket.dart';
import 'package:eventpro/values/values.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntp/ntp.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

import '../ui/event/ticket/send_ticket.dart';

class TicketView extends StatelessWidget {
  Rx<Ticket> ticket;
  RxBool isActive = true.obs;
  RxBool connected = true.obs;
  RxString research = "".obs;
  Rx<DateTime> now_date = DateTime.now().obs;

  TicketView({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ever(TicketController.instance.mesTickets, ((callback) {}));
    ScreenProtector.preventScreenshotOn();
    Widget svgCode = RandomAvatar(
        "${MyAuthController.auth.currentUser!.phoneNumber}",
        height: Get.width * 0.15,
        width: Get.width * 0.15,
        trBackground: true);
    if (!kIsWeb) {
      InternetConnectionChecker()
          .hasConnection
          .then((value) => connected.value = value);
      // SimpleConnectionChecker.isConnectedToInternet().then((value) => connected.value =value );
      InternetConnectionChecker().onStatusChange.listen((event) {
        debugPrint(event.toString());
        connected.value =
            event == InternetConnectionStatus.connected ? true : false;
      });
      if (connected == true) {
        NTP
            .now(timeout: Duration(seconds: 5))
            .then((value) => {
                  print(value),
                  now_date.value = value,
                })
            .onError((error, stackTrace) => {
                  print("error"),
                  print(error),
                  now_date.value = DateTime.now()
                });
      }
    }
//        NfcManager.instance.isAvailable().then((value) {
//         print(value);
//        });
//       if(TicketController.instance.nfcAvailable.value){

//         NfcManager.instance.  startSession(
//   onDiscovered: (NfcTag tag) async {
//     // Do something with an NfcTag instance.
//     print(tag.data['ndef']);
//     ticket.value.isActive = !ticket.value.isActive ;
//     ticket.refresh();
//     await FirebaseDatabase.instance.ref(ticket.value.code).set(ticket.value.isActive);
//   },
//   alertMessage: "detection de ticket"
// );
//       }
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SizedBox(
          width: (Get.width > 475 ? 475 : Get.width),
          height: Get.height,
          child: Stack(
            children: [
              FancyShimmerImage(
                imageUrl: ticket.value.cover,
                height: Get.height,
                width: Get.width,
                boxFit: BoxFit.cover,
              ),
              FancyShimmerImage(
                imageUrl: ticket.value.cover,
                height: Get.height,
                width: (Get.width > 475 ? 475 : Get.width),
                boxFit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: (Get.width > 475 ? 475 : Get.width) * 0.05,
                    vertical: 25),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (Get.width > 475 ? 475 : Get.width),
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryColor,
                              child: BackButton(
                                color: Colors.white,
                                onPressed: (() {
                                  ScreenProtector.preventScreenshotOff();
                                  Get.back();
                                }),
                              ),
                            ),
                            SizedBox(
                                width:
                                    (Get.width > 475 ? 475 : Get.width) * 0.6,
                                child: Text(
                                  ticket.value.event.name,
                                  style: mediumLargeTextStyle.copyWith(
                                      overflow: TextOverflow.clip),
                                  textAlign: TextAlign.center,
                                )),
                            const Icon(Icons.qr_code),
                          ],
                        ),
                      ),
                      Obx(() => Container(
                            width: (Get.width > 475 ? 475 : Get.width),
                            height: Get.height * 0.65,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.height * 0.4,
                                  height: Get.height * 0.4,
                                  decoration: BoxDecoration(
                                      color: TicketController
                                                  .instance
                                                  .accessCode
                                                  .value[ticket.value.code] !=
                                              null
                                          ? TicketController.instance.accessCode
                                                  .value[ticket.value.code]
                                              ? Colors.white
                                              : Colors.red
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: ticket.value.typeTicket.dateFinValidite
                                          .isAfter(now_date.value)
                                      ? ticket.value.typeTicket
                                              .dateDebutValidite
                                              .isBefore(now_date.value)
                                          ? Center(
                                              child: TicketController.instance
                                                              .accessCode.value[
                                                          ticket.value.code] !=
                                                      null
                                                  ? QrImageView(
                                                      foregroundColor:
                                                          Colors.black,
                                                      data: ticket.value.code,
                                                      size: (Get.width > 475
                                                              ? 475
                                                              : Get.width) *
                                                          0.5,
                                                      backgroundColor:
                                                          Colors.white,
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        QrImageView(
                                                          foregroundColor:
                                                              ticket.value
                                                                      .isActive
                                                                  ? Colors.black
                                                                  : Colors.red,
                                                          data:
                                                              ticket.value.code,
                                                          size: (Get.width > 475
                                                                  ? 475
                                                                  : Get.width) *
                                                              0.5,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                        Chip(
                                                          label: Text(
                                                            "Hors Ligne",
                                                            style: mediumLargeTextStylewhite
                                                                .copyWith(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          backgroundColor:
                                                              Colors.white,
                                                        )
                                                      ],
                                                    ),
                                            )
                                          :
                                          //cas ou on affiche avnt le jour de validite du ticket
                                          SizedBox(
                                              width: (Get.width > 475
                                                      ? 475
                                                      : Get.width) *
                                                  0.4,
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: QrImageView(
                                                      foregroundColor:
                                                          ticket.value.isActive
                                                              ? Colors.black
                                                              : Colors.red,
                                                      data: ticket.value.code,
                                                      size: (Get.width > 475
                                                              ? 475
                                                              : Get.width) *
                                                          0.5,
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                  Center(
                                                      child: CircleAvatar(
                                                          radius: (Get.width >
                                                                      475
                                                                  ? 475
                                                                  : Get.width) *
                                                              0.1,
                                                          backgroundColor:
                                                              primaryColor,
                                                          child: Icon(
                                                            Icons.lock_clock,
                                                            color: Colors.white,
                                                            size: (Get.width >
                                                                        475
                                                                    ? 475
                                                                    : Get
                                                                        .width) *
                                                                0.1,
                                                          ))),
                                                  // Center(child: Text("Se ticket sera visible a partir du ${DateFormat("EEEE,d LLLL yyyy 'a' H'h':mm ").format(ticket.value.typeTicket.dateDebutValidite) }" , style: mediumLargeTextStyle,textAlign: TextAlign.center, ))
                                                ],
                                              ),
                                            )
                                      : Icon(
                                          Icons.dangerous_rounded,
                                          color: Colors.red,
                                          size: (Get.width > 475
                                                  ? 475
                                                  : Get.width) *
                                              0.6,
                                        ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        width: (Get.width > 475 ? 475 : Get.width),
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: svgCode,
                            ),
                            Text(
                              ticket.value.typeTicket.name,
                              style: boldLargeTextStyle.copyWith(
                                color: primaryColor,
                              ),
                            ),
                            
                          ],
                        ),
                      )
                    ,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !kIsWeb? CupertinoButton(child: Text("Transferer le ticket",style: boldLargeTextStyle.copyWith(color: Colors.white),), onPressed: (() async {
                                        // print(contacts);
                                        if (now_date.value.isBefore(ticket.value
                                            .typeTicket.dateDebutValidite)) {
                                          if (await perm.Permission.contacts
                                                  .request()
                                                  .isGranted ||
                                              !kIsWeb) {
                      //   // Either the permission was already granted before or the user just granted i
                      // t.
                                            EasyLoading.show(
                                                indicator: LoadingAnimationWidget
                                                    .twistingDots(
                                                  leftDotColor:
                                                      const Color.fromARGB(
                                                          255, 0, 0, 0),
                                                  rightDotColor: primaryColor,
                                                  size: 25,
                                                ),
                                                dismissOnTap: false);
                                            final contacts = await FastContacts
                                                .getAllContacts();
                                            EasyLoading.dismiss();
                                            Get.to(SendTicket(
                                              ticket: ticket,
                                              contacts: contacts,
                                            ));
                                          } else {
                                            if (GetPlatform.isAndroid) {
                                              await perm.Permission.contacts
                                                  .request();
                                            }
                                            Get.showSnackbar(const GetSnackBar(
                                              message:
                                                  "Veuillez autoriser le lecture de vos contacts avant !!",
                                              duration: Duration(seconds: 10),
                                            ));
                                          }
                                        } else {
                                          EasyLoading.showInfo(
                                              "Il n'est plus possible d'envoyer ce ticket ! les transfert de ticket se font avant le debut des manifestations .",
                                              duration:
                                                  const Duration(seconds: 10));
                                        }
                                      }),color: primaryColor,):SizedBox(),
    );
  }
}
