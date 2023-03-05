import 'my_skills_model.dart';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  String? password;
  String? profileUrl;
  String? lastLogin;
  String? token;
  List<MySkillsModel>? userSkills;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.profileUrl,
    this.lastLogin,
    this.mobile,
    this.userSkills,
    this.password,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    profileUrl = json['profile_url'];
    lastLogin = json['last_login'];
    if (json['user_skills'] != null) {
      userSkills = <MySkillsModel>[];
      json['user_skills'].forEach((v) {
        userSkills!.add(MySkillsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['profile_url'] = profileUrl;
    data['last_login'] = lastLogin;
    if (userSkills != null) {
      data['user_skills'] = userSkills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
