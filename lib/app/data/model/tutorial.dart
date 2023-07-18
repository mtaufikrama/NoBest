class TutorialModel {
  bool? homepage;
  bool? profile;
  bool? listFood;
  bool? generateFood;
  bool? inputProfile;
  TutorialModel({
    this.generateFood,
    this.homepage,
    this.listFood,
    this.profile,
    this.inputProfile,
  });

  TutorialModel.fromJson(Map<dynamic, dynamic> json) {
    generateFood = json['generate_food'];
    homepage = json['homepage'];
    listFood = json['list_food'];
    profile = json['profile'];
    inputProfile = json['input_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile'] = profile;
    data['generate_food'] = generateFood;
    data['homepage'] = homepage;
    data['list_food'] = listFood;
    data['input_profile'] = inputProfile;
    return data;
  }
}
