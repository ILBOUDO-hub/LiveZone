import 'package:eventpro/controllers/phone_auth_controller.dart';
import 'package:eventpro/ui/register/verify_otp_screen.dart';
import 'package:eventpro/utils/slide_route.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/dimens.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Layer extends StatelessWidget {
  String phone = "";
  TextEditingController controller = TextEditingController();
  Layer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 350,
      padding: EdgeInsets.only(left: 25, top: 20,bottom: 20,right: 20),
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
        height: 300,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Obx(()=>
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: Text(
                  'Votre numero de téléphone',
                  style: mediumLargeTextStylewhite.copyWith(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                height: 50,
                child: TextFormField(
                  style: normalLargeTextStyle,
                  controller: controller,
                  onChanged: (val) {
                    //  print(val.completeNumber);
                    this.phone = val;
                  print(this.phone);
                  },
                  decoration: InputDecoration(

                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Container(
                      // width: 50,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color :Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(textRadius),bottomLeft: Radius.circular(textRadius))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('icons/flags/svg/bf.svg', package: 'country_icons',width:  Get.width*0.075,height: 25,),
                          Text("+226",style: mediumLargeTextStyle,)
                        ],
                      ),
                    ),
                    hintStyle: normalLargeTextStyle,
                    errorStyle: errorTextStyle.copyWith(color: Colors.red),
                    contentPadding: const EdgeInsets.all(0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(textRadius),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(textRadius),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(textRadius),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(textRadius),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(textRadius),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              OtpController.instance.isLoading == false ? Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    print("+226$phone");
                    if(phone.length!=8){
                      Get.showSnackbar(GetSnackBar(title: "Numero de telephone",message: "Ce numero de telephone n'est pas valide !",duration: Duration(seconds: 5),));
                    }
                    // await OtpController.instance.verifyPhone("+226$phone");
                      },
                  child: Container(
                    width: 120,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Continuer',
      
                        style: mediumLargeTextStylewhite,
                      ),
                    ),
                  ),
                ),
              ):
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async{
                      },
                  child: Container(
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
