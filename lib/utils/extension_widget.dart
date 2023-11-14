
import 'dart:io';

import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

circularImageBorder(double size, String placeHolder, String imageUrl) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      border: Border.all(
        color: primaryColor,
        width: borderWidth,
      ),
    ),
    child: ClipOval(
        child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage(placeHolder),
            image: AssetImage(imageUrl))),
  );
}

toolbarBack(String title, BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(150.0),
    child: Row(
      children: [
        InkWell(
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: primaryColor),
            child: Center(
                child: Image.asset(
              "assets/arrow.png",
              height: 24,
              width: 24,
            )),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Text(title,
                style: mediumLargeTextStyle,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis)
            .addMarginLeft(spacingContainer)
      ],
    ).wrapPaddingAll(spacingContainer),
  );
}

labelTextWidget(String title, double spacingSize) {
  return Text(title, style: normalTextStyle.copyWith(color: Colors.white))
      .wrapPadding(
          padding: EdgeInsets.only(left: spacingSize, top: spacingStandard));
}

launchURL(String url, BuildContext context) async {
  EasyLoading.show();

  await canLaunchUrlString(url)
    ? await launchUrlString(url)
    : throw ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(url)));

  EasyLoading.dismiss();
    
}

openWhatsApp(BuildContext context) async {
  EasyLoading.show();
  var whatsapp = "+22662825040";
  var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=hello";
  var whatAppURLIOS = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrlString(whatAppURLIOS)) {
      await launchUrlString(whatAppURLIOS,);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Whatsapp non installé")));
    }
  } else {
    if (await canLaunchUrlString(whatsappURlAndroid)) {
      await launchUrlString(whatsappURlAndroid);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Whatsapp non installé")));
    }
  }
  EasyLoading.dismiss();
}
