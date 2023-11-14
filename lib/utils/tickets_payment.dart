import 'dart:async';
import 'dart:math';
import 'package:eventpro/ui/event/payement.dart';
import 'package:eventpro/utils/custom_Cinet_pay_Widget.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

Future<dynamic> payTicket(double amount, String description , String phone,AsyncCallback callback) async {

  Fluttertoast? fluttertoast;
  final String transactionId = Random().nextInt(100000000).toString();
  Map<String, dynamic>? response;
  try{
    Get.to(()=>PayementScreen( description: description, montant: amount.toInt(),userphone: phone,callback: callback, ));
  }catch(e){
    debugPrint(e.toString());
  }
  } 