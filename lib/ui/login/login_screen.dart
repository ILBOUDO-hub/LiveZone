import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:eventpro/controllers/phone_auth_controller.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/ui/intro/intro_screen.dart';
import 'package:eventpro/ui/login/layer.dart';
import 'package:eventpro/ui/login/term_condition.dart';
import 'package:eventpro/ui/register/register_screen.dart';
import 'package:eventpro/ui/register/verify_otp_screen.dart';
import 'package:eventpro/utils/extension.dart';
import 'package:eventpro/utils/extension_widget.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:eventpro/widgets/button_widget.dart';
import 'package:eventpro/widgets/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:gif_view/gif_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  String phone = "";
  bool allow = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        desktop: (ctx) => Scaffold(
            backgroundColor: backgroundColor,
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
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    // width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/loginbg.gif'),
                      fit: BoxFit.fitHeight,
                    )),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(216, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(75),
                                        topRight: Radius.circular(75)),
                                    image: DecorationImage(
                                        image: AssetImage("assets/Easy.png"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 350,
                                padding: const EdgeInsets.only(
                                    left: 25, top: 20, bottom: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Color(0x80FFFFFF),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60.0),
                                    bottomRight: Radius.circular(60.0),
                                  ),
                                ),
                                child: Container(
                                  // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.25),
                                  width: Get.width,
                                  height: 350,
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.0),
                                      bottomRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, left: 30, right: 30),
                                    child: Obx(() => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: Get.width,
                                              child: Text(
                                                'Votre numero de téléphone',
                                                style:
                                                    mediumLargeTextStylewhite,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                                width: Get.width,
                                                height: 70,
                                                child: IntlPhoneField(
                                                  onSubmitted: ((p0) {
                                                    FocusScopeNode current =
                                                        FocusScope.of(context);
                                                    if (!current
                                                        .hasPrimaryFocus) {
                                                      current.unfocus();
                                                    }
                                                  }),
                                                  controller: controller,
                                                  invalidNumberMessage:
                                                      "Numero de téléphone invalide",
                                                  dropdownTextStyle:
                                                      normalLargeTextStyle,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: "70 00..",
                                                    hintStyle:
                                                        normalLargeTextStyle,
                                                    errorStyle:
                                                        errorTextStyle.copyWith(
                                                            color: Colors.red),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                  ),
                                                  initialCountryCode: 'BF',
                                                  onChanged: (val) {
                                                    print(val);
                                                    this.phone =
                                                        val.completeNumber;
                                                    if (this.phone.length ==
                                                        12) {
                                                      FocusScopeNode current =
                                                          FocusScope.of(
                                                              context);
                                                      if (!current
                                                          .hasPrimaryFocus) {
                                                        current.unfocus();
                                                      }
                                                    }
                                                  },
                                                )
                                                // child: TextFormField(
                                                //   style: normalLargeTextStyle,
                                                //   controller: controller,

                                                //   onChanged: (val) {
                                                //     //  print(val.completeNumber);
                                                //     if (val.length<=8) {
                                                //                   this.phone = val;
                                                //   print(this.phone);
                                                //     }

                                                //   },
                                                //   decoration: InputDecoration(
                                                //     filled: true,

                                                //     fillColor: Colors.white,
                                                //     prefixIcon: Container(
                                                //       width: 85,
                                                //       height: 50,
                                                //       padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                                //       margin: EdgeInsets.symmetric(horizontal: 10),
                                                //       decoration: BoxDecoration(
                                                //         color :Colors.white,
                                                //         borderRadius: BorderRadius.only(topLeft: Radius.circular(textRadius),bottomLeft: Radius.circular(textRadius))
                                                //       ),
                                                //       child: Row(
                                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //         children: [
                                                //           SvgPicture.asset('icons/flags/svg/bf.svg', package: 'country_icons',width:  Get.width*0.075,height: 25,),
                                                //           Text("+226",style: mediumLargeTextStyle,)
                                                //         ],
                                                //       ),
                                                //     ),
                                                //     hintStyle: normalLargeTextStyle,
                                                //     errorStyle: errorTextStyle.copyWith(color: Colors.red),
                                                //     contentPadding: const EdgeInsets.all(0),
                                                //     focusedBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     enabledBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     errorBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     disabledBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     focusedErrorBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //   ),
                                                // ),
                                                ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            OtpController.instance.isLoading ==
                                                    false
                                                ? Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        print(this.phone);
                                                        if (this
                                                            .phone
                                                            .isEmpty) {
                                                          Get.showSnackbar(
                                                              GetSnackBar(
                                                            title:
                                                                "Numero de telephone",
                                                            message:
                                                                "Ce numero de telephone n'est pas valide !",
                                                            duration: Duration(
                                                                seconds: 5),
                                                          ));
                                                        } else {
                                                          await OtpController
                                                              .instance
                                                              .verifyPhone(
                                                                  this.phone);
                                                        }
                                                      },
                                                      child: Container(
                                                        width: Get.width * 0.4,
                                                        height: 45,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Continuer',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: boldLargeTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        primaryColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () async {},
                                                      child: Container(
                                                        width: 120,
                                                        height: 45,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5.0),
                                                          child: SizedBox(
                                                              width: 25,
                                                              height: 25,
                                                              child:
                                                                  CircleAvatar(
                                                                      backgroundColor:
                                                                          primaryColor,
                                                                      radius:
                                                                          10,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                      ))),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "En cliquant sur Continuer vous acceptez sans reserve nos",
                                                style: smallMediumTextStyle
                                                    .copyWith(
                                                        color: Colors.white)),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      const TermCondition());
                                                },
                                                child: Text(
                                                  "Termes et conditions",
                                                  style: smallBoldTextStyle
                                                      .copyWith(
                                                    color: Colors.yellow,
                                                  ),
                                                ))
                                          ],
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          height: 150,
                          left: 5,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
        mobile: (context) {
          return Scaffold(
              backgroundColor: backgroundColor,
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/loginbg.gif'),
                      fit: BoxFit.fitHeight,
                    )),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(216, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(75),
                                        topRight: Radius.circular(75)),
                                    image: DecorationImage(
                                        image: AssetImage("assets/Easy.png"),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 350,
                                padding: EdgeInsets.only(
                                    left: 25, top: 20, bottom: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Color(0x80FFFFFF),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60.0),
                                    bottomRight: Radius.circular(60.0),
                                  ),
                                ),
                                child: Container(
                                  // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.25),
                                  width: Get.width,
                                  height: 350,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.0),
                                      bottomRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, left: 30, right: 30),
                                    child: Obx(() => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: Get.width,
                                              child: Text(
                                                'Votre numero de téléphone',
                                                style:
                                                    mediumLargeTextStylewhite,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                                width: Get.width,
                                                height: 70,
                                                child: IntlPhoneField(
                                                  onSubmitted: ((p0) {
                                                    FocusScopeNode current =
                                                        FocusScope.of(context);
                                                    if (!current
                                                        .hasPrimaryFocus) {
                                                      current.unfocus();
                                                    }
                                                  }),
                                                  controller: controller,
                                                  invalidNumberMessage:
                                                      "Numero de téléphone invalide",
                                                  dropdownTextStyle:
                                                      normalLargeTextStyle,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: "70 00..",
                                                    hintStyle:
                                                        normalLargeTextStyle,
                                                    errorStyle:
                                                        errorTextStyle.copyWith(
                                                            color: Colors.red),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              textRadius),
                                                    ),
                                                  ),
                                                  initialCountryCode: 'BF',
                                                  onChanged: (val) {
                                                    print(val);
                                                    this.phone =
                                                        val.completeNumber;
                                                    if (this.phone.length ==
                                                        12) {
                                                      FocusScopeNode current =
                                                          FocusScope.of(
                                                              context);
                                                      if (!current
                                                          .hasPrimaryFocus) {
                                                        current.unfocus();
                                                      }
                                                    }
                                                  },
                                                )
                                                // child: TextFormField(
                                                //   style: normalLargeTextStyle,
                                                //   controller: controller,

                                                //   onChanged: (val) {
                                                //     //  print(val.completeNumber);
                                                //     if (val.length<=8) {
                                                //                   this.phone = val;
                                                //   print(this.phone);
                                                //     }

                                                //   },
                                                //   decoration: InputDecoration(
                                                //     filled: true,

                                                //     fillColor: Colors.white,
                                                //     prefixIcon: Container(
                                                //       width: 85,
                                                //       height: 50,
                                                //       padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                                //       margin: EdgeInsets.symmetric(horizontal: 10),
                                                //       decoration: BoxDecoration(
                                                //         color :Colors.white,
                                                //         borderRadius: BorderRadius.only(topLeft: Radius.circular(textRadius),bottomLeft: Radius.circular(textRadius))
                                                //       ),
                                                //       child: Row(
                                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //         children: [
                                                //           SvgPicture.asset('icons/flags/svg/bf.svg', package: 'country_icons',width:  Get.width*0.075,height: 25,),
                                                //           Text("+226",style: mediumLargeTextStyle,)
                                                //         ],
                                                //       ),
                                                //     ),
                                                //     hintStyle: normalLargeTextStyle,
                                                //     errorStyle: errorTextStyle.copyWith(color: Colors.red),
                                                //     contentPadding: const EdgeInsets.all(0),
                                                //     focusedBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     enabledBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     errorBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     disabledBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //     focusedErrorBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide.none,
                                                //       borderRadius: BorderRadius.circular(textRadius),
                                                //     ),
                                                //   ),
                                                // ),
                                                ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            OtpController.instance.isLoading ==
                                                    false
                                                ? Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        print(this.phone);
                                                        if (this
                                                            .phone
                                                            .isEmpty) {
                                                          Get.showSnackbar(
                                                              GetSnackBar(
                                                            title:
                                                                "Numero de telephone",
                                                            message:
                                                                "Ce numero de telephone n'est pas valide !",
                                                            duration: Duration(
                                                                seconds: 5),
                                                          ));
                                                        } else {
                                                          await OtpController
                                                              .instance
                                                              .verifyPhone(
                                                                  this.phone);
                                                        }
                                                      },
                                                      child: Container(
                                                        width: Get.width * 0.4,
                                                        height: 45,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Continuer',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: boldLargeTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        primaryColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () async {},
                                                      child: Container(
                                                        width: 120,
                                                        height: 45,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5.0),
                                                          child: SizedBox(
                                                              width: 25,
                                                              height: 25,
                                                              child:
                                                                  CircleAvatar(
                                                                      backgroundColor:
                                                                          primaryColor,
                                                                      radius:
                                                                          10,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                      ))),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "En cliquant sur Continuer vous acceptez sans reserve nos",
                                                style: smallMediumTextStyle
                                                    .copyWith(
                                                        color: Colors.white)),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      const TermCondition());
                                                },
                                                child: Text(
                                                  "Termes et conditions",
                                                  style: smallBoldTextStyle
                                                      .copyWith(
                                                    color: Colors.yellow,
                                                  ),
                                                ))
                                          ],
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          height: 150,
                          left: 5,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
