import 'package:fluttertoast/fluttertoast.dart';

import '../models/login_response.dart';
import '../models/skill_model.dart';
import 'api_service.dart';

class ApiHolder {
  late ApiService _apiService;

  ApiHolder() {
    _apiService = ApiService();
  }

  Future<LoginResponseModel> login(
      {String? username, String? email, String? password}) async {
    Map<String, dynamic> body = {
      "username": username ?? "",
      "email": email ?? "",
      "password": password ?? ""
    };
    //Call API
    if (false) {
      // Fluttertoast.showToast(msg: response.body["message"].toString());
      Fluttertoast.showToast(msg: "Invalid Credentials");
      return LoginResponseModel();
    } else {
      return LoginResponseModel.fromJson({
        "email": "mehulkhatiwala@gmail.com",
        "token":
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGQ5MGJhODgxYWNjMjliZTdmZTFiZGRlZGE4NWFhM2E5Y2EyYmZlNDQwNjhhNjMyMzBjY2VmMTkyNWQwOTcyNmMwYmFlMzYzNDMzNTRkNzAiLCJpYXQiOjE2NzA5NDgyMTguMjY4NTUxLCJuYmYiOjE2NzA5NDgyMTguMjY4NTYyLCJleHAiOjE3MDI0ODQyMTguMDM0MjgzLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.lDLadvrfme88ysx789VSON2tsAoOYj-kbHgayft2fAdsMBSdRX2dKTLhb8nWHgwuq5m1gVIYH2k6CPN49vJsnd0n-HwIJUKF5RRtU0IgaghZYEpBAVnt2QLLgJtlogvTmMPPxQWVKDMbk-MUvlDSNyx14zMpKekqgoQMhecZK0DVvc3sFWQhmFfigSJ15NcN3t2ZHl1uZduKQQo57c2FOJ7Bw6NOdULl9FaglB7yQNzOo6xfVHsXav5piAJ349hxUyRNWwlYk6c3p6SR0fSPmpb2wY0sVgJTzN00Ur93nhcbR3hsPfbi7t3XhTwrKbVLxyxmiVe8DratnFctzAOTjc9qJdny9TkrOzUS2zu2xwehOY4xc4DPPXb5j5iBiqO_vLJGj4vFHVdHCMqxHpBBFztpZ-cWDsY-Jzwx4MbL4c9tScwsgORQtv8w2ULN2t7H_QhIm6FMRN-SCfCsW-FTeok527Tfrw0MukmZ_QrwSkdzIAF1I1YzUejI4FfrhSriZJ_u1EbUT31glFHHmka-Ob02mV5-zv2VFT-jV8rwKuyVxMgrQRC6BW2HojRAx_ff03WQhUvXqX3PpoGFnUiPmwmDEqQY_Had5LD29_VXaUrjiv0K8w1uNY72QdQVfjePo1ot0iMvNe5EPD6Ok7DcnnFQEFMJkNCL5-9607z409c",
        "last_login": "2022-12-13 21:46:57"
      });
    }
  }

  Future<String> register({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? user_login_type,
  }) async {
    Map<String, dynamic> body = {
      "first_name": firstName ?? "",
      "last_name": lastName ?? "",
      "username": username ?? "",
      "email": email ?? "",
      "password": password ?? "",
      "user_login_type": user_login_type ?? "1"
    };
    //Call API
    if (false) {
      // Fluttertoast.showToast(msg: response.body["message"].toString());
      Fluttertoast.showToast(msg: "Invalid Credentials");
      return "";
    } else {
      var response = {"inserted_id": 17};
      return "${response["inserted_id"]}";
    }
  }

  Future<List<SkillModel>> callGetInterestsApi() async {
    if (false) {
      // Fluttertoast.showToast(msg: response.body["errors"].toString());
      Fluttertoast.showToast(msg: "Unauthenticated requests");
      return [];
    } else {
      List<dynamic> tempDynamicList = List<dynamic>.from([
        {
          "id": 2,
          "skill_category_id": 7,
          "name": "Python",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 3,
          "skill_category_id": 7,
          "name": "PHP",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 4,
          "skill_category_id": 7,
          "name": "jQuery",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 5,
          "skill_category_id": 7,
          "name": "Javascript",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 6,
          "skill_category_id": 7,
          "name": "ES6",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 7,
          "skill_category_id": 7,
          "name": "HTML5",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 8,
          "skill_category_id": 7,
          "name": "React",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 9,
          "skill_category_id": 7,
          "name": "React Native",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 11,
          "skill_category_id": 7,
          "name": "Laravel",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 12,
          "skill_category_id": 7,
          "name": "Angular JS",
          "get_skill_category_name": {"id": 7, "category_name": "Coding"}
        },
        {
          "id": 13,
          "skill_category_id": 8,
          "name": "Integrity",
          "get_skill_category_name": {"id": 8, "category_name": "Value"}
        },
        {
          "id": 14,
          "skill_category_id": 8,
          "name": "Innovation",
          "get_skill_category_name": {"id": 8, "category_name": "Value"}
        }
      ]);
      List<SkillModel> list = [];
      for (var item in tempDynamicList) {
        list.add(SkillModel.fromJson(item));
      }
      return list;
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
