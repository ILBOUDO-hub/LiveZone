import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/event_controller.dart';
import 'package:eventpro/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PayementScreen extends StatelessWidget {
  TextEditingController codeaccess = TextEditingController();
  TextEditingController phone = TextEditingController(text: "");
  String phonetxt = "";
  int montant;
  String userphone;
  AsyncCallback callback;
  String description;
  PayementScreen(
      {Key? key,
      required this.description,
      required this.montant,
      required this.userphone,
      required this.callback})
      : super(key: key);
  createDialogue(BuildContext context, String code, String banner) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(banner))),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Montant: ",
                        style: mediumLargeTextStyle,
                      ),
                      Text(
                        "$montant XOF",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Composez ou cliquez sur le code ci-dessous ,pour générer votre code de paiement, et valider votre achat :",
                    style: smallMediumTextStyle,
                  ),
                  Center(
                    child: TextButton(
                      child: Text(
                        code,
                        style: mediumLargeTextStyle.copyWith(
                            color: primaryColor,
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: code,
                        );
                        await launchUrl(launchUri,
                            mode: LaunchMode.platformDefault);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Entrez ci dessous le code recu par sms ci dessous",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    controller: codeaccess,
                    decoration: InputDecoration(
                        label: Text(
                          "Code De Payement",
                          style: mediumLargeTextStyle,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide())),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text('NB: Ce code est different de votre code De connexion à L\'application'),
                  Center(
                    child: CupertinoButton(
                      onPressed: () async {
                        // bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
                        if (true) {
                          EasyLoading.show(
                              indicator: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text(
                                "Verification de la transaction",
                                style: mediumLargeTextStylewhite,
                              )
                            ],
                          ));
                          try {
                            QuerySnapshot<
                                Map<String,
                                    dynamic>> datapay = await FirebaseFirestore
                                .instance
                                .collection("Payements")
                                .
                                // where("origine",isEqualTo: "${phone.text}")
                                where('status', isEqualTo: "actif")
                                .where(
                                  "otp",
                                  isEqualTo: int.parse(codeaccess.text),
                                )
                                .where("montant", isEqualTo: "$montant")
                                .get();
                            codeaccess.clear();
                            print(datapay.docs.length);
                            if (datapay.docs.isNotEmpty) {
                              datapay.docs.first.reference
                                  .update({'status': 'inactif'});
                              EasyLoading.showSuccess("Paiement confirmé");

                              await callback();
                            } else {
                              EasyLoading.showError(
                                  "Paiement non valide, verifier vos informations");
                            }
                          } catch (e) {
                            print(e);
                            EasyLoading.showError(
                                "Verifier  votre code et reesayer");
                          }
                        }
                      },
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Confirmer le Paiement",
                        style: mediumLargeTextStylewhite,
                      ),
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show(
                          indicator: LoadingAnimationWidget.twistingDots(
                            leftDotColor: Color.fromARGB(255, 255, 255, 255),
                            rightDotColor: primaryColor,
                            size: 25,
                          ),
                          dismissOnTap: false);
                      var whatsapp = "+22660366506";
                      var whatsappURlAndroid = "whatsapp://send?phone=" +
                          whatsapp +
                          "&text=Salut j'ai rencontré une difficulte pour payer mon ticket";
                      var whatAppURLIOS =
                          "https://wa.me/$whatsapp?text=${Uri.parse("Salut j'ai rencontré une difficulte pour payer mon ticket")}";

                      // for iOS phone only
                      try {
                        await launchUrlString(
                          whatAppURLIOS,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Whatsapp non installé")));
                      }

                      EasyLoading.dismiss();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/whatsapp.png',
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          "Contacter l'assistance",
                          style: smallBoldTextStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String codeOrange = "${EventController.instance.codeOrange}$montant#";
    String codeMoov = "${EventController.instance.codeMoov}$montant#";
    String orangeBanner = "assets/Orange_Money-Logo.wine.png";
    String moovBanner = "assets/moov-money-removebg-preview.png";
    return ScreenTypeLayout.builder(
        desktop: (_) => Scaffold(
              appBar: AppBar(
                leading: BackButton(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Payer votre Ticket",
                  style: mediumLargeTextStyle,
                ),
              ),
              body: SafeArea(
                child: Center(
                    child: Container(
                  height: Get.height,
                  // width: Get.width,
                  constraints: BoxConstraints(maxWidth: 600),
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Container(
                      width: Get.width,
                      height: Get.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Motif de la transaction :",
                            style: mediumLargeTextStyle,
                          ),
                          Divider(color: Color.fromARGB(255, 211, 211, 211)),
                          Text(
                            description,
                            style: mediumLargeTextStyle,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Montant total : $montant Franc CFA",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(color: Color.fromARGB(255, 211, 211, 211)),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Payer avec :",
                            style: mediumLargeTextStyle,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      createDialogue(
                                          context, codeOrange, orangeBanner);
                                    },
                                    child: Card(
                                      child: Container(
                                        width: 475 * 0.4,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(orangeBanner)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      createDialogue(
                                          context, codeMoov, moovBanner);
                                    },
                                    child: Card(
                                      child: Container(
                                        width: 475 * 0.4,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(moovBanner)),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          //                 Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: SizedBox(
                          //     width: Get.width,
                          //     child: SingleChildScrollView(
                          //       scrollDirection: Axis.horizontal,
                          //       child: Row(
                          //         children: [
                          //           Icon(Icons.security),
                          //           Text("Futurix ",style: mediumLargeTextStyle,),
                          //           Text("Pay",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                )),
              ),
              bottomNavigationBar: SizedBox(
                width: Get.width,
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.security),
                    Text("Sécurisé par "),
                    Text(
                      "Futurix ",
                      style: mediumLargeTextStyle,
                    ),
                    Text(
                      "Pay",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
        mobile: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Payer votre Ticket",
                style: mediumLargeTextStyle,
              ),
            ),
            body: SafeArea(
              child: Center(
                  child: Container(
                height: Get.height,
                width: Get.width,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: SingleChildScrollView(
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Motif de la transaction :",
                          style: mediumLargeTextStyle,
                        ),
                        Divider(color: Color.fromARGB(255, 211, 211, 211)),
                        Text(
                          description,
                          style: mediumLargeTextStyle,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Montant total : $montant Franc CFA",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Divider(color: Color.fromARGB(255, 211, 211, 211)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Payer avec :",
                          style: mediumLargeTextStyle,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    createDialogue(
                                        context, codeOrange, orangeBanner);
                                  },
                                  child: Card(
                                    child: Container(
                                      width: Get.width * 0.4,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(orangeBanner)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    createDialogue(
                                        context, codeMoov, moovBanner);
                                  },
                                  child: Card(
                                    child: Container(
                                      width: Get.width * 0.4,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(moovBanner)),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        //                 Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: SizedBox(
                        //     width: Get.width,
                        //     child: SingleChildScrollView(
                        //       scrollDirection: Axis.horizontal,
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.security),
                        //           Text("Futurix ",style: mediumLargeTextStyle,),
                        //           Text("Pay",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              )),
            ),
            bottomNavigationBar: SizedBox(
              width: Get.width > 475 ? 475 : Get.width,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security),
                  Text("Sécurisé par "),
                  Text(
                    "Futurix ",
                    style: mediumLargeTextStyle,
                  ),
                  Text(
                    "Pay",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        });
  }
}
