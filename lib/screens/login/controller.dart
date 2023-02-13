import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skill_rate/helper/validation_helper.dart';
import 'package:skill_rate/main.dart';
import 'package:skill_rate/screens/main/main.dart';
import 'package:skill_rate/screens/otp_screen/main.dart';

import '../../helper/models/login_response.dart';

class LoginController extends GetxController {
  bool showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  bool isLoading = false;
  bool isGLoading = false;

  bool loginWithPassword = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void togglePassword() {
    showPassword = !showPassword;
    update();
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
    FacebookAuth.instance.login(loginBehavior: LoginBehavior.dialogOnly);
  }

  void login(BuildContext context) async {
    String? emailError = Validator.validateEmail(emailController.text.trim());
    if (emailError != null) {
      Fluttertoast.showToast(msg: emailError);
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter password");
      return;
    }

    isLoading = true;
    update();
    LoginResponseModel loginResponse = await apiHolder.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    isLoading = false;
    update();
    // print(jsonEncode(loginResponse));
    if (loginResponse.token != null) {
      await prefs.setUserToken(loginResponse.token ?? "");
      print(await prefs.getUserToken());
      Get.offAll(() => MainScreen());
    }
  }

  Future<void> sendOTP(BuildContext context) async {
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
  }
}
