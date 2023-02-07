import 'skill_model.dart';

class SkillDetailModel {
  int? id;
  String? userId;
  String? skillId;
  String? avgRating;
  String? createdAt;
  String? updatedAt;
  UserInformation? userInformation;
  SkillModel? userSkillsName;
  UserSkillRating? userSkillRating;

  SkillDetailModel(
      {this.id,
      this.userId,
      this.skillId,
      this.avgRating,
      this.createdAt,
      this.updatedAt,
      this.userInformation,
      this.userSkillsName,
      this.userSkillRating});

  SkillDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    skillId = json['skill_id'];
    avgRating = json['avg_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userInformation = json['user_information'] != null
        ? UserInformation.fromJson(json['user_information'])
        : null;
    userSkillsName = json['user_skills_name'] != null
        ? SkillModel.fromJson(json['user_skills_name'])
        : null;
    userSkillRating = json['user_skill_rating'] != null
        ? UserSkillRating.fromJson(json['user_skill_rating'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['skill_id'] = skillId;
    data['avg_rating'] = avgRating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (userInformation != null) {
      data['user_information'] = userInformation!.toJson();
    }
    if (userSkillsName != null) {
      data['user_skills_name'] = userSkillsName!.toJson();
    }
    if (userSkillRating != null) {
      data['user_skill_rating'] = userSkillRating!.toJson();
    }
    return data;
  }
}

class UserInformation {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;

  UserInformation(
      {this.id, this.firstName, this.lastName, this.username, this.email});

  UserInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}

class UserSkillRating {
  int? currentPage;
  List<Data>? data;

  UserSkillRating({this.currentPage, this.data});

  UserSkillRating.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userSkillId;
  String? reviewedBy;
  String? rating;
  String? review;
  String? isApproved;
  String? approvedBy;
  String? createdAt;
  String? updatedAt;
  UserInformation? reviewedByInfo;
  UserInformation? approvedByInfo;

  Data(
      {this.id,
      this.userSkillId,
      this.reviewedBy,
      this.rating,
      this.review,
      this.isApproved,
      this.approvedBy,
      this.createdAt,
      this.updatedAt,
      this.reviewedByInfo,
      this.approvedByInfo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userSkillId = json['user_skill_id'];
    reviewedBy = json['reviewed_by'];
    rating = json['rating'];
    review = json['review'];
    isApproved = json['is_approved'];
    approvedBy = json['approved_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reviewedByInfo = json['reviewed_by_info'] != null
        ? UserInformation.fromJson(json['reviewed_by_info'])
        : null;
    approvedByInfo = json['approved_by_info'] != null
        ? UserInformation.fromJson(json['approved_by_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_skill_id'] = userSkillId;
    data['reviewed_by'] = reviewedBy;
    data['rating'] = rating;
    data['review'] = review;
    data['is_approved'] = isApproved;
    data['approved_by'] = approvedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (reviewedByInfo != null) {
      data['reviewed_by_info'] = reviewedByInfo!.toJson();
    }
    if (approvedByInfo != null) {
      data['approved_by_info'] = approvedByInfo!.toJson();
    }
    return data;
  }
}
