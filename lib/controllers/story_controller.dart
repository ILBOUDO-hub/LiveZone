
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/organisateur.dart';
import 'package:eventpro/models/story.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryController extends GetxController {
static StoryController instance = Get.find();
var stories= <Story>[].obs;
CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection("events");
DatabaseReference ref = FirebaseDatabase.instance.ref("ticket");
CollectionReference<Map<String, dynamic>> dborganisateurs = FirebaseFirestore.instance.collection("organisateurs");
SharedPreferences?  prefs ;
StoryController();
@override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
     try{
        prefs =  await SharedPreferences.getInstance();
    }catch(e){
    }
  }

  @override
  void onReady() async{
    super.onReady();
   


  }

GetStories(){
   Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection("stories").where('date', isGreaterThan: DateTime.now()).snapshots();
  List<Story> org = <Story>[];
  stream.listen((event) {
   org = [];

    for (var element in event.docs) {
      try {
      Story o = Story.fromJson(element.data());
      o.id = element.reference;
      org.add(o);
      } catch (e) {
      }
    }
    stories.value.assignAll(org);
    print(stories);
    stories.refresh();
  });
}

}