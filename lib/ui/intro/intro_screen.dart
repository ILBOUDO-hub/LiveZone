import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/ui/login/login_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get_storage/get_storage.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) async{
    GetStorage box = GetStorage();
    await box.write("already_open", true);
    Navigator.of(context).push(SlideRightRoute(page: HomeScreen()));
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle =
        normalTextStyle.copyWith(fontSize: textSizeLargeMedium);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: mediumLargeTextStyle.copyWith(color: primaryColor),
      bodyTextStyle: bodyStyle,
      contentMargin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: backgroundColor,
          pages: [
            PageViewModel(
              title: "EasyPass",
              body: "Payer vos tickets d’événements en ligne où vous êtes.",
              image: _buildImage('onbording1.jpg').wrapPaddingAll(16),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Voir les évènements à venir",
              body:
                  "Restez informé sur tous vos évènements préférés et ceux en cours.",
              image: _buildImage('onbording2.png').wrapPaddingAll(16),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Accès Facile et rapide",
              body:
                  "Evitez les longues files d’attente lors de vos évènements.",
              image: _buildImage('onbording3.png'),
              decoration: pageDecoration,
            )
          ],
          onDone: () => _onIntroEnd(context),
          showSkipButton: true,
          // skipFlex: 0,
          nextFlex: 0,
          //rtl: true, // Display as right-to-left
          skip: Text('Passez',
              style: boldTextStyle.copyWith(color: primaryColor)),
          next: const Icon(Icons.keyboard_arrow_right_rounded,
              color: primaryColor),
          done: Text('Terminé',
              style: boldTextStyle.copyWith(color: primaryColor)),
          // skipColor: primaryColor,
          // nextColor: primaryColor,
          // doneColor: primaryColor,
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: primaryColor,
            activeColor: primaryColor,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              side: BorderSide(
                  color: primaryColor, width: 5, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
