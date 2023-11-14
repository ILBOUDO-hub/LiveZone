
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/organisateur.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/event/event_details_screen.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class EventController extends GetxController {
static EventController instance = Get.find();
RxList events = [].obs;
RxBool isLoading = false.obs;
RxString codeOrange ="".obs;
RxString codeMoov ="".obs;
RxString termsandConditiom ="".obs;
RxBool updatefroce = true.obs;
RxList categories = [].obs;
RxBool isLoaded = false.obs;
  RxList<Categories> categoriesList = <Categories>[].obs;
//RxList<Organisateur> organisateurs = <Organisateur>[].obs;
CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection("events");
DatabaseReference ref = FirebaseDatabase.instance.ref("ticket");
CollectionReference<Map<String, dynamic>> dborganisateurs = FirebaseFirestore.instance.collection("organisateurs");
//  handleDynamicLink()async {
// var data = await FirebaseDynamicLinks.instance.getInitialLink();
// var deepLink = data;
// if (deepLink != null) {
//   // kill state dynamic link handling here
//   //navigate here
//   print(data);
// }
//  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
//   try {
//       debugPrint(dynamicLinkData.link.query.replaceAll('+', ' ').toUpperCase().replaceAll(" ", '').trim());
//   Event e = EventController.instance.events.value.where((element) {
//             element as Event;
           
//             return element.name.trim().toUpperCase().replaceAll(" ", "") == dynamicLinkData.link.query.replaceAll('+', ' ').toUpperCase().replaceAll(" ", '').trim();
//           }).first;

//            Get.to(()=>EventDetailsScreen(event: e),);
//   } catch (e) {
//     debugPrint(e.toString());
//   }

//     }).onError((error) {
//       print('onLink error');
//       print(error.message);
//     });
// }

EventController();
  @override
  void onReady() async{
    super.onReady();
    initUniLinks();

  }


  Future<void> initUniLinks() async {
    // ... check initialUri

    // Attach a listener to the stream
     uriLinkStream.listen((Uri? uri) {
      print(uri!.host);
      print(uri.queryParameters);
      if(uri.queryParameters['ref']!=null){
        print("yess");
        MyAuthController.instance.referClient(uri.queryParameters['ref']!);
      }
      if(uri.queryParameters['event']!=null){

      }
      // Use the uri and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }
  Future geteventList() async {
    final DateTime dateTime = DateTime.now();
    var tmp = [];
    isLoading.value = true ;
   QuerySnapshot<Map<String, dynamic>> eventstream = await db.where("isActive",isEqualTo: true)
   .where('endDate',isGreaterThanOrEqualTo: dateTime)
   
   .orderBy('endDate',descending: false)
   .get(
    const GetOptions(source: Source.serverAndCache,serverTimestampBehavior: ServerTimestampBehavior.previous)
    );
   
  //  eventstream.docs
  //  listen((_events) async{
    try{
    tmp= [];
    for (var document in eventstream.docs) {
      var tmp_type =<TypeTicket> [];
      var e = Event.fromJson(document.data());
      e.id = document.reference;
      print(document.data());
      var typetickets = await document.reference.collection("typeTicket").get();
      if(typetickets.docs.length == 0){
        continue;
      }else{
        for (var element in typetickets.docs) {
          // debugPrint(element.data().toString());
        var type = TypeTicket.fromJson(element.data());
        type.id = element.reference;
        tmp_type.add(type);
      }
      e.typeTicket = tmp_type;
      e.id = document.reference;
      tmp.add(e);
      }

    }
    events.clear();
    events.value =tmp;
    print(events);
    isLoaded.value = true;
    events.refresh();
    isLoading.value = false;

  }catch(e){
    print(e);
    isLoading.value = false;

    EasyLoading.showError(e.toString(),duration: Duration(seconds: 30));
  }
    isLoading.value = false;

  // }
  // );
  //  handleDynamicLink();
  }

getCategories(){
  Stream<DocumentSnapshot<Map<String, dynamic>>> eventStream =  FirebaseFirestore.instance.collection("settings").doc("eventSettings").snapshots();
  eventStream.listen((event) {
      categories.value = event.data()!['categories'];
      codeMoov.value = event.data()!['codeMoov'];
      codeOrange.value = event.data()!['codeOrange'];
      termsandConditiom.value = event.data()!['conditions'];
      updatefroce.value = event.data()!['update'] != null ? event.data()!['update']:true;
      categoriesList.clear();
        for (var e in categories.value) {
          categoriesList.add(Categories(e, false));
          categoriesList.refresh();
        }
  });
}

getOrganisateurs()async{
   QuerySnapshot<Map<String, dynamic>> organisateurStream = await dborganisateurs.get();
  List<Organisateur> org = <Organisateur>[];
  // organisateurStream.listen((event) {
   org = [];

    for (var element in organisateurStream.docs) {
      Organisateur o = Organisateur.fromJson(element.data());
      o.id = element.reference;
      org.add(o);
    }
    //organisateurs.value.assignAll(org);
    //print(organisateurs);
    //organisateurs.refresh();
  // });
}
deleteOrganisateur(DocumentReference id){
  id.delete();
}
}