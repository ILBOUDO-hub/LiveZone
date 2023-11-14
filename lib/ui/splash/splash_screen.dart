
import 'dart:async';

import 'package:eventpro/ui/intro/intro_screen.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/bouncing_loader.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Easy.png",
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Text(
                  "EasyPass",
                  style: boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const LoadingBouncingLine.circle(
          borderSize: 3.0,
          size: 50.0,
          backGroundColor: primaryColor,
          duration: Duration(seconds: 3),
        ));
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacement(SlideRightRoute(page: const IntroScreen())));
  }
}
