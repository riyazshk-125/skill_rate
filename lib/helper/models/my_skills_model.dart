import 'package:skill_rate/helper/models/skill_model.dart';

class MySkillsModel {
  int? id;
  String? userId;
  String? skillId;
  String? avgRating;
  String? createdAt;
  String? updatedAt;
  SkillModel? userSkillsName;

  MySkillsModel(
      {this.id,
      this.userId,
      this.skillId,
      this.avgRating,
      this.createdAt,
      this.updatedAt,
      this.userSkillsName});

  MySkillsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    skillId = json['skill_id'];
    avgRating = json['avg_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userSkillsName = json['user_skills_name'] != null
        ? SkillModel.fromJson(json['user_skills_name'])
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
    if (userSkillsName != null) {
      data['user_skills_name'] = userSkillsName!.toJson();
    }
    return data;
  }
}
