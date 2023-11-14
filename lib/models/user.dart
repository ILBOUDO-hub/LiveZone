

import 'package:eventpro/models/ticket.dart';

enum UserType{
  simple,
  bronz,
  silver,
  gold,
  platinum
}

class Client {
  String name;
  String phoneNumber;
  String? agentParrain;
  String? macadress;
  List<Ticket> tickets;
  String? code;
  int? rewards;
  UserType status;

  Client({required this.name ,this.macadress ,required this.phoneNumber,this.tickets = const [] , this.code ,this.rewards = 0,this.status = UserType.simple});

  Client.fromJson(Map<String, dynamic> json) :this (
      macadress: json['macAdress'],
      name : json['name'],
      phoneNumber: json['phoneNumber'],
      code: json['code'],
      rewards: json['rewards'],
      status: json['status'] !=null ? UserType.values[json['status']]: UserType.simple,
      // tickets: ((json['tickets'] as List).map((e) => Ticket.fromJson(e))).toList()
  );

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['macAdress'] = this.macadress;
    data['rewards'] = this.rewards;
    data['status'] = this.status.index;
    // data['tickets'] = this.tickets;
    return data;
  }
}