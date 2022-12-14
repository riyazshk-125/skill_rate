import 'package:fluttertoast/fluttertoast.dart';

class Validator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Enter Email";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Enter valid Email";
    } else {
      return null;
    }
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return "Enter Name";
    } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value)) {
      return "Enter valid Name";
    } else {
      return null;
    }
  }

  static String? validatePin(String value) {
    if (value.isEmpty) {
      return "Enter Pincode";
    } else if (value.trim().length != 6) {
      return "Enter valid Pincode";
    } else {
      return null;
    }
  }

  static bool validateImage(String value) {
    if (value.isEmpty) {
      Fluttertoast.showToast(msg: "Select Image");
      return false;
    } else {
      return true;
    }
  }

  static String? validateText(String value) {
    if (value.isEmpty) {
      return "Field Required";
    } else {
      return null;
    }
  }

  static String? validatePhone(String value, bool optional) {
    if (optional) {
      if (value.isEmpty) {
        return null;
      } else {
        if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
          return "Enter valid phone";
        } else {
          return null;
        }
      }
    } else {
      if (value.isEmpty) {
        return "Enter phone";
      } else {
        if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
          return "Enter valid phone";
        } else {
          return null;
        }
      }
    }
  }
}
