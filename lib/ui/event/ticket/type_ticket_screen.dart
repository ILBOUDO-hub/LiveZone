import 'dart:math';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/event/event_book_screen.dart';
import 'package:eventpro/ui/event/event_details_screen.dart';
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/utils/tickets_payment.dart';
import 'package:eventpro/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TypeTicketScreen extends StatelessWidget {
  Event e;
  TypeTicketScreen({Key? key, required this.e}) : super(key: key);
  Map<String, dynamic>? response;
  Color? color;
  Fluttertoast? fluttertoast;
  bool show = false;
  RxInt qte = 1.obs;
  RxBool disablebutton = false.obs;
  RxMap panier = {}.obs;
  RxBool contain_free_ticket = false.obs;
  @override
  Widget build(BuildContext context) {
    print(e.typeTicket);
    for (var element in e.typeTicket!) {
      panier.value[element.name] = 0;
    }
    print(panier);
    int nombre_jour = e.startDate.isAfter(DateTime.now())
        ? DateUtils.dateOnly(e.endDate)
            .difference(DateUtils.dateOnly(e.startDate))
            .inDays
        : DateUtils.dateOnly(e.endDate)
            .difference(DateUtils.dateOnly(DateTime.now()))
            .inDays;
    var _pages = <Widget>[];
    final tabs = <Widget>[];
    for (var i = 0; i <= nombre_jour; i++) {
      tabs.add(Tab(
        text:
            "Jour ${i + 1} \n ${DateFormat("EEEE,d LLL").format(e.startDate.isAfter(DateTime.now()) ? e.startDate.add(Duration(days: i)) : DateTime.now().add(Duration(days: i)))} ",
      ));
      var Tickets = e.typeTicket!.where((element) {
        element as TypeTicket;
        if (e.startDate.isAfter(DateTime.now())) {
          return DateUtils.isSameDay(element.dateDebutValidite,
                  e.startDate.add(Duration(days: i))) ||
              DateUtils.isSameDay(
                  element.dateFinValidite, e.startDate.add(Duration(days: i)));
        } else {
          print(DateUtils.isSameDay(element.dateDebutValidite,
                  DateTime.now().add(Duration(days: i))) ||
              DateUtils.isSameDay(element.dateFinValidite,
                  DateTime.now().add(Duration(days: i))));
          return DateUtils.isSameDay(element.dateDebutValidite,
                  DateTime.now().add(Duration(days: i))) ||
              DateUtils.isSameDay(element.dateFinValidite,
                  DateTime.now().add(Duration(days: i)));
        }
      }).where((element) {
        element as TypeTicket;
        print(element.hiddenAfter);
        print(DateTime.now().isAfter(element.hiddenuntil!));
        if (element.hiddenuntil != null) {
          return DateTime.now().isAfter(element.hiddenuntil!);
        } else {
          return true;
        }
      }).where((element) {
        element as TypeTicket;
        print(element.hiddenAfter);
        print(DateTime.now().isBefore(element.hiddenAfter!));
        if (element.hiddenAfter != null) {
          return DateTime.now().isBefore(element.hiddenAfter!);
        } else {
          return true;
        }
      }).where((element) {
        element as TypeTicket;
        if (element.quantity != null) {
          return element.quantity! > 0;
        } else {
          return true;
        }
      }).toList();
      _pages.add(SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Quel ticket désirez vous ?",
                style: mediumLargeTextStyle,
              ),
              Text(
                "Clickez sur le Ticket désiré pour l'acheter ",
                style: smallMediumTextStyle,
              ),
              const SizedBox(
                height: 25,
              ),
              Tickets.isEmpty
                  ? Container(
                      width: (Get.width > 475 ? 475 : Get.width),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          (Get.width > 475 ? 475 : Get.width) > 475
                              ? Image.asset(
                                  "assets/tickets.png",
                                  height:
                                      (Get.width > 475 ? 475 : Get.width) * 0.5,
                                  width:
                                      (Get.width > 475 ? 475 : Get.width) * 0.5,
                                )
                              : Image.asset(
                                  "assets/tickets.png",
                                  height: 475 * 0.5,
                                  width: 475 * 0.5,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Ticket indisponible pour le moment",
                            style: boldLargeTextStyle,
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
              ...Tickets.map((type) {
                type as TypeTicket;
                
                return Obx(() => disablebutton.value == false
                    ? Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          width: (Get.width > 475 ? 475 : Get.width) * 0.9,
                          constraints: const BoxConstraints(
                              maxHeight: 125, minHeight: 85),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    (Get.width > 475 ? 475 : Get.width) * 0.15,
                                decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                                child: const Center(
                                  child: Icon(Icons.qr_code),
                                ),
                              ),
                              Container(
                                width:
                                    (Get.width > 475 ? 475 : Get.width) * 0.6,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          (Get.width > 475 ? 475 : Get.width) *
                                              0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.name,
                                            style: mediumLargeTextStyle,
                                          ),
                                          Text(
                                            type.name,
                                            style: boldLargeTextStyle,
                                            maxLines: 2,
                                          ),
                                          type.isfree != true
                                              ? Obx(() => panier[type.name] > 0
                                                  ? Text(
                                                      type.price_in_pts==null ||type.price_in_pts! <=0? "${panier[type.name]} x ${type.prix} CFA":"${panier[type.name]} x ${type.prix} CFA ou ${panier[type.name] * type.price_in_pts} pts de fidelité",
                                                      style:
                                                          normalLargeTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                    )
                                                  : Text(
                                                      type.price_in_pts==null ||type.price_in_pts! <=0?"${type.prix} CFA":"${type.prix} CFA ou ${type.price_in_pts} pts de fidelité",
                                                      style:
                                                          normalLargeTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                    ))
                                              : Obx(() => panier[type.name] < 1
                                                  ? Text(
                                                      "Acces Gratuit",
                                                      style:
                                                          normalLargeTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                    )
                                                  : Text(
                                                      "${panier[type.name]} - Acces Gratuit",
                                                      style:
                                                          normalLargeTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                    )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      if (type.isfree == true) {
                                        contain_free_ticket.value = true;
                                      }
                                      panier[type.name]++;
                                    },
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      width: Get.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                          )),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: Get.width,
                                    height: 5,
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      if (panier[type.name] > 0) {
                                        panier[type.name]--;
                                      } else {
                                        if (type.isfree == true) {
                                          contain_free_ticket.value = false;
                                          contain_free_ticket.refresh();
                                        }
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      width: Get.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                          )),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                    )
                    : Center(
                        child: LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color.fromARGB(255, 0, 0, 0),
                          rightDotColor: primaryColor,
                          size: 150,
                        ),
                      ));
              })
            ],
          ),
        ),
      ));
    }
    return DefaultTabController(
        length: tabs.length,
        child:  Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Obx(() {
                  int total = 0;
                  int total_fidelite = 0;

                  for (var element in panier.keys) {
                    if ((e.typeTicket!.firstWhere((elt) => elt.name == element)
                                    as TypeTicket)
                                .isfree ==
                            true 
                        ) {
                          if(panier[element] <= 0){
print(panier[element]);
                      contain_free_ticket.value = false;
                          }
                      
                    } else {
                      total = (total +
                              panier[element] *
                                  (e.typeTicket!.firstWhere(
                                              (elt) => elt.name == element)
                                          as TypeTicket)
                                      .prix)
                          .toInt();
                          total_fidelite = (total_fidelite +
                              panier[element] *
                                  (e.typeTicket!.firstWhere(
                                              (elt) => elt.name == element)
                                          as TypeTicket)
                                      .price_in_pts!)
                          .toInt();
                    }
                  }
                  return total == 0 && contain_free_ticket.value == false
                      ? SizedBox()
                      : Wrap(
                        crossAxisAlignment:WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          MyAuthController.instance.account.value.rewards! >= total_fidelite? CupertinoButton(
                          onPressed: ()async{
                              // await Checkout(e, panier, context);
                          },
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          child: Text(
                            "Echangez contre ${total_fidelite} pts de fidelité",
                            style: boldTextStyle.copyWith(color: Colors.white),
                          ),
                        ):const SizedBox(),
                        const SizedBox(height: 20,),
                          CupertinoButton(
                              onPressed: ()async{
                                  await Checkout(e, panier, context);
                              },
                              color: primaryColor,
                              child: Text(
                                "Passez au paiement (${total}) FCFA",
                                style: boldTextStyle.copyWith(color: Colors.white),
                              ),
                            ),
                        ],
                      );
                }),
                appBar: AppBar(
                  leading: BackButton(
                    color: Colors.white,
                    onPressed: () => Get.off(EventDetailsScreen(event: e)),
                  ),
                  title: Text(
                    "Details Ticket",
                    style: mediumLargeTextStylewhite,
                  ),
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(children: _pages),
                // bottomNavigationBar: Container(
                //   padding: EdgeInsets.symmetric(vertical: 10),
                //   width: (Get.width > 475 ? 475 : Get.width) > 475
                //       ? 475
                //       : (Get.width > 475 ? 475 : Get.width),
                //   height: Get.height * 0.125,
                //   decoration: const BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             offset: Offset(0, 0),
                //             blurRadius: 10,
                //             spreadRadius: 0)
                //       ]),
                //   child: Center(
                //       child: Column(
                //     children: [
                //       Text(
                //         'Nombre de tickets',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       const SizedBox(
                //         height: 5,
                //       ),
                //       Container(
                //         width: MediaQuery.of(context).size.width * 0.75,
                //         height: MediaQuery.of(context).size.height * 0.06,
                //         padding: EdgeInsets.only(left: 8, right: 8),
                //         decoration: BoxDecoration(
                //             color: primaryColor,
                //             borderRadius: BorderRadius.circular(15)),
                //         child: SpinBox(
                //             keyboardType: TextInputType.none,
                //             iconSize: 25,
                //             textStyle: const TextStyle(
                //                 fontSize: 22, fontWeight: FontWeight.bold),
                //             decoration: const InputDecoration(
                //                 border: InputBorder.none,
                //                 disabledBorder: InputBorder.none),
                //             min: 1,
                //             max: 300,
                //             value: 1,
                //             iconColor: MaterialStateColor.resolveWith(
                //                 (states) => Colors.black),
                //             onChanged: (value) {
                //               // print(value);
                //               qte.value = value.toInt();
                //             }),
                //       ),
                //     ],
                //   )),
                // ),
              )
    );
  }

  Checkout(Event event, Map panier, BuildContext context) async {
    if (MyAuthController.instance.firebaseUser.value == null) {
      Get.showSnackbar(GetSnackBar(
          title: "Connection requise",
          message:
              "Veuillez vous connectez pour poursuivre l'achet de vos ticket",
          duration: Duration(seconds: 10)));

      Get.to(() => LoginScreen());
    } else {
      int total = 0;

      for (var element in panier.keys) {
        if ((e.typeTicket!.firstWhere((elt) => elt.name == element)
                        as TypeTicket)
                    .isfree ==
                true ) {
          print(panier[element]);
          contain_free_ticket.value = false;
        } else {
          total = (total +
                  panier[element] *
                      (e.typeTicket!.firstWhere((elt) => elt.name == element)
                              as TypeTicket)
                          .prix)
              .toInt();
        }
        if (total == 0) {
          disablebutton.value = !disablebutton.value;
          var ticket;
          // EasyLoading.show(
          //     indicator: LoadingAnimationWidget.twistingDots(
          //       leftDotColor: Color.fromARGB(255, 255, 255, 255),
          //       rightDotColor: primaryColor,
          //       size: 25,
          //     ),
          //     dismissOnTap: false);
          for (var ticks in panier.keys) {
            var type = (e.typeTicket!
                    .firstWhere((element) => element.name == ticks)
                as TypeTicket);
            int nombre_de_ticket = (type.nombre_ticket == null
                    ? panier[ticks]
                    : panier[ticks] * type.nombre_ticket!)
                .toInt();
                print(nombre_de_ticket);
            for (var i = 0; i < nombre_de_ticket; i++) {
              ticket = await TicketController.instance.createTicket(
                  e.id!, type, type.cover ?? e.coverPictures[0], e, context);
            }
          }

          EasyLoading.showSuccess("Success De l'achat du billet");
          TicketController.instance.getTicket();

          disablebutton.value = !disablebutton.value;

          Get.to(() => EventBookScreen(
                ticket: ticket,
                isOk: true,
              ));
        } else {
          print(panier);
          payTicket(
              total + 0.0,
              qte > 1
                  ? "Paiement de Tickets ${e.name} "
                  : "Paiement de Ticket  pour ${e.name} ",
              MyAuthController.auth.currentUser!.phoneNumber!.substring(4),
              () async {
                try{
            var ticket;
            EasyLoading.show(
                indicator: LoadingAnimationWidget.twistingDots(
                  leftDotColor: Color.fromARGB(255, 255, 255, 255),
                  rightDotColor: primaryColor,
                  size: 25,
                ),
                dismissOnTap: false);
            for (var ticks in panier.keys) {
              var type = (e.typeTicket!
                      .firstWhere((element) => element.name == ticks)
                  as TypeTicket);
              int nombre_de_ticket = (type.nombre_ticket == null
                      ? panier[ticks]
                      : panier[ticks] * type.nombre_ticket!)
                  .toInt();
              for (var i = 0; i < nombre_de_ticket; i++) {
                ticket = await TicketController.instance.createTicket(
                    e.id!, type, type.cover ?? e.coverPictures[0], e, context);
              }
            }
            EasyLoading.showSuccess("Success De l'achat du billet");
            TicketController.instance.getTicket();

            Get.to(() => EventBookScreen(
                  ticket: ticket,
                  isOk: true,
                ));
                }catch(e){
                  print(e);
                }
          });
        }
      }
    }
  }
}
