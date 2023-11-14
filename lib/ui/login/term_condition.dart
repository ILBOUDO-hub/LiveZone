import 'package:eventpro/controllers/event_controller.dart';
import 'package:eventpro/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Termes et conditions"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Obx(() => SingleChildScrollView(
          child: Text(
                EventController.instance.termsandConditiom.value ,
                style: normalTextStyle,
              ),
        )),
      )),
    );
  }
}
