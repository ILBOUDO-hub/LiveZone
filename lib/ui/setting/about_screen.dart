/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'EasyPass',
    packageName: 'Unknown',
    version: '1.0',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
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
        Text("A propos de nous",
                style: mediumLargeTextStyle,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis)
            .addMarginLeft(spacingContainer)
      ],
    ).wrapPaddingAll(spacingContainer),
  ),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/Easy.png",
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                  Text(
                    "EasyPass",
                    style:
                        boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                  ),
                  Text("votre application de billetterie mobile vous permet de payer vos tickets d’événement en ligne partout où vous soyez.",
                          style: normalTextStyle)
                      .wrapPadding(
                          padding: const EdgeInsets.only(
                              top: spacingControl,
                              bottom: spacingControl,
                              left: spacingContainer,
                              right: spacingContainer)),
                  Text('Dévéloppé par ',
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeNormal))
                      .addMarginTop(spacingContainer),
                  Text('Futurix LLC', style: normalLargeTextStyle)
                      .addMarginTop(spacingControl),
                  Text('Version Info',
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeNormal))
                      .addMarginTop(spacingContainer),
                  Text(_packageInfo.version, style: normalLargeTextStyle)
                      .addMarginTop(spacingControl),
                  Text('Suivez nous sur',
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeNormal))
                      .addMarginTop(spacingContainer),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    InkWell(
                      onTap: () => {openWhatsApp(context)},
                      child: Image.asset(
                        'assets/whatsapp.png',
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(width: itemSpacing),

                    InkWell(
                      onTap: () => {
                        launchURL('https://www.facebook.com/profile.php?id=100086818106031', context)
                      },
                      child: Image.asset(
                        'assets/facebook_icon.png',
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(width: itemSpacing),
                    InkWell(
                      onTap: () => {
                        launchURL('https://www.instagram.com/p/CkLtNYpK2IX/?igshid=YmMyMTA2M2Y=',
                            context)
                      },
                      child: Image.asset(
                        'assets/instagram.png',
                        height: 35,
                        width: 35,
                      ),
                    )
                  ]).addMarginTop(12)
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
