class Profile {
  String? image;
  String? name;
  String? weight;
  String? height;
  String? age;
  String? imt;
  String? pal;
  String? bmr;
  String? kaloriPembakaran;
  String? kiloPembakaran;
  bool? isMan;

  Profile({
    this.image,
    this.name,
    this.weight,
    this.height,
    this.age,
    this.imt,
    this.pal,
    this.bmr,
    this.isMan,
    this.kaloriPembakaran,
    this.kiloPembakaran,
  });

  Profile.fromJson(Map<dynamic, dynamic> json) {
    image = json['image'];
    name = json['name'];
    weight = json['weight'];
    height = json['height'];
    age = json['age'];
    imt = json['IMT'];
    isMan = json['gender'];
    pal = json['PAL'];
    bmr = json['BMR'];
    kaloriPembakaran = json['kalori pembakaran'];
    kiloPembakaran = json['kilo pembakaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['weight'] = weight;
    data['height'] = height;
    data['age'] = age;
    data['IMT'] = imt;
    data['gender'] = isMan;
    data['PAL'] = pal;
    data['kalori pembakaran'] = kaloriPembakaran;
    data['kilo pembakaran'] = kiloPembakaran;
    data['BMR'] = bmr;
    return data;
  }
}
