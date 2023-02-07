import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skill_rate/helper/models/login_response.dart';
import 'package:skill_rate/screens/main/main.dart';

import '../../helper/validation_helper.dart';
import '../../main.dart';
import '../otp_screen/main.dart';

class RegisterController extends GetxController {
  bool showPassword = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Fluttertoast.showToast(msg: "Password and confirm password should same");
      return;
    }
    isLoading = true;
    update();
    LoginResponseModel loginResponse = await apiHolder.register(
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
    }
    print("All right");
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
