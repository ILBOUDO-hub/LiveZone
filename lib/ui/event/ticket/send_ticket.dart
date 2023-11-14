import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/models/ticket.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/ticket_controller.dart';
import '../../../values/values.dart';
import '../../home/home_screen.dart';

class SendTicket extends StatelessWidget {
  Rx<Ticket> ticket;
  RxString research="".obs;
  List<Contact> contacts;
   SendTicket({Key? key,required this.ticket,required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     ScreenProtector.preventScreenshotOff();
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.white,
      leading: BackButton(color: Colors.black),
      title: Text("Selectionner le destinataire pour transferer votre Ticket",style: smallMediumTextStyle,),),
                            body: SingleChildScrollView (
                              child:Column(
                                children: [
                                   Card(
                                     color: Colors.white,
                                     elevation: 2,
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(15.0),
                                     ),
                                     child: Container(
                                       width: Get.width,
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
                                        controller: TextEditingController(),
                                               style: mediumTextStyle,
                                               cursorColor: primaryColor,
                                               onChanged: ((value) {
                                                 research.value=value;
                                            
                                               }),
                                               decoration: InputDecoration(
                                                   hintText: 'Rechercher un contact',
                                                   enabled: true,
                                                   border: InputBorder.none,
                                                   hintStyle: mediumTextStyle))
                                           .wrapPadding(
                                               padding: const EdgeInsets.only(
                                                   left: spacingContainer,
                                                   right: spacingContainer)),
                                     ),
                                   ),
                                   Obx( () =>SizedBox(
                                    width: Get.width,
                                    height: Get.height,
                                     child: ListView.builder(
                                      itemCount: contacts.
                                  where((element) {
                                      if(element.phones.isNotEmpty){
                                        return true;
                                      }else{
                                        return false;
                                      }
                                  }).
                                  where((element) {
                                      if(research.value==""){
                                        return true;
                                      }else{
                                        return element.displayName.toLowerCase().contains(research.toLowerCase())||element.phones.any((element) => element.number .contains(research.value));
                                      }
                                  }).length,
                                      itemBuilder: (context, index) {
                                      var e = contacts.
                                  where((element) {
                                      if(element.phones.isNotEmpty){
                                        return true;
                                      }else{
                                        return false;
                                      }
                                  }).
                                  where((element) {
                                      if(research.value==""){
                                        return true;
                                      }else{
                                        return element.displayName.toLowerCase().contains(research.toLowerCase())||element.phones.any((element) => element.number.contains(research.value));
                                      }
                                  }).elementAt(index);
                                       return ListTile(
                                      leading: CircleAvatar(backgroundColor: primaryColor,
                                      
                                      child: Text("${e.displayName.characters.first}",style: mediumLargeTextStyle.copyWith(fontSize: 20),),
                                      ),
                                      title: Text(e.displayName,style: mediumLargeTextStyle,),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(e.phones.first.number,style: mediumLargeTextStyle,),
                                          research.value ==""?SizedBox():SizedBox()
                                        ],
                                      ),
                                      onTap: (){
                                        String number = e.phones.first.number;
                                        number =number.trim();
                                        number = number.replaceAll(" ", "");
                                        if(number.length==8){
                                          //case number without +226 . add +226 to number
                                          number = "+226$number";
                                        }
                                        if(number.startsWith("00")){
                                          number= number.replaceFirst("00", "+");
                                        }
                                        
                                        print(number);
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
                                'Transfert de Ticket',
                                style: boldLargeTextStyle.copyWith(
                                      fontSize: textSizeNormal),
                              ),
                              // To display the title it is optional
                              content: Text(
                                  "Souhaitez vous proceder au transfere de votre ticket à  ${e.displayName}? ",
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
                                                      BorderRadius.circular(0.0))),
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
                                                      BorderRadius.circular(0.0))),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                           
                                        InternetConnectionChecker().hasConnection.then((value) async{
                          
                                        if(value){
                                          EasyLoading.show(indicator: LoadingAnimationWidget.twistingDots(
                              leftDotColor: Color.fromARGB(255, 255, 255, 255),
                              rightDotColor: primaryColor,
                              size: 25,
                            ), dismissOnTap: false);
                                        QuerySnapshot<Map<String, dynamic>> rs = await MyAuthController.instance.db.where("phoneNumber",isEqualTo: number).get();
                                        if (rs.docs.isNotEmpty) {
                                          try {
                                           
                                             await rs.docs.first.reference.collection("tickets")
                                        .doc(ticket.value.code).set(ticket.value.toJson());
                                        ticket.value.id!.delete();
                                         await ticket.value.typeTicket.id!.update({
                                              'participants': FieldValue.arrayUnion([number])
                                          });
                                        TicketController.instance.getTicket();
                                        Get.to(()=>HomeScreen());
                                          EasyLoading.showSuccess("Ticket transféré avec succès");
                                          } catch (e) {
                                            print(e);
                                            EasyLoading.showError("Erreur lors du tranfert de Ticket !");
                                        await TicketController.instance.getTicket();

                                          }
                                         
                                        } else {
                                          EasyLoading.showError("Votre destinataire n'est pas inscrit sur EasyPass avec ce numero $number ! veuillez Sélectionner un autre destinataire ou inviter ce dérnier a installer Easypass",duration: Duration(seconds: 15));
                                          Get.back();
                                        }
                                        }else{
                                          EasyLoading.showInfo("Verifier votre connection internet !");
                                        }
                                        });
                                        
                                      },
                                      child: Text('Oui', style: boldTextStyle),
                                  ),
                                ),
                              ],
                            );
                                                    });
                                             
                                      },
                                      trailing: Icon(Icons.send),
                                  );
                                  
                                     })
                                     ),
                                   ),
                                  
                                ],
                              ),
                            
                            ),
                          );
  }
}