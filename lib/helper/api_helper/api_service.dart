import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiService extends GetConnect {
  final String _BASE_URL = "https://thedooapp.in/api/";

  Future<Response<dynamic>> callApi(
      String endPoint, ApiType apiType, String? userToken,
      {dynamic body}) async {
    Get.log("--------------------");
    Get.log(
        "URL : $_BASE_URL$endPoint , body : ${body != null ? jsonEncode(body) : 'NA'}");
    if (await InternetConnectionChecker().hasConnection) {
      switch (apiType) {
        case ApiType.GET:
          Response<dynamic> responseJson;
          try {
            final response = await get(
              "$_BASE_URL$endPoint",
              headers: {
                'content-type': 'application/json',
                if (userToken != null && userToken.isNotEmpty)
                  'Authorization': 'Bearer $userToken'
              },
            );
            if (response.body != null) {
              return response;
            } else {
              return callApi(endPoint, apiType, userToken, body: body);
            }
          } on Exception {
            return callApi(endPoint, apiType, userToken, body: body);
            // throw FetchDataException('No Internet connection');
          }

        case ApiType.POST:
          Response<dynamic> responseJson;
          try {
            final response = await post(
              "$_BASE_URL$endPoint",
              body ?? {},
              headers: {
                'content-type': 'application/json',
                if (userToken != null && userToken.isNotEmpty)
                  'Authorization': 'Bearer $userToken'
              },
            );
            if (response.body != null) {
              return response;
            } else {
              return callApi(endPoint, apiType, userToken, body: body);
            }
          } on Exception {
            return callApi(endPoint, apiType, userToken, body: body);
            ;
            // throw FetchDataException('No Internet connection');
          }
      }
    } else {
      // await Get.to<bool>(() => NetworkErrorPagePage());
      return await callApi(endPoint, apiType, userToken);
    }
  }

  /*Future<Response<dynamic>> callOrderResponseApi(
      String amount, String name) async {
    String credentials =
        "${AppMethods.PAYMENT_MAP["key"]}:${AppMethods.PAYMENT_MAP["secret"]}";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    Get.log("Encoded : $encoded");
    if (await InternetConnectionChecker().hasConnection) {
      Response<dynamic> responseJson;
      try {
        final response = await post(
          "https://api.razorpay.com/v1/orders",
          {
            "amount": amount,
            "currency": "INR",
            "receipt": name,
            "partial_payment": false,
            "first_payment_min_amount": 100,
          },
          headers: {
            'Content-type': "application/json",
            'Authorization': 'Basic $encoded'
          },
        );
        if (response.body != null) {
          return response;
        } else {
          return callOrderResponseApi(amount, name);
        }
      } on Exception {
        return callOrderResponseApi(amount, name);
        // throw FetchDataException('No Internet connection');
      }
    } else {
      // await Get.to<bool>(() => NetworkErrorPagePage());
      return callOrderResponseApi(amount, name);
    }
  }*/

  Future<String> sendFile(
    String endPoint,
    String? userToken,
    File file,
    String value,
    String type,
  ) async {
    if (await InternetConnectionChecker().hasConnection) {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken'
      };
      var uri = Uri.parse("$_BASE_URL$endPoint");
      var request = http.MultipartRequest("POST", uri);
      request.fields['name'] = value;
      request.fields['type'] = type;
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        file.path,
      ));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseStr = await response.stream.bytesToString();
      Get.log("----- $responseStr");
      return responseStr;
    } else {
      // await Get.to<bool>(() => NetworkErrorPagePage());
      return sendFile(
        endPoint,
        userToken,
        file,
        value,
        type,
      );
    }
  }

  /*Future<String> sendDocumentFileOrderPlaceFile(
    String endPoint,
    String? userToken,
    File file,
    Map<String, dynamic> map,
  ) async {
    if (await InternetConnectionChecker().hasConnection) {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken'
      };
      var uri = Uri.parse("$_BASE_URL$endPoint");
      var request = http.MultipartRequest("POST", uri);
      request.fields['form_id'] = map["form_id"].toString();
      request.fields['payable_amount'] = map["payable_amount"].toString();
      request.fields['coupon_discount'] = map["coupon_discount"].toString();
      request.fields['one_time_charge'] = map["one_time_charge"].toString();
      request.fields['payment_response'] = map["payment_response"].toString();
      if (AppMethods.lastFormUsername.trim().isNotEmpty) {
        request.fields['username'] = AppMethods.lastFormUsername.trim();
      }
      if (AppMethods.lastFormPassword.trim().isNotEmpty) {
        request.fields['password'] = AppMethods.lastFormPassword.trim();
      }
      request.fields['type'] = map["type"].toString();
      request.fields['payable_amount_type'] =
          map["payable_amount_type"].toString();
      if (file.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'other_document',
          file.path,
        ));
      }

      Get.log(jsonEncode(request.fields));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseStr = await response.stream.bytesToString();
      Get.log("----- $responseStr");
      return responseStr;
    } else {
      // await Get.to<bool>(() => NetworkErrorPagePage());
      return sendDocumentFileOrderPlaceFile(endPoint, userToken, file, map);
    }
  }*/

/*dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        return response;
    }
  }*/
}

enum ApiType {
  GET,
  POST,
}
