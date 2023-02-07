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

  Future<LoginResponseModel> login(
      {String? username, String? email, String? password}) async {
    try {
      Map<String, dynamic> body = {
        "username": username ?? "",
        "email": email ?? "",
        "password": password ?? ""
      };
      //Call API
      var response =
          await _apiService.callApi("auth/userLogin", ApiType.POST, body: body);
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return LoginResponseModel();
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return LoginResponseModel();
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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

  Future<LoginResponseModel> checkPhone({String? phone}) async {
    try {
      Map<String, dynamic> body = {"mobile": phone ?? ""};
      //Call API
      var response = await _apiService
          .callApi("auth/userMobileExists", ApiType.POST, body: body);
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return LoginResponseModel();
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return LoginResponseModel();
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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

  Future<LoginResponseModel> register({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? phone,
    String? user_login_type,
  }) async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "username": username ?? "",
        if (email != null) "email": email,
        if (password != null) "password": password,
        if (phone != null) "mobile": phone,
        "user_login_type": user_login_type ?? "1"
      };
      //Call API
      var response = await _apiService
          .callApi("auth/userRegistration", ApiType.POST, body: body);
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return LoginResponseModel();
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return LoginResponseModel();
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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

  Future<UserModel> userProfile() async {
    //Call API
    try {
      var response =
          await _apiService.callApi("users/userProfile", ApiType.GET);
      print(jsonEncode(response.body));
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return UserModel();
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return UserModel();
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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
      Get.log(jsonEncode(response.body));
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return [];
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return [];
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return [];
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return [];
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return [];
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return [];
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return false;
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return false;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return false;
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return false;
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: response.body["message"]);
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
      print(jsonEncode(response.body));
      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return UserModel();
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return UserModel();
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return UserModel();
      } else {
        try {
          return UserModel.fromJson(response.body["data"][0]);
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

      if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Server Error");
        return SkillDetailModel();
      } else if (response.statusCode == 400) {
        var keys = response.body["data"].keys;
        Fluttertoast.showToast(msg: response.body["data"]["${keys.first}"][0]);
        return SkillDetailModel();
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Fluttertoast.showToast(msg: response.body["message"]);
        return SkillDetailModel();
      } else {
        /*try {
        return SkillDetailModel.fromJson(response.body["data"][0]);
      } catch (e) {
        print(e);
        return SkillDetailModel();
      }*/
        return SkillDetailModel.fromJson(response.body["data"]);
      }
    } catch (e) {
      Get.log("$e");
      Fluttertoast.showToast(msg: "Something wrong");
      return SkillDetailModel();
    }
  }

/*Future<VerifyPhoneNumberModel> callVerifyPhoneNumberApi(
      String phoneNumber, String? appSignature) async {
    Map<String, dynamic> body = {
      "phone_number": phoneNumber,
      "app_signature": appSignature
    };
    var response = await _apiService
        .callApi("verify-phone-number", ApiType.POST, null, body: body);

    Get.log("callVerifyPhoneNumberApi : ${jsonEncode(response.body)}");
    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: response.body["errors"].toString());

      return VerifyPhoneNumberModel();
    } else {
      return VerifyPhoneNumberModel.fromJson(
          jsonDecode(jsonEncode(response.body)));
    }
  }



  Future<bool> callProfileRegistrationApi(Map<String, dynamic> body) async {
    var userToken = await prefs.getUserToken();

    var response = await _apiService
        .callApi("profile-registration", ApiType.POST, userToken, body: body);

    Get.log(
        "callProfileRegistrationApi : ${response.statusCode}: ${jsonEncode(response.body)}");
    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: response.body["errors"].toString());

      return false;
    } else {
      if (!response.body["status"]) {
        Fluttertoast.showToast(msg: response.body["msg"]);
      }
      return response.body["status"];
    }
  }

  Future<List<InterestModel>> callGetInterestsApi() async {
    var userToken = await prefs.getUserToken();

    var response =
        await _apiService.callApi("get-interest", ApiType.GET, userToken);

    Get.log(
        "callGetInterestsApi : ${response.statusCode}: ${jsonEncode(response.body)}");
    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: response.body["errors"].toString());

      return [];
    } else {
      List<dynamic> tempDynamicList = List<dynamic>.from(response.body);
      List<InterestModel> list = [];
      for (var item in tempDynamicList) {
        list.add(InterestModel.fromJson(item));
      }
      return list;
    }
  }

  */
}
