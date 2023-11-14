import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final Function? onTap;
  final double? btnWidth;

  const ButtonWidget({Key? key, this.text, this.onTap, this.btnWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap != null ? onTap!() : null,
        child: Ink(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    (btnWidth != null ? btnWidth! : 0.5),
                minHeight: buttonHeight),
            alignment: Alignment.center,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: boldLargeTextStyle.copyWith(
                  color: Colors.white, fontSize: textSizeNormal),
            ),
          ),
        ),
      ),
    );
  }
}
