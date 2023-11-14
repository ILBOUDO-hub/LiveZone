import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/ui/home/story_page.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/values.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class Story {
  DocumentReference? id ;
  String title;
  List elements;
  DateTime date;
  String previewImage;

  Story({this.id, required this.title ,required this.elements,required this.date ,required this.previewImage});

  Story.fromJson(Map<String, dynamic> json) :this(
    previewImage :json['previewImage'],
      title : json['title'],
      elements : (json['elements'] as List).map((e) {
        if(e['type']=='text'){
          return StoryItem.text( title: e['text'], backgroundColor: Colors.white,textStyle: mediumLargeTextStyle, shown: true,roundedTop: true);
        }
        else if(e['type']=='image'){
          return StoryItem.pageImage(url: e['url'], controller: StoryController(), caption: e['text']);
        }else{
          return StoryItem.pageVideo(e['url'], controller: StoryController(),duration: Duration(seconds: 45));
        }
      }).toList(),
      date: (json['date'] as Timestamp).toDate()
  );
  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['label'] = this.name;
  //   data['prix'] = this.cost;
  //   return data;
  // }
}