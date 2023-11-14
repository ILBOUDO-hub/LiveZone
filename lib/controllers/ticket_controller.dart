import 'dart:async';
import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart' as calendar;
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/models/event.dart' as event;
import 'package:eventpro/models/ticket.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/models/user.dart';
import 'package:eventpro/values/values.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:nfc_manager/nfc_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TicketController extends GetxController {
  static TicketController instance = Get.find();
  DatabaseReference? ref;
  RxList<Ticket> mesTickets = <Ticket>[].obs;
  RxBool Valid = true.obs;
  RxMap accessCode = {}.obs;
  Timer? _timer;
  late double _progress;
  RxBool nfcAvailable = false.obs;
  TicketController();
  @override
  void onReady() async {
    if (!kIsWeb) {
      FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    ref = FirebaseDatabase.instance.ref("ticket");
    super.onReady();
    if (!kIsWeb) {
      InternetConnectionChecker().onStatusChange.listen((event) {
        debugPrint(event.toString());
        if (event == InternetConnectionStatus.connected) {
          print("connected");
          FirebaseDatabase.instance.goOnline();
        } else {
          print("disconnected");

          FirebaseDatabase.instance.goOffline();
        }
      });
    }
    // EasyLoading.addStatusCallback((status) {
    //   print('EasyLoading Status $status');
    //   if (status == EasyLoadingStatus.dismiss) {
    //     _timer?.cancel();
    //   }
    // });
    // EasyLoading.showSuccess('');
    //  nfcAvailable.value  = await NfcManager.instance.isAvailable();
  }

  Future<Ticket> createTicket(DocumentReference eventId, TypeTicket type,
      String cover, event.Event event, BuildContext context) async {
    //creation of ticket
    Ticket ticket = Ticket(
        code:
            "${eventId.id}${Random().nextInt(4294967200)}@${MyAuthController.auth.currentUser!.uid}",
        isActive: true,
        isValid: true,
        typeTicket: type,
        cover: cover,
        event: event);
    try {

      type.id!.update({
        "vente": FieldValue.increment(1),
        "quantity": FieldValue.increment(-1),
        "participants": FieldValue.arrayUnion(
            [MyAuthController.auth.currentUser!.phoneNumber])
      });
      await MyAuthController.instance.db
          .doc(MyAuthController.auth.currentUser!.uid)
          .collection("tickets")
          .doc(ticket.code)
          .set(ticket.toJson());
//   MyAuthController.instance.account.refresh();
      await ref!.child(ticket.code).set({"active": true});
    } catch (e) {
      EasyLoading.showError("Un probleme est survenu !!");
      debugPrint("Erreur creation ticket $e");
    }

    try {
      if (MyAuthController.instance.account.value.code != null) {
        var dt = await FirebaseFirestore.instance
            .collection("ambassadeurs")
            .where("code",
                isEqualTo: MyAuthController.instance.account.value.code)
            .get();
        if (dt.docs.isNotEmpty) {
          dt.docs.first.reference.update({
            "vente": FieldValue.increment(1),
            "solde": FieldValue.increment(type.prix * 0.025),
            "Solde ${event.name}": FieldValue.increment(type.prix * 0.025)
          });
        }
      }
    } catch (e) {}

    return ticket;
  }

  Future<Ticket> createFreeTicket(DocumentReference eventId, TypeTicket type,
      String cover, event.Event event, BuildContext context) async {
    //creation of ticket
    Ticket ticket = Ticket(
        code:
            "${eventId.id}${Random().nextInt(4294967200)}@${MyAuthController.auth.currentUser!.uid}",
        isActive: true,
        isValid: true,
        typeTicket: type,
        cover: cover,
        event: event);
    try {
      EasyLoading.show(
          indicator: LoadingAnimationWidget.twistingDots(
            leftDotColor: Color.fromARGB(255, 255, 255, 255),
            rightDotColor: primaryColor,
            size: 25,
          ),
          dismissOnTap: false);
      eventId.update({
        "participants": FieldValue.arrayUnion(
            [MyAuthController.auth.currentUser!.phoneNumber])
      });
      await MyAuthController.instance.db
          .doc(MyAuthController.auth.currentUser!.uid)
          .collection("tickets")
          .doc(ticket.code)
          .set(ticket.toJson());
//   MyAuthController.instance.account.refresh();
      await ref!.child(ticket.code).set({"active": true});
      getTicket();
      EasyLoading.showSuccess("Success De l'achat du billet");
    } catch (e) {
      EasyLoading.showError("Un probleme est survenu !!");
      debugPrint("Erreur creation ticket $e");
    }

    try {
      if (MyAuthController.instance.account.value.code != null) {
        var dt = await FirebaseFirestore.instance
            .collection("ambassadeurs")
            .where("code",
                isEqualTo: MyAuthController.instance.account.value.code)
            .get();
        if (dt.docs.isNotEmpty) {
          dt.docs.first.reference.update({
            "vente": FieldValue.increment(1),
            "solde": FieldValue.increment(type.prix * 0.025)
          });
        }
      }
    } catch (e) {}

    return ticket;
  }

  getTicket() async {
    // mesTickets.value =client.tickets;
    QuerySnapshot<Map<String, dynamic>> mesticket = await MyAuthController
        .instance.db
        .doc(MyAuthController.auth.currentUser!.uid)
        .collection('tickets')
        .get();
    //  mesticket.listen((event) async {
    var tick = <Ticket>[];
    for (var element in mesticket.docs) {
      var instance = Ticket.fromJson(element.data());
      instance.id = element.reference;
      tick.add(instance);
    }
    mesTickets.clear();
    mesTickets.assignAll(tick);
    debugPrint("Liste des ticket  tmp $tick");
    debugPrint("Liste des ticket $mesTickets");
    ref = FirebaseDatabase.instance.ref("ticket");
    for (var element in mesTickets) {
      var data = await ref!.child(element.code).get();
      debugPrint("contenu a ladreess ${data.value}");
      accessCode[element.code] =
          data.value != null ? (data.value as Map)['active'] : false;
      ref!.child(element.code).onChildChanged.listen((event) {
        debugPrint("contenu a ladreess ${event.snapshot.value}");
        accessCode[element.code] = (event.snapshot.value as bool);
        accessCode.refresh();
      });
    }
    debugPrint("code d'access $accessCode");

    //  });
    debugPrint("code d'access $accessCode");

    accessCode.refresh();
    mesTickets.refresh();
    // EasyLoading.dismiss();
  }
}
