import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseHelper {
  late FirebaseAuth auth;

  FirebaseHelper() {
    auth = FirebaseAuth.instance;
  }
  Future<void> verifyNumber(String mobile,
      {required void Function(String, int?) codeSent,
      int? resendingToken}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+91$mobile',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: codeSent,
        forceResendingToken: resendingToken,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on Exception catch (exp, e) {
      Get.log(exp.toString());
    }
  }

  Future<UserCredential> verifyOTP(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    return await auth.signInWithCredential(credential);
  }
}
