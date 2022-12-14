import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/date_format_helper.dart';

import '../../helper/temp_model/temp_users_list_model.dart';

class MainController extends GetxController {
  bool showPassword = false;
  TextEditingController searchController = TextEditingController();
  List<TempUsersListModel> users = [];
  List<Color> colors = [
    Color(0xFF95CC81),
    Color(0xFF166FF6),
    Color(0xFFFD5A66),
    Color(0xFFFFD064),
    Color(0xFF5055A0),
  ];

  @override
  void onInit() {
    addUsers();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void textChange(text) {}

  void addUsers() {
    List<dynamic> tempDynamicList = List<dynamic>.from([
      {
        "name": "Arit Patel",
        "message": "Categori",
        "date": "07/12/2022",
        "unread_count": 1
      },
      {
        "name": "Darshan",
        "message": "How is it going?",
        "date": "06/12/2022",
        "unread_count": null
      },
      {
        "name": "Doctor",
        "message": "All right, noted",
        "date": "05/12/2022",
        "unread_count": 2
      },
      {
        "name": "Engineer",
        "message": "How is it going?",
        "date": "04/12/2022",
        "unread_count": null
      },
      {
        "name": "Prashant",
        "message": "How is it going?",
        "date": "03/12/2022",
        "unread_count": null
      }
    ]);
    for (var item in tempDynamicList) {
      users.add(TempUsersListModel.fromJson(item));
    }

    users[0].date =
        DateFormatHelper.convertDateFromDate(DateTime.now(), "dd/MM/yyyy");
  }
}
