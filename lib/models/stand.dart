class TypeStand {

  String name;
  int cost;

  TypeStand({ required this.name ,required this.cost});

  TypeStand.fromJson(Map<String, dynamic> json) :this(
      name : json['label'],
      cost : json['prix']
  );
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.name;
    data['prix'] = this.cost;
    return data;
  }
}