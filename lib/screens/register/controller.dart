import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skill_rate/screens/main/main.dart';

import '../../main.dart';

class RegisterController extends GetxController {
  bool showPassword = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
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
    String insertedId = await apiHolder.register(
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        user_login_type: "1");
    if (insertedId.isNotEmpty) {
      Get.offAll(() => MainScreen());
    }
    print("All right");
  }

  void googleLogin(BuildContext context) async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null && googleSignInAccount.email.isNotEmpty) {
      // Get.log(googleSignInAccount.toString());
      String insertedId = await apiHolder.register(
        firstName: googleSignInAccount.displayName?.split(" ").first,
        lastName: googleSignInAccount.displayName?.split(" ").last,
        email: googleSignInAccount.email,
        user_login_type: "2",
      );
      if (insertedId.isNotEmpty) {
        Get.offAll(() => MainScreen());
      }
    }
  }

  void facebookLogin(BuildContext context) async {
    LoginResult loginResult = await FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.dialogOnly);
    if (loginResult.status == LoginStatus.success) {}
  }
}
