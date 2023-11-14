
import 'package:cloud_firestore/cloud_firestore.dart';

class Organisateur {

  DocumentReference? id;
  String name;
  String phoneNumber;
  String responsable;
  List events;
  int nombrevenement;
  int solde;
  
  Organisateur({ this.id,required this.name ,required this.phoneNumber,required this.responsable,this.events = const [] ,this.solde = 0,this.nombrevenement=0});

  Organisateur.fromJson(Map<String, dynamic> json) :this (
      name : json['name'],
      phoneNumber: json['phoneNumber'],
      responsable: json['responsable'],
      events: json['events'],
      solde:json['solde'],
      nombrevenement:json['nombrevenement']
  );

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['responsable'] = this.responsable;
    data['events'] = this.events;
    data['solde'] = this.solde;
    data['nombrevenement'] = this.nombrevenement;
    return data;
  }
}
