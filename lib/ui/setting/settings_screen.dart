import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/models/user.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/ui/intro/intro_screen.dart';
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/ui/login/term_condition.dart';
import 'package:eventpro/ui/setting/about_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/values.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // var colors_of_pass = [ Colors.]
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget svgCode = MyAuthController.instance.firebaseUser.value == null
        ? RandomAvatar("defaultuser",
            height: Get.width * 0.15,
            width: Get.width * 0.15,
            trBackground: true)
        : RandomAvatar(
            "${MyAuthController.instance.firebaseUser.value!.phoneNumber!}",
            height: Get.width * 0.15,
            width: Get.width * 0.15,
            trBackground: true);
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: null,
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: Get.width,
                    
                    child: Column(
                      children: [
                        CupertinoButton(
                          onPressed: (){
                        },
                          // onPressed: () async {
                          //   showModalBottomSheet(
                          //       context: context,
                          //       builder: (context) {
                          //         return MediaPicker(
                          //           mediaList: const [],
                          //           onPicked: (selectedList) async {
                          //             var selectedprofile = selectedList.first;
                  
                          //             if (selectedprofile == null) {
                          //               EasyLoading.showError(
                          //                   "Veuillez choisir une photo avant de continuer");
                          //             } else {
                          //               try {
                          //                 EasyLoading.show(dismissOnTap: false);
                          //                 if (MyAuthController.instance
                          //                         .firebaseUser.value!.photoURL !=
                          //                     null) {
                          //                   try {
                          //                     FirebaseStorage.instance
                          //                         .refFromURL(MyAuthController
                          //                             .instance
                          //                             .firebaseUser
                          //                             .value!
                          //                             .photoURL!)
                          //                         .delete();
                          //                   } catch (e) {}
                          //                 }
                          //                 var ref = FirebaseStorage.instance.ref(
                          //                     "profils/${selectedprofile.title}");
                          //                 ref.putFile(selectedprofile.file!);
                          //                 var link = await ref.getDownloadURL();
                          //                 await MyAuthController
                          //                     .instance.firebaseUser.value!
                          //                     .updatePhotoURL(link);
                          //                 EasyLoading.showSuccess(
                          //                     "Votre profil a été changé avec succès");
                          //               } catch (e) {
                          //                 print("erreur $e");
                          //                 EasyLoading.showError(
                          //                     "Erreur lors du changement de la photo de profile! verifier votre connection puis reeasyer !");
                          //               }
                          //             }
                          //             Get.back();
                          //           },
                          //           onCancel: () => Navigator.pop(context),
                          //           mediaCount: MediaCount.single,
                          //           mediaType: MediaType.image,
                          //           decoration: PickerDecoration(
                          //             actionBarPosition: ActionBarPosition.top,
                          //             blurStrength: 2,
                          //             completeText: 'Suivant',
                          //           ),
                          //         );
                          //       });
                          // },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Container(
                              height: Get.width * 0.3,
                              width: Get.width * 0.3,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: AvatarGlow(
                                glowColor: primaryColor,
                                endRadius: Get.width * 0.25,
                                duration: const Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    const Duration(milliseconds: 100),
                                child: Material(
                                  // Replace this child with your own
                                  elevation: 8.0,
                                  shape: const CircleBorder(),
                                  child: CircleAvatar(
                                          // backgroundImage: randomAvatarString('saytoonz')
                                          child: svgCode,
                                          // NetworkImage(MyAuthController.instance.firebaseUser.value!.photoURL!),
                                          backgroundColor: Colors.grey[100],
                  
                                          radius: Get.width * 0.125,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(color: Colors.blue),
                          child: Text(MyAuthController.instance.account.value.status == UserType.simple?"Classic Pass": "${MyAuthController.instance.account.value.status} Pass" ,style: mediumLargeTextStylewhite,),
                        ),
                        MyAuthController
                                    .instance.firebaseUser.value!.displayName !=
                                null
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      
                                      Text(
                                        "${MyAuthController.instance.firebaseUser.value!.displayName}",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: mediumLargeTextStyle,
                                      ),
                                      Text(
                                        "${MyAuthController.instance.firebaseUser.value!.phoneNumber}",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: mediumLargeTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        
                              Container(
                          width: Get.width*0.9,
                          height:50,
                          decoration: BoxDecoration(
                            // color: primaryColor,
                            boxShadow: [
                              BoxShadow(color: Color.fromARGB(73, 0, 0, 0),offset: Offset(0, 5,),blurRadius: 10)
                            ],
                            gradient: LinearGradient(colors: [Color(0xFFF00000),Color(0xFFDC281E)],begin: Alignment.topLeft,end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(10),
                           ),
                           child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                           child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[Text("Points de fidelite",style: mediumLargeTextStylewhite,),
                           
                            Obx(
                              
                              ()=> CupertinoButton(child: Row(
                                children: [
                                  CircleAvatar(backgroundColor:Colors.black,child: Text("${MyAuthController.instance.account.value.rewards}",style: mediumLargeTextStyle.copyWith(color: Colors.white),)),
                                  SizedBox(width: 10,),
                                  Icon(Icons.swap_vertical_circle,color: Colors.black,),
                                  Text("Echanger",style: mediumLargeTextStyle,),
                                ],
                              ), onPressed: (){},color: Colors.white,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),),
                            )]
                           ),),
                        )
                     ,
                                ],
                    ),
                  ),
                          Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Anciens Billets",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    color: Color(0xff808080),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    "${TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isBefore(DateTime.now())).length}",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Nouveaux Billets",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    color: Color(0xff808080),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    "${TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isAfter(DateTime.now())).length}",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Participation Total",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    color: Color(0xff808080),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    "${TicketController.instance.mesTickets.length}",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                 
                  const SizedBox(height: itemSpacing),

                  // InkWell(
                  //   splashColor: Colors.transparent,
                  //   highlightColor: Colors.transparent,
                  //   child: _settingItem('Profile'),
                  //   onTap: () => {
                  //     Navigator.of(context)
                  //         .push(SlideRightRoute(page: const ProfileScreen()))
                  //   },
                  // ),
                  const SizedBox(height: itemSpacing),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _settingItem('Termes et conditons'),
                    onTap: () => Get.to(() => TermCondition()),
                  ),
                  // const SizedBox(height: itemSpacing),
                  // InkWell(
                  //   splashColor: Colors.transparent,
                  //   highlightColor: Colors.transparent,
                  //   child: _settingItem('Assistance'),
                  //   onTap: () => {
                  //     Navigator.of(context)
                  //         .push(SlideRightRoute(page: const HelpScreen()))
                  //   },
                  // ),
                  const SizedBox(height: itemSpacing),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _settingItem('A propos de nous'),
                    onTap: () => {
                      Navigator.of(context)
                          .push(SlideRightRoute(page: const AboutScreen()))
                    },
                  ),
                  const SizedBox(height: itemSpacing),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _settingItem('Recommender Easypass'),
                    onTap: () {
                      GetPlatform.isAndroid
                          ? {
                              Share.share(
                                  "https://play.google.com/store/apps/details?id=com.easypass.eventpro")
                            }
                          : {
                              Share.share(
                                  "https://apps.apple.com/us/app/easypass/id1581399869")
                            };  
                    },
                  ),
                  const SizedBox(height: itemSpacing),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _settingItem('Se deconnecter'),
                    onTap: () async => {
                      Get.to(const IntroScreen()),
                      TicketController.instance.mesTickets.clear(),
                      await MyAuthController.instance.db
                          .doc(
                              MyAuthController.instance.firebaseUser.value!.uid)
                          .update({'macAdress': null}),
                      await MyAuthController.auth.signOut(),
                    },
                  ),
                  const SizedBox(height: itemSpacing),

                  InkWell(
                    splashColor: Colors.red,
                    highlightColor: Colors.red,
                    child: _settingItem('Supprimer mon compte'),
                    onTap: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // shape: Border.all(
                              //     color: primaryColor,
                              //     width: borderWidth,
                              //     style: BorderStyle.solid),
                              backgroundColor: Colors.white,
                              title: Text(
                                'Supression de compte',
                                style: boldLargeTextStyle.copyWith(
                                    color: Colors.red,
                                    fontSize: textSizeNormal),
                              ),
                              // To display the title it is optional
                              content: Text(
                                  "En acceptant vous proceder a la suppression de votre compte.Ceci causera la perte de toute vos informations y compris les tickets acheté,Continuez ?",
                                  style: mediumTextStyle),
                              // Message which will be pop up on the screen
                              // Action widget which will provide the user to acknowledge the choice
                              actions: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    // function used to perform after pressing the button
                                    child: Text('Non', style: boldTextStyle),
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: () async {
                                      try {
                                        EasyLoading.show();
                                        var account = await MyAuthController
                                            .instance.db
                                            .where("phoneNumber",
                                                isEqualTo: MyAuthController
                                                    .instance
                                                    .firebaseUser
                                                    .value!
                                                    .phoneNumber)
                                            .get();
                                        var tickets = await account
                                            .docs.first.reference
                                            .collection('tickets')
                                            .get();
                                        if (tickets.docs.isNotEmpty) {
                                          for (var element in tickets.docs) {
                                            await element.reference.delete();
                                          }
                                        }

                                        account.docs.first.reference.delete();
                                        MyAuthController
                                            .instance.firebaseUser.value!
                                            .delete();
                                        Get.to(LoginScreen());
                                        EasyLoading.dismiss();
                                      } catch (e) {
                                        print(e);
                                        EasyLoading.dismiss();
                                        MyAuthController
                                            .instance.firebaseUser.value!
                                            .delete();
                                        Get.to(LoginScreen());
                                      }
                                    },
                                    child: Text('Oui', style: boldTextStyle),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                  )
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }

  _settingItem(String title) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: boldLargeTextStyle),
      const Icon(Icons.arrow_forward_ios_rounded, color: primaryColor, size: 18)
    ]).wrapPadding(
        padding: const EdgeInsets.only(
            left: spacingContainer, right: spacingContainer));
  }
}

/// Téléchargement de fichier à partir de Flutterviz- Faites glisser un outil. Pour plus de détails, visitez https://flutterviz.io/
