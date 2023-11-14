import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/ui/register/verify_otp_screen.dart';
import 'package:eventpro/values/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
static OtpController instance = Get.find();
  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;
  var confirmationResult =  null;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  Future verifyPhone(String phone) async {
    isLoading.value = true;
    try{
      if(GetPlatform.isWeb){
       confirmationResult =await MyAuthController.auth.signInWithPhoneNumber(phone);
 isLoading.value = false;
 Get.to(()=>VerifyOTPScreen(phone: phone,));
            authStatus.value = "PhoneVerified";
      }else {
                  await MyAuthController.auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential)async{
          if(GetPlatform.isAndroid){
              // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          await MyAuthController.auth.signInWithCredential(authCredential);
           isLoading.value = false;
            authStatus.value = "PhoneVerified";
          }else{
            if (MyAuthController.auth.currentUser != null) {
            isLoading.value = false;
            authStatus.value = "PhoneVerified";
          }
          }
        },
        verificationFailed: (authException) {
          isLoading.value = false;
          print(authException);
         // Get.showSnackbar(const GetSnackBar(title: "Verification de numero de telephone",message: "Verification impossible veuillez verifier votre connection puis reesayer",duration: Duration(seconds: 5),));
          // Get.snackbar("sms code info", "otp code hasn't been sent!!${authException.message} ");
        },
        codeSent: (String id,  forceResent) {
          isLoading.value = false;
          this.verId = id;
          authStatus.value = "codeSend";
          Get.to(()=>VerifyOTPScreen(phone: phone,));
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
          isLoading.value = false;
          if(authStatus.value != "PhoneVerified"){
          Get.showSnackbar(const GetSnackBar(title: "Verification de numero de telephone",message: "Verification impossible veuillez verifier votre connection puis reesayer",duration: Duration(seconds: 5),));

          }
        });
      
      }

    }catch(e){
          isLoading.value = false;
          print(e.toString());
          Get.showSnackbar(const GetSnackBar(title: "Verification de numero de telephone",message: "Verification impossible veuillez verifier votre connection puis reesayer",duration: Duration(seconds: 5),));
    }

  }


  /////////
  otpVerify(String otp,Map<String,dynamic> data) async {
    isLoading.value = true;
    try {
      if(!GetPlatform.isWeb){
        UserCredential userCredential = await MyAuthController.auth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: this.verId, smsCode: otp)
      );
       isLoading.value = false;
            authStatus.value = "PhoneVerified";
      if (userCredential.user != null) {
        isLoading.value = false;
      }
      }else{
                UserCredential userCredential = await confirmationResult!.confirm(otp);
                 isLoading.value = false;
            authStatus.value = "PhoneVerified";
      if (userCredential.user != null) {
        isLoading.value = false;
      }
      }
      
    }catch (e) {
        isLoading.value = false;
        print(e);
        Get.showSnackbar(const GetSnackBar(title: "Verification de numero de telephone",message: "Verification impossible veuillez verifier votre connection puis reesayer",duration: Duration(seconds: 5),));
    }
  }
}
