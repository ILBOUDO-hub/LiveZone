import 'package:cloud_firestore/cloud_firestore.dart';

class TypeTicket {

  DocumentReference? id;
  String name;
  int? quantity;
  String description;
  int prix;
  DateTime? hiddenuntil; // permettra de masquer un billet de la liste des ticket en vente jusqu'as une certaine date
  DateTime? hiddenAfter; // permettra de masquer un billet de la liste des ticket en vente Apres une certaine date
  bool showqty;
  DateTime dateDebutValidite;
  DateTime dateFinValidite;
  bool? isfree;
  String? cover;
  int? nombre_ticket;
  int? reward;
  int? price_in_pts;




  TypeTicket({ this.isfree, this.cover, required this.prix, this.id,required this.name, this.quantity,required this.description,required this.dateDebutValidite,required this.dateFinValidite,this.hiddenAfter,this.hiddenuntil,this.showqty = false ,this.nombre_ticket =1,this.reward=0 ,this.price_in_pts=0});

  TypeTicket.fromJson(Map<String, dynamic> json) : this(
      name : json['name'],
      prix: json['prix'],
      quantity: json['quantity'],
      description: json['description'],
      hiddenuntil: json['hiddenuntil']!= null ? (json['hiddenuntil'] as Timestamp).toDate() :null,
      hiddenAfter: json['hiddenAfter'] != null ?(json['hiddenAfter'] as Timestamp).toDate():null,
      showqty: json['showqty'],
      dateDebutValidite: (json['dateDebutValidite'] as Timestamp).toDate(),
      dateFinValidite: (json['dateFinValidite']as Timestamp).toDate(),
      cover :json['url'],
      isfree:json['isfree'],
      nombre_ticket: json['nombre_ticket'],
      reward: json['reward'],
      price_in_pts: json['price_in_pts']
  );

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {
      'name' :name,
      'prix':prix,
      'url':cover,
      'isfree': isfree,
      'quantity': quantity,
      'description':description,
      'hiddenuntil':hiddenuntil,
      'hiddenAfter':hiddenAfter,
      'showqty':showqty,
      'dateDebutValidite':dateDebutValidite,
      'dateFinValidite':dateFinValidite,
      'nombre_ticket':nombre_ticket,
      'reward':reward
    };
    return data;
  }
}