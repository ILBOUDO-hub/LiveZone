class CodePromo {

  int? id;
  String code;
  bool isValid;
  int limit;

  CodePromo({ this.id,required  this.code ,required this.isValid,required this.limit});

  CodePromo.fromJson(Map<String, dynamic> json):this(
      id : json['id'],
      code : json['code'],
      isValid: json['isValid'],
      limit: json['limit']
  );

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['isValid'] = this.isValid;
    data['limit'] = this.limit;
    return data;
  }
}