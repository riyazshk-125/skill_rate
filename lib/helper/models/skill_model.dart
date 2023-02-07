class SkillModel {
  int? id;
  String? skillCategoryId;
  String? name;
  GetSkillCategoryName? getSkillCategoryName;

  SkillModel(
      {this.id, this.skillCategoryId, this.name, this.getSkillCategoryName});

  SkillModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillCategoryId = json['skill_category_id'];
    name = json['name'];
    getSkillCategoryName = json['get_skill_category_name'] != null
        ? GetSkillCategoryName.fromJson(json['get_skill_category_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['skill_category_id'] = skillCategoryId;
    data['name'] = name;
    if (getSkillCategoryName != null) {
      data['get_skill_category_name'] = getSkillCategoryName!.toJson();
    }
    return data;
  }
}

class GetSkillCategoryName {
  int? id;
  String? categoryName;

  GetSkillCategoryName({this.id, this.categoryName});

  GetSkillCategoryName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    return data;
  }
}
