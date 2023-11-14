// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/event_controller.dart';
import 'package:eventpro/controllers/story_controller.dart';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/models/user.dart';
import 'package:eventpro/ui/event/ticket/type_ticket_screen.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/ui/login/profile_screen.dart';
import 'package:eventpro/ui/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:get_storage/get_storage.dart';

import '../models/event.dart';

class MyAuthController extends GetxController {
  static MyAuthController instance = Get.find();
  static FirebaseAuth auth = FirebaseAuth.instance;
  // User user;
  Rx<Client> account = Client(name: 'UserName', phoneNumber: '70000000').obs;
  Rx<User?> firebaseUser = null.obs;
  String fcm = "";
  RxBool connected = false.obs;
  // late Rx<GoogleSignInAccount?> googleSignInAccount;
  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection('users');
  RxString verificationId = "".obs;
  RxBool code = false.obs;
  RxString referal_code = "".obs;
  RxString phone = "".obs;
  RxString selected_event_before_auth = "".obs;
  @override
  void onReady() async {
    super.onReady();
    initializeDateFormatting('fr_FR');
    Intl.defaultLocale = 'fr_FR';
    // firebaseFirestore.settings =Settings(persistenceEnabled: true);

    firebaseUser = Rx<User?>(auth.currentUser);
    // _setInitialScreen(firebaseUser.value);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  referClient(String uuid) async {
    EasyLoading.show();
    var user_that_refer = await db.doc(uuid).get();
    EasyLoading.dismiss();
    if (user_that_refer.exists) {
      if (auth.currentUser == null) {
        MyAuthController.instance.referal_code.value = uuid;
        MyAuthController.instance.referal_code.refresh();
        print(MyAuthController.instance.referal_code.value);
        //case the user is not connected
        Get.to(LoginScreen());
      } else {
        //case the user is connected
        var u = await db.doc(auth.currentUser!.uid).get();
        if (u.data()!['code'] != null) {
          //case the user is already referred
        } else {
          //case the user is not reffered
          await u.reference.update({"code": uuid});
          await user_that_refer.reference.update({
            "client": FieldValue.arrayUnion([auth.currentUser!.phoneNumber]),
            "points": FieldValue.increment(1)
          });
        }
      }
    } else {}
  }

  getAccountinfo() {
    Stream<DocumentSnapshot<Map<String, dynamic>>> accountStream =
        db.doc(auth.currentUser!.uid).snapshots();
    accountStream.listen((event) async {
      account.value = Client.fromJson((event.data())!);
      String? mac = event.data()!['macAdress'];
      String? current_mac = await PlatformDeviceId.getDeviceId;
      if (mac != null) {
        if (mac != current_mac) {
          auth.signOut();
        }
      }
    });
    TicketController.instance.getTicket();
  }

  _setInitialScreen(User? user) async {
    GetStorage box = GetStorage();
    if (user == null) {
      EventController.instance.getCategories();
      await EventController.instance.geteventList();
      // await TicketController.instance.getTicket();
      await StoryController.instance.GetStories();
      if (box.read('already_open') == true) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => SplashScreen());
      }
    } else {
      createUSerAccount(user.uid);
      EventController.instance.getCategories();
      // EventController.instance.getOrganisateurs();
      EventController.instance.geteventList();
      TicketController.instance.getTicket();
      StoryController.instance.GetStories();

      // if the user exists and logged in the the user is navigated to the Home Screen
      if (auth.currentUser!.displayName == null) {
        Get.offAll(() => CreateProfile());
      } else if (MyAuthController.instance.selected_event_before_auth.value !=
          "") {
        Event eve = EventController.instance.events.firstWhere((element) {
          element as Event;
          return element.name ==
              MyAuthController.instance.selected_event_before_auth.value;
        });
        Get.offAll(TypeTicketScreen(e: eve));
      } else {
        Get.offAll(() => HomeScreen());
      }
    }
  }

  void createUSerAccount(String uid) async {
    String? mac_adress = "";
    try {
      // await FirebaseMessaging.instance.getAPNSToken();
      fcm = (await FirebaseMessaging.instance.getToken())!;
      debugPrint("Token $fcm");
    } catch (e) {
      print(e);
    }
    try {
      // await FirebaseMessaging.instance.getAPNSToken();
      mac_adress = await PlatformDeviceId.getDeviceId;
      debugPrint("Token $mac_adress");
    } catch (e) {}
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await db.doc(uid).get();
      if (value.exists == false) {
        Client newuser = Client(
            macadress: mac_adress,
            name: '',
            phoneNumber: auth.currentUser!.phoneNumber!);
        var data = newuser.toJson();
        data['macAdress'] = mac_adress;
        data['fcm'] = [fcm];
        await db.doc(uid).set(data);
        // await db.doc(uid).collection('tickets').
        account.value = newuser;
      } else {
        String? cloud_adress = value.data()!['macAdress'];
        if (cloud_adress == null) {
          await db.doc(uid).update({
            'fcm': FieldValue.arrayUnion([fcm]),
            'macAdress': mac_adress
          });
        } else if (cloud_adress == mac_adress) {
          await db.doc(uid).update({
            'fcm': FieldValue.arrayUnion([fcm]),
          });
        } else if (cloud_adress != mac_adress) {
          //case of different phone
          // Get.defaultDialog(title: "Connection sur un nouvelle appareil",
          // content: Text("Vous tentez de vous connecter a partir un appereil different de celui utilise precedemment ! Veuillez vous deconnecter de l'ancien appareil avant de vous connecte"))
          // Get.defaultDialog(title: "ALert Compte", content: Text("Votre compte est deja connecter a un appareil !Deconnecter le pour utiliser un nouvelle appareil"));
          db.doc(uid).update({
            'fcm': FieldValue.arrayUnion([fcm]),
            'macAdress': mac_adress
          });
        }
        account.value = Client.fromJson(value.data() as Map<String, dynamic>);
        // EasyLoading.dismiss();
      }
      getAccountinfo();
    } catch (e) {
      debugPrint("account creation error");
      debugPrint(e.toString());
    }
    // });
  }

  updateUserInfo(Client data) async {
    try {
      await db.doc(auth.currentUser!.uid).update(data.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
