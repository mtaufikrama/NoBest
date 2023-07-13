import 'package:nobes/app/data/model/profile.dart';
import 'package:nobes/app/data/model/usda_search.dart';

class Daily {
  Profile? profile;
  List<Foods>? foods;

  Daily({
    this.profile,
    this.foods,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    profile = Profile.fromJson(json['profile']);
    foods = (json['foods'] as List).map((e) => Foods.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile'] = profile;
    data['foods'] = foods;
    return data;
  }
}
