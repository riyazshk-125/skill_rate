import 'api_service.dart';

class ApiHolder {
  late ApiService _apiService;

  ApiHolder() {
    _apiService = ApiService();
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
