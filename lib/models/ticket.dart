import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/models/typeStand.dart';
import 'package:flutter/material.dart';

class Ticket {
  DocumentReference? id;
  Event event;
  String code;
  String cover;
  TypeTicket typeTicket;
  bool isActive;
  bool isValid;
  String? proprietaire;


  Ticket({required this.event, this.proprietaire="", this.id,required this.code,required this.cover,required this.isActive,required this.isValid , required this.typeTicket,});

  Ticket.fromJson(Map<String, dynamic> json):this(
      code : json['code'],
      event: Event.fromJson(json['event']),
      isActive :json['isActive'],
      isValid : json['isValid'],
      typeTicket: TypeTicket.fromJson(json['typeTicket']),
      cover: json['cover'],
      proprietaire: json['proprietaire']
  );

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    // data['proprietaire']= this.proprietaire;
    data['event'] = this.event.toJson();
    data['isActive'] = this.isActive;
    data['isValid'] = this.isValid;
    data['typeTicket'] =this.typeTicket.toJson();
    data['cover'] = this.cover;
    return data;
  }
}