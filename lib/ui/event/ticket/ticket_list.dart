import 'dart:math';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/models/bill.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:eventpro/ui/event/event_book_screen.dart';
import 'package:eventpro/ui/event/ticket/ticket_material.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/utils/tickets_payment.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyPassScreen extends StatelessWidget {
  MyPassScreen({Key? key}) : super(key: key);
  Map<String, dynamic>? response;
  Color? color;
  Fluttertoast? fluttertoast;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      Tab(
        text: "Prochainement",
      ),
      Tab(
        text: "Historique",
      )
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Mes Billets",
                style: mediumLargeTextStyle,
              ),
              backgroundColor: Colors.white,
              centerTitle: false,
              bottom: TabBar(
                labelColor: primaryColor,
                tabs: tabs,
                indicatorColor: primaryColor,
              ),
              elevation: 5,
            ),
            body: TabBarView(children: 
            <Widget>[
      SingleChildScrollView(
        child: Container(
          width: Get.width,
          // height: Get.height,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Obx(() => Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Get.width,
              // height: Get.height,
              child: Column(
                    children: [
                       TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isAfter(DateTime.now())).isEmpty? Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Image.asset("assets/tickets.png",height: Get.width*0.5,width: Get.width*0.5,),
                           const SizedBox(
                      height: 5,
                    ),
                        Text("Vous n'avez pas de Ticket ",style: boldLargeTextStyle,),
                        SizedBox(
                          width: Get.width,
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                Get.off(HomeScreen());
                              }, icon: Icon(Icons.arrow_back)),
                              Expanded(
                                child: Text("Voir les evenements et acheter un Ticket",
                                style: smallBoldTextStyle.copyWith(fontSize: 12),
                                maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ) :
                  SizedBox() ,
                      ...TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isAfter(DateTime.now())).map((element) =>
                          Container(margin: EdgeInsets.only(bottom: 15),
                            child: TicketMaterial(
                              tapHandler: (){
                              Get.to(TicketView(ticket: element.obs,));
                          
                          } ,
                          longpressHandler: (){
                              print("Long press");
                            } ,
                              flexRightSize: 30,
                              flexLefSize: 60,
                              radiusBorder: 15,
                              shadowSize: 2,
                              height: 150,
                              colorBackground: Colors.white,
                              leftChild: Container(
                                padding:
                                    EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      element.event.name,
                                      style: boldLargeTextStyle,
                                    ),
                                    Text(
                                      DateFormat("EEEE,d LLL HH'h':mm").format(element.typeTicket.dateDebutValidite),
                                      style: mediumLargeTextStyle,
                                    ),
                                    // Text("Afficher ticket",style: normalLargeTextStyle,),
                                    Obx( ()=> Chip(label: Text(
                                      element.typeTicket.name,
                                      style: boldLargeTextStyle,
                                    ),
                                    backgroundColor: TicketController.instance.Valid.value ? primaryColor :Colors.white))
                                    // Text(element.typeTicket)
                                  ],
                                ),
                              ),
                              rightChild: FancyShimmerImage(
                                imageUrl: element.cover,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ],
                  ),
            ),
          )),
        ),
      ),
            SingleChildScrollView(
              child: Container(
                    width: Get.width,
                    // height: Get.height,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isBefore(DateTime.now())).isEmpty? Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Image.asset("assets/tickets.png",height: Get.width*0.5,width: Get.width*0.5,),
                           const SizedBox(
                      height: 5,
                    ),
                        Text("Vous n'avez pas de Ticket expiré",style: boldLargeTextStyle,),
                        
                      ],
                    ),
                  ): SizedBox(),
                  ...TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isBefore(DateTime.now())).map((element) =>
                      Container(margin: EdgeInsets.only(bottom: 15),
                        child: TicketMaterial(
                          tapHandler :(){
                            // print("yey2");
                             Get.to(TicketView(ticket: element.obs,));
                        },
                          flexRightSize: 30,
                          flexLefSize: 60,
                          radiusBorder: 15,
                          shadowSize: 2,
                          height: 150,
                          colorBackground: Colors.white,
                          leftChild: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  element.event.name,
                                  style: boldLargeTextStyle,
                                ),
                                Text(
                                  DateFormat("EEEE,d LLL HH'h':mm").format(element.typeTicket.dateDebutValidite),
                                  style: mediumLargeTextStyle,
                                ),
                                // Text("Afficher ticket",style: normalLargeTextStyle,),
                                Chip(label: Text(
                                  element.typeTicket.name,
                                  style: boldLargeTextStyle,
                                ),)
                                // Text(element.typeTicket)
                              ],
                            ),
                          ),
                          rightChild: FancyShimmerImage(
                            imageUrl:element.cover,
                            boxFit: BoxFit.cover,
            
                          ),
                        ),
                      )),
                      TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isBefore(DateTime.now())).isNotEmpty ? InkWell(
                        onTap: (){
                               showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: Border.all(
                                        color: primaryColor,
                                        width: borderWidth,
                                        style: BorderStyle.solid),
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      'Achat de Ticket',
                                      style: boldLargeTextStyle.copyWith(
                                          fontSize: textSizeNormal),
                                    ),
                                    // To display the title it is optional
                                    content: Text(
                                        "Vous etes sure de vouloir supprimer vos anciens billets ?",
                                        style: mediumTextStyle),
                                    // Message which will be pop up on the screen
                                    // Action widget which will provide the user to acknowledge the choice
                                    actions: [
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
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
                                          child: Text('Non',
                                              style: boldTextStyle),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
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
                                           TicketController.instance.mesTickets.where((ticket) => ticket.typeTicket.dateFinValidite.isBefore(DateTime.now())).forEach((e) {
                                            try {
                                            e.id!.delete();
                                              
                                            } catch (e) {
                                              
                                            }
                                           });
                                           Get.back();
                                           TicketController.instance.getTicket();
                                          },
                                          child:
                                              Text('Oui', style: boldTextStyle),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Suprimez mes anciens Billets",style: smallMediumTextStyle.copyWith(color: Colors.red),),
                            const Icon(Icons.delete_forever,color: Colors.red,),
                          ],
                        ),
                      ) : const SizedBox()
                ],
              )),
                  ),
            ),

      
    ]
    ),
    // floatingActionButton: FloatingActionButton(child: Icon(Icons.abc),onPressed: (() {
      
    // }),),
    )
    );
  }
}
