class TempUsersListModel {
  String? name;
  String? message;
  String? date;
  int? unreadCount;

  TempUsersListModel({this.name, this.message, this.date, this.unreadCount});

  TempUsersListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    date = json['date'];
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['message'] = message;
    data['date'] = date;
    data['unread_count'] = unreadCount;
    return data;
  }
}
