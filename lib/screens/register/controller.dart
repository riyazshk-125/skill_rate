import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skill_rate/helper/models/login_response.dart';
import 'package:skill_rate/helper/models/user_model.dart';
import 'package:skill_rate/screens/main/main.dart';

import '../../helper/validation_helper.dart';
import '../../main.dart';
import '../otp_screen/main.dart';

class RegisterController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailPhoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  bool isLoading = false;
  bool isGLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (emailPhoneController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter Email or phone");
      return;
    }
    if (emailPhoneController.text.trim().startsWith("0") ||
        emailPhoneController.text.trim().startsWith("+91")) {
      Fluttertoast.showToast(msg: "Enter phone number without code");
      return;
    }
    String? phoneError =
        Validator.validatePhone(emailPhoneController.text.trim(), false);
    String? emailError =
        Validator.validateEmail(emailPhoneController.text.trim());

    if (emailError != null && phoneError != null) {
      Fluttertoast.showToast(msg: "Enter field should be email or phone");
      return;
    }

    isLoading = true;
    update();

    UserModel userModel = UserModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      username: usernameController.text.trim(),
      email: emailPhoneController.text.trim(),
      mobile: emailPhoneController.text.trim(),
    );

    //check if already registered
    isLoading = true;
    update();
    bool? isExist = await apiHolder.checkIfExist(
        phoneEmail: emailPhoneController.text.trim(),
        userName: userModel.username);

    if (isExist != null && !isExist) {
      if (phoneError != null) {
        userModel.mobile = null;
        //Should be email

        String receiveOTP = await apiHolder.sendEmailOTP(
            firstName: userModel.firstName,
            lastName: userModel.lastName,
            email: userModel.email);
        isLoading = false;
        update();
        if (receiveOTP.isNotEmpty) {
          Get.to(() => OTPScreen(
                userModel: userModel,
                receiveOTP: receiveOTP,
                verificationId: "",
                resendToken: 0,
              ));
        }
      } else {
        //Should be phone
        userModel.email = null;

        firebaseHelper.verifyNumber(emailPhoneController.text.trim(),
            codeSent: (verificationId, resendToken) {
          isLoading = false;
          update();
          Get.to(() => OTPScreen(
                resendToken: resendToken,
                verificationId: verificationId,
                userModel: userModel,
              ));
        });
      }
    } else {
      isLoading = false;
      update();
    }

    /*LoginResponseModel loginResponse = await apiHolder.register(
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        user_login_type: "1");
    isLoading = false;
    update();
    if (loginResponse.token != null) {
      await prefs.setUserToken(loginResponse.token ?? "");
      print(await prefs.getUserToken());
      Get.offAll(() => MainScreen());
    }*/
  }

  void googleLogin(BuildContext context) async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null && googleSignInAccount.email.isNotEmpty) {
      // Get.log(googleSignInAccount.toString());
      isGLoading = true;
      update();
      LoginResponseModel loginResponse = await apiHolder.register(
        firstName: googleSignInAccount.displayName?.split(" ").first,
        lastName: googleSignInAccount.displayName?.split(" ").last,
        email: googleSignInAccount.email,
        user_login_type: "2",
        id: googleSignInAccount.id,
      );
      isGLoading = false;
      update();
      if (loginResponse.token != null) {
        await prefs.setUserToken(loginResponse.token ?? "");
        print(await prefs.getUserToken());
        Get.offAll(() => MainScreen());
      }
    }
  }

  void facebookLogin(BuildContext context) async {
    LoginResult loginResult = await FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.dialogOnly);
    if (loginResult.status == LoginStatus.success) {}
  }

/*Future<void> sendOTP(BuildContext context) async {
    String? phoneError =
        Validator.validatePhone(phoneController.text.trim(), false);
    if (phoneError != null) {
      Fluttertoast.showToast(msg: phoneError);
      return;
    }

    isLoading = true;
    update();
    LoginResponseModel loginResponse =
        await apiHolder.checkPhone(phone: phoneController.text.trim());

    firebaseHelper.verifyNumber(phoneController.text.trim(),
        codeSent: (verificationId, resendToken) {
      isLoading = false;
      update();
      Get.to(() => OTPScreen(
            loginResponseModel: loginResponse,
            resendToken: resendToken,
            verificationId: verificationId,
            phone: phoneController.text.trim(),
          ));
    });
  }*/
}
