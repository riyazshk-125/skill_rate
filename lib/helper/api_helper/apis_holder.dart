import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/login_response.dart';
import '../models/my_skills_model.dart';
import '../models/skill_detail_model.dart';
import '../models/skill_model.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class ApiHolder {
  late ApiService _apiService;

  ApiHolder() {
    _apiService = ApiService();
  }

  Future<LoginResponseModel> login({String? email, String? password}) async {
    try {
      Map<String, dynamic> body = {
        "email_mobile": email ?? "",
        "password": password ?? ""
      };
      //Call API
      var response =
          await _apiService.callApi("auth/userLogin", ApiType.POST, body: body);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return LoginResponseModel();
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        // Fluttertoast.showToast(msg: response.body["message"]);
        return LoginResponseModel();
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return LoginResponseModel();
      } else {
        return LoginResponseModel.fromJson(response.body["data"]);
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return LoginResponseModel();
    }
  }

  Future<bool?> checkIfExist(
      {String? phoneEmail, bool isForLogin = false, String? userName}) async {
    try {
      Map<String, dynamic> body = {
        "email_mobile": phoneEmail ?? "",
        if (userName != null) "username": userName
      };
      //Call API
      var response = await _apiService
          .callApi("auth/userAccountExists", ApiType.POST, body: body);
      if (isForLogin) {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: response.body["message"]);
        }
      } else {
        if (response.statusCode == 400) {
          Fluttertoast.showToast(msg: response.body["message"]);
        }
      }
      return response.statusCode != 200;
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
    }
  }

  Future<LoginResponseModel> register({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? phone,
    String? user_login_type,
    String? id,
  }) async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "username": username ?? "",
        if (email != null) "email": email,
        if (password != null) "password": password,
        if (phone != null) "mobile": phone,
        if (id != null) "id": id,
        "user_login_type": user_login_type ?? "1"
      };
      //Call API
      var response = await _apiService
          .callApi("auth/userRegistration", ApiType.POST, body: body);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return LoginResponseModel();
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return LoginResponseModel();
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return LoginResponseModel();
      } else {
        return LoginResponseModel.fromJson(response.body["data"]);
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return LoginResponseModel();
    }
  }

  Future<String> sendEmailOTP({
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "email": email
      };
      //Call API
      var response = await _apiService.callApi(
          "auth/sendEmailAccountVerificationEmail", ApiType.POST,
          body: body);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "";
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "";
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return "";
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "${response.body["data"]["otp"]}";
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return "";
    }
  }

  Future<String> sendForgetEmailOTP({
    String? email,
  }) async {
    try {
      Map<String, dynamic> body = {"email": email};
      //Call API
      var response = await _apiService
          .callApi("auth/forgetPasswordSendCode", ApiType.POST, body: body);
      Get.log(response.statusCode.toString());
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "";
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "";
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return "";
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "${response.body["data"]["otp"]}";
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return "";
    }
  }

  Future<bool> changePassword({
    String? email,
    String? password,
  }) async {
    try {
      Map<String, dynamic> body = {
        "email_mobile": email ?? "",
        "password": password ?? "",
      };
      //Call API
      var response = await _apiService
          .callApi("auth/forgetPassword", ApiType.POST, body: body);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return false;
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return true;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return false;
    }
  }

  Future<bool> changePasswordLogin({
    String? oldPassword,
    String? password,
  }) async {
    try {
      Map<String, dynamic> body = {
        "old_password": oldPassword,
        "password": password,
        "password_confirmation": password
      };
      //Call API
      var response = await _apiService
          .callApi("users/changePassword", ApiType.POST, body: body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return true;
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return false;
    }
  }

  Future<UserModel> userProfile() async {
    //Call API
    try {
      var response =
          await _apiService.callApi("users/userProfile", ApiType.GET);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return UserModel();
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return UserModel();
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return UserModel();
      } else {
        return UserModel.fromJson(response.body["data"]);
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return UserModel();
    }
  }

  Future<List<UserModel>> callOthersUser(
      int page, void Function(int totalItem) totalCount) async {
    try {
      var response = await _apiService.callApi(
          "users/getOtherUsersList?page=$page", ApiType.GET);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return [];
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return [];
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return [];
      } else {
        totalCount(response.body["data"]["total"]);
        List<dynamic> tempDynamicList =
            List<dynamic>.from(response.body["data"]["data"]);
        List<UserModel> list = [];
        for (var item in tempDynamicList) {
          list.add(UserModel.fromJson(item));
        }
        return list;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return [];
    }
  }

  Future<List<SkillModel>> callSkills() async {
    try {
      var response =
          await _apiService.callApi("auth/getAllSkills", ApiType.GET);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return [];
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return [];
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return [];
      } else {
        List<dynamic> tempDynamicList =
            List<dynamic>.from(response.body["data"]);
        List<SkillModel> list = [];
        for (var item in tempDynamicList) {
          list.add(SkillModel.fromJson(item));
        }
        return list;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return [];
    }
  }

  Future<List<MySkillsModel>> callMySkills() async {
    try {
      var response =
          await _apiService.callApi("users/viewMySkills", ApiType.GET);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return [];
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return [];
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return [];
      } else {
        List<dynamic> tempDynamicList =
            List<dynamic>.from(response.body["data"]);
        List<MySkillsModel> list = [];
        for (var item in tempDynamicList) {
          list.add(MySkillsModel.fromJson(item));
        }
        return list;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return [];
    }
  }

  Future<bool> saveUserSkills(String skills, bool isFirst) async {
    try {
      var body = {"skills": skills};
      //Call API
      var response = await _apiService.callApi(
        isFirst ? "users/addMySkills" : "users/editMySkills",
        ApiType.POST,
        body: body,
      );
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return false;
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return true;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return false;
    }
  }

  Future<bool> addUpdateOtherUserSkills(
    double rating,
    String review,
    int? userSkillId,
  ) async {
    try {
      var body = {
        if (userSkillId != null) "user_skill_id": userSkillId,
        "rating": "$rating",
        if (review.isNotEmpty) "review": review
      };
      Get.log(jsonEncode(body));
      //Call API
      var response = await _apiService.callApi(
        "users/addUpdateUserSkillRating",
        ApiType.POST,
        body: body,
      );
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return false;
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return true;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return false;
    }
  }

  Future<UserModel> otherUserProfile(int? userId) async {
    //Call API
    try {
      var response = await _apiService.callApi(
          "users/getOtherUserProfile/$userId", ApiType.GET);
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return UserModel();
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return UserModel();
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return UserModel();
      } else {
        try {
          return UserModel.fromJson(response.body["data"]);
        } catch (e) {
          return UserModel();
        }
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return UserModel();
    }
  }

  Future<SkillDetailModel> getSkillDetail(String? skillId) async {
    //Call API
    try {
      var response = await _apiService.callApi(
          "users/loadOtherUserSkillData/$skillId", ApiType.GET);

      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return SkillDetailModel();
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return SkillDetailModel();
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return SkillDetailModel();
      } else {
        return SkillDetailModel.fromJson(response.body["data"]);
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return SkillDetailModel();
    }
  }

  Future<String> predefinedPage({
    String? endPoint,
  }) async {
    try {
      Map<String, dynamic> body = {"page_name": endPoint};
      //Call API
      var response = await _apiService
          .callApi("users/viewPreDefinedPages", ApiType.POST, body: body);

      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "";
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return "";
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return "";
      } else {
        return response.body["data"]["code"];
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return "";
    }
  }

  Future<bool> saveOtherUserSkills(String skills, int userId) async {
    try {
      var body = {
        "skills": skills,
        "user_id": userId,
      };
      //Call API
      var response = await _apiService.callApi(
        true ? "users/addOtherUserSkills" : "users/editMySkills",
        ApiType.POST,
        body: body,
      );
      if (response.statusCode == 500 || response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Invalid access");
        return false;
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return true;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return false;
    }
  }

  Future<bool> updateProfile({required UserModel userModel}) async {
    try {
      Map<String, dynamic> body = {
        "username": userModel.username,
        "email": userModel.email,
        "mobile": userModel.mobile
      };
      //Call API
      var response = await _apiService
          .callApi("users/updateUserProfile", ApiType.POST, body: body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return true;
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        return false;
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return false;
    }
  }
}
