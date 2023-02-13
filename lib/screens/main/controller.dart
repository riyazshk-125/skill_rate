import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

import '../../helper/models/user_model.dart';

class MainController extends GetxController {
  bool showPassword = false;
  TextEditingController searchController = TextEditingController();
  List<UserModel> users = [];
  List<UserModel> searchedUsers = [];
  List<Color> colors = [
    Color(0xFF95CC81),
    Color(0xFF166FF6),
    Color(0xFFFD5A66),
    Color(0xFFFFD064),
    Color(0xFF5055A0),
  ];
  bool isLoading = false;
  int page = 1;
  ScrollController scrollController = ScrollController();
  int totalItem = 0;

  @override
  void onInit() {
    getMyProfile();
    scrollController.addListener(_onScrollData);
    getApiData(true);

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void textChange(text) {
    if (text.isEmpty) {
      searchedUsers = users;
      update();
    } else {
      var searched = users
          .where((e) =>
              (e.firstName != null &&
                  e.firstName!.toLowerCase().contains(text)) ||
              (e.lastName != null &&
                  e.lastName!.toLowerCase().contains(text)) ||
              (e.username != null &&
                  e.username!.toLowerCase().contains(text)) ||
              (e.email != null && e.email!.toLowerCase().contains(text)) ||
              (e.mobile != null && e.mobile!.toLowerCase().contains(text)))
          .toList();
      searchedUsers = searched;
      update();
    }
  }

  void getApiData(bool isFirst) async {
    if (isFirst) {
      isLoading = true;
      update();
    }
    /*UserModel myProfile = await apiHolder.userProfile();
    myProfile.isCurrent = true;
    users.add(myProfile);

    update();*/

    List<UserModel> otherUsers =
        await apiHolder.callOthersUser(page, (totalItem) {
      this.totalItem = totalItem;
    });
    users.addAll(otherUsers);
    searchedUsers = users;
    isLoading = false;
    update();
  }

  void _onScrollData() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (users.length < (totalItem) && !isLoading) {
        page++;
        getApiData(false);
      }
    }
  }

  void getMyProfile() async {
    UserModel myProfile = await apiHolder.userProfile();
    await prefs.setUserModel(myProfile);
  }
}
