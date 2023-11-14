import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/values/values.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../controllers/event_controller.dart';
import '../../models/event.dart';
import '../event/ticket/type_ticket_screen.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String name = "";
  String codeagent = "";

  Media? selectedprofile;
  
  TextEditingController codeController = TextEditingController(text: MyAuthController.instance.referal_code.value);
  configureProfile() async {
    print(codeagent);
    print(name);
    EasyLoading.show(
        indicator: Column(
      children: [
        CircularProgressIndicator(),
        Text(
          "Configuration du profil",
          style: mediumLargeTextStylewhite,
        )
      ],
    ));
    try {
      if (name.isNotEmpty) {
        await MyAuthController.auth.currentUser!.updateDisplayName(name);
      }
      // if (selectedprofile != null) {
      //   var ref = FirebaseStorage.instance
      //       .ref("profils/${selectedprofile!.file.toString()}");
      //   print(ref.toString());
      //   if (GetPlatform.isIOS) {
      //     ref.putFile(File(selectedprofile!.file!.path)).then((p0) async {
      //       var link = await ref.getDownloadURL();
      //       await MyAuthController.auth.currentUser!.updatePhotoURL(link);
      //       MyAuthController.instance.firebaseUser.refresh();
      //     });
      //     ;
      //   } else {
      //     ref.putString(selectedprofile!.file!.path).then((p0) async {
      //       var link = await ref.getDownloadURL();
      //       await MyAuthController.auth.currentUser!.updatePhotoURL(link);
      //       MyAuthController.instance.firebaseUser.refresh();
      //     });
      //   }
      // }

      if (codeagent.isNotEmpty || MyAuthController.instance.referal_code.value!="") {
        if(MyAuthController.instance.referal_code.value!=""){
          var user_that_refer= await  MyAuthController.instance.db.doc(MyAuthController.instance.referal_code.value!).get();
          var u = await MyAuthController.instance.db.doc(MyAuthController.auth.currentUser!.uid).get();
          await u.reference.update({
          "code": MyAuthController.instance.referal_code.value
        });
        await user_that_refer.reference.update({
          "client":FieldValue.arrayUnion([MyAuthController.auth.currentUser!.phoneNumber]),
          "points": FieldValue.increment(1)
        });
        }else{
        var data = await FirebaseFirestore.instance
            .collection("ambassadeurs")
            .where("code", isEqualTo: codeagent.trim())
            .get();
        if (data.docs.isNotEmpty) {
          var phone = [];
          phone.add(MyAuthController.auth.currentUser!.phoneNumber!);
          data.docs.first.reference
              .update({"affiliations": FieldValue.increment(1),
              "client":FieldValue.arrayUnion(phone)});
        } else {
          EasyLoading.showError("Code agent non enrégistré");
        }

        await MyAuthController.instance.db
            .doc(MyAuthController.auth.currentUser!.uid)
            .update({"code": codeagent.toLowerCase()});
        }
      }

      print(MyAuthController.instance.selected_event_before_auth.value);
      if (MyAuthController.instance.selected_event_before_auth.value != "") {
        Event eve = EventController.instance.events.firstWhere((element) {
          element as Event;
          return element.name ==
              MyAuthController.instance.selected_event_before_auth.value;
        });
        Get.to(TypeTicketScreen(e: eve));
      } else {
        Get.to(HomeScreen());
      }
      EasyLoading.dismiss();
    } catch (e) {
      print("*************************erreur $e");
      EasyLoading.dismiss();

      EasyLoading.showError(
          "Erreur lors de la creation du profile ! verifier votre connection puis reeasyer !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Profil EasyPass",
          style: mediumLargeTextStyle,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.offAll(() => HomeScreen());
              },
              child: Text(
                "Passer",
                style: mediumLargeTextStyle.copyWith(color: primaryColor),
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CupertinoButton(
                //   padding: EdgeInsets.zero,
                //   onPressed: () {
                //     openImagePicker(context);
                //   },
                //   child: selectedprofile == null
                //       ? CircleAvatar(
                //           radius: Get.width * 0.15,
                //           backgroundColor: primaryColor,
                //           child: Icon(
                //             Icons.photo_camera,
                //             color: Colors.white,
                //           ),
                //         )
                //       : CircleAvatar(
                //           radius: Get.width * 0.15,
                //           backgroundColor: primaryColor,
                //           backgroundImage: FileImage(selectedprofile!.file!),
                //         ),
                // ),
                // // const SizedBox(
                // //   height: 5,
                // // ),
                // CupertinoButton(
                //     onPressed: () {
                //       openImagePicker(context);
                //     },
                //     child: Text(
                //       "Ajouter une photo de profil (optionel)",
                //       style: smallMediumTextStyle,
                //     )),
                // Divider(
                //   color: Colors.grey,
                // ),
                // SizedBox(
                //   width: Get.width,
                //   height: 50,
                //   child: Row(
                //     children: [
                //       Text("Nom d'utilisateur :"),
                //       TextFormField(
                //       onChanged: ((value) {
                //         name = value;
                //       }),
                //       decoration: InputDecoration(border: InputBorder.none
                //       ,

                //       hintStyle: smallMediumTextStyle,
                //       hintText: "Entrer Votre Nom et prenom"),

                //     ),
                //     ],
                //   ),
                // ),
                ListTile(
                  title: TextField(
                    onChanged: ((value) {
                      name = value;
                    }),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: smallMediumTextStyle,
                        labelText: "Nom d'utilisateur :",
                        labelStyle:
                            smallMediumTextStyle.copyWith(color: primaryColor),
                        hintText: "Entrer Votre Nom et prenom"),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),

                ListTile(
                  title: Obx(
                   (){
                    print(MyAuthController.instance.referal_code.value);
                     return TextField(
                    enabled: MyAuthController.instance.referal_code.value=="" ? true:false,
                    
                      onChanged: ((value) {
                        codeagent = value;
                      }),
                      controller: codeController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle:
                              smallMediumTextStyle.copyWith(color: primaryColor),
                          hintStyle: smallMediumTextStyle,
                          labelText: "Code de parrainage (Non Obligatoire):",
                          hintText:
                              "Entrer code de l'agent qui vous a parrainner ou laisser vide "),
                    );
                   },
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CupertinoButton(
                    color: primaryColor,
                    child: const Text("Suivant"),
                    onPressed: configureProfile),
    );
  }

  void openImagePicker(BuildContext context) {
    // openCamera(onCapture: (image){
    //   setState(()=> mediaList = [image]);
    // });
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MediaPicker(
            mediaList: [],
            onPicked: (selectedList) {
              setState(() {
                selectedprofile = selectedList.first;
              });
              // setState(() => mediaList = selectedList);
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
            mediaCount: MediaCount.single,
            mediaType: MediaType.image,
            decoration: PickerDecoration(
              actionBarPosition: ActionBarPosition.top,
              blurStrength: 2,
              completeText: 'Suivant',
            ),
          );
        });
  }
}
