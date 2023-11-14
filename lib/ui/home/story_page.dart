import 'package:eventpro/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class StoryPage extends StatelessWidget {
  List<StoryItem> storyItems ;
   StoryPage({Key? key ,required this.storyItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = StoryController();
//     final List<StoryItem> storyItems = [
//   StoryItem.text(title: '''“When you talk, you are only repeating something you know.
//    But if you listen, you may learn something new.” 
//    – Dalai Lama''',
//       backgroundColor: Colors.blueGrey),
//   StoryItem.pageImage(
//       url:
//           "https://firebasestorage.googleapis.com/v0/b/fourevent-ea1dc.appspot.com/o/eventPictures%2Fdata%2Fuser%2F0%2Fcom.example.admin_event_pro%2Fcache%2Fimage_picker3176380162496607470.png?alt=media&token=3998105d-61e5-4298-a065-a9f52aaf19db",
//       controller: _controller),
//   StoryItem.pageImage(
//       url:
//           "https://wp-modula.com/wp-content/uploads/2018/12/gifgif.gif",
//       controller: _controller,
//       caption: "test ",
//       imageFit: BoxFit.contain),
// ];
    return Material(
      child: StoryView(
        storyItems: storyItems,
        controller: _controller,
        inline: false,
        repeat: false,
        indicatorColor: primaryColor,
        onComplete: (){
          Get.back();
        },
        onStoryShow: (item){
          item.shown = false;
        },
      ),
    );
  }
}