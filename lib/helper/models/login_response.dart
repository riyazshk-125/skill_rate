class LoginResponseModel {
  String? email;
  String? token;
  String? lastLogin;

  LoginResponseModel({this.email, this.token, this.lastLogin});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['token'] = token;
    data['last_login'] = lastLogin;
    return data;
  }
}
