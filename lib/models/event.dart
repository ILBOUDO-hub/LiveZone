
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/models/organisateur.dart';
import 'package:eventpro/models/stand.dart';
import 'package:eventpro/models/typeStand.dart';

class Event {

  DocumentReference<Map<String, dynamic>>? id;
  String name;
  List coverPictures;
  DateTime  startDate;
  DateTime endDate;
  String description;
  String ville;
  String nomLieu;
  GeoPoint? lieu;
  String category;
  List? typeStand;
  bool isActive;
  bool isVisible;
  bool isOnline;
  String? eventLink;
  List? typeTicket;
  Organisateur organisateur;
  List? participant;
  bool? isfree;
  bool? need_reservation;
  Event({this.participant,this.isfree=false,this.need_reservation=false, this.id,required this.name, this.typeTicket= const [], required this.coverPictures,required this.startDate,required this.endDate,required this.description, this.lieu,required this.ville,required this.category,required this.typeStand,required this.organisateur ,this.isActive = false,this.isVisible=false,this.isOnline = false,this.eventLink,required this.nomLieu });

  Event.fromJson(Map<String, dynamic> json) :this(
    
    name: json['name'],
    coverPictures: json['covers'],
    startDate: (json['startDate'] as Timestamp).toDate(),
    endDate: (json['endDate'] as Timestamp).toDate(),
    description: json['description'],
    ville: json['ville'],
    category: json['category'],
    lieu: json['lieu'],
    typeStand: (json['typeStands'] as List).map((e)=> TypeStand.fromJson(e) ).toList(),
    // typeTicket: (json['typeTicket'] as List).map((e)=> TypeTicket.fromJson(e) ).toList(),
    organisateur: Organisateur.fromJson(json['organisateur']),
    isActive: json['isActive'],
    isVisible: json['isVisible'],
    isOnline : json['isOnline'],
    eventLink : json['eventLink'],
    nomLieu: json['nomLieu'],
    participant: json['participants'],
    isfree: json['is_free'],
    need_reservation: json['need_reservation']

  );

  Map<String, dynamic> toJson(){
   Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['covers'] = this.coverPictures;
    data['startDate'] =this.startDate;
    data['endDate'] = this.endDate;
    // data['typeTicket'] = this.typeTicket;
    data['description'] = this.description;
    data['ville'] = this.ville;
    data['category'] = this.category;
    data['lieu'] =this.lieu;
    data['isOnline'] = this.isOnline;
    data['eventLink'] = this.eventLink;
    data['nomLieu']= this.nomLieu;
    data['typeStands']= this.typeStand!.map((e) => (e as TypeStand).toJson()).toList();
    data['organisateur'] = this.organisateur.toJson();
    data['isActive'] = this.isActive;
    data['isVisible'] = this.isVisible;
    return data;
  }
}