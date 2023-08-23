import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nobes/app/data/model/profile.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/public.dart';

import '../model/tutorial.dart';

class Storages {
  static const profileName = 'profile';
  static const listName = 'list food';
  static const recommendName = 'recommend food';
  static const historyName = 'history';
  static const bahasaName = 'bahasa';
  static const tutorialName = 'tutorial';

  static final boxProfile = Hive.box(profileName);
  static final boxListFood = Hive.box(listName);
  static final boxRecommendFood = Hive.box(recommendName);
  static final boxHistory = Hive.box(historyName);
  static final boxBahasa = Hive.box(bahasaName);
  static final boxTutorial = Hive.box(tutorialName);

  static Future<void> setListFood({required Foods foods}) async {
    await boxListFood.add(foods.toJson());
    Publics.controller.getListFood.value = Storages.getListFood;
    return;
  }

  static Future<void> deleteListFood({required Foods foods}) async {
    final listfood = Storages.getListFood;
    listfood.removeWhere(
      (element) => Foods.fromJson(element).fdcId == foods.fdcId,
    );
    await boxListFood.clear();
    await boxListFood.addAll(listfood);
    Publics.controller.getListFood.value = Storages.getListFood;
    return;
  }

  static List get getListFood {
    List recently = boxListFood.values.toList();
    return recently;
  }

  static Future<void> setTutorial({required TutorialModel tutorial}) async {
    TutorialModel tutor = Storages.getTutorial;
    await boxTutorial.clear();
    await boxTutorial.put(
        'homepage', tutorial.homepage ?? tutor.homepage ?? false);
    await boxTutorial.put(
        'profile', tutorial.profile ?? tutor.profile ?? false);
    await boxTutorial.put(
        'list_food', tutorial.listFood ?? tutor.listFood ?? false);
    await boxTutorial.put(
        'generate_food', tutorial.generateFood ?? tutor.generateFood ?? false);
    await boxTutorial.put(
        'input_profile', tutorial.inputProfile ?? tutor.inputProfile ?? false);
    await boxTutorial.put('finish', tutorial.finish ?? tutor.finish ?? false);
    await boxTutorial.put('search', tutorial.search ?? tutor.search ?? false);
    Publics.controller.getTutorial.value = Storages.getTutorial;
    print(Publics.controller.getTutorial.value.toJson());
    return;
  }

  static TutorialModel get getTutorial =>
      TutorialModel.fromJson(boxTutorial.isNotEmpty ? boxTutorial.toMap() : {});

  static Future<void> setRecommend({required List<Foods> foods}) async {
    await boxRecommendFood.clear();
    String time = Kalkulator.timeNow;
    List<Map<dynamic, dynamic>> listFood =
        foods.map((e) => e.toJson()).toList();
    await boxRecommendFood.put(time, listFood);
    Publics.controller.getRecommend.value = Storages.getRecommend;
    return;
  }

  static Map<dynamic, dynamic> get getRecommend {
    Map<dynamic, dynamic> generate =
        boxRecommendFood.isNotEmpty ? boxRecommendFood.toMap() : {};
    return generate;
  }

  static Future<void> setProfile({
    String? image,
    String? name,
    String? height,
    String? weight,
    String? age,
    bool? isMan,
    String? kaloriPembakaran,
    String? kiloPembakaran,
  }) async {
    Profile profile = Storages.getProfile;
    await boxProfile.clear();
    final String imt = Kalkulator.imt(
      weight: double.parse(weight ?? profile.weight ?? '0'),
      height: double.parse(height ?? profile.height ?? '0'),
    ).toString();
    await boxProfile.put('image', image ?? profile.image);
    await boxProfile.put('name', name ?? profile.name);
    await boxProfile.put('height', height ?? profile.height);
    await boxProfile.put('gender', isMan ?? profile.isMan);
    await boxProfile.put('weight', weight ?? profile.weight);
    await boxProfile.put('age', age ?? profile.age);
    await boxProfile.put('IMT', imt);
    double nilaiKalori = Kalkulator.nilaiKiloPembakaran(
      kategoriIMT: Kalkulator.kategoriIMT(
        imt: double.parse(imt),
        isMan: isMan,
      ),
    );
    String kalori = Kalkulator.kaloriPembakaran(kilo: nilaiKalori).toString();
    String kilo = nilaiKalori.toString();
    if (kaloriPembakaran != null) {
      kilo = Kalkulator.kiloPembakaran(kalori: double.parse(kaloriPembakaran))
          .toString();
      kalori = kaloriPembakaran;
    }
    if (kiloPembakaran != null) {
      kalori = Kalkulator.kaloriPembakaran(kilo: double.parse(kiloPembakaran))
          .toString();
      kilo = kiloPembakaran;
    }
    await boxProfile.put('kalori pembakaran', kalori);
    await boxProfile.put('kilo pembakaran', kilo);

    final nilaiBmr = Kalkulator.bmr(
      isMan: isMan ?? profile.isMan ?? false,
      weight: double.parse(weight ?? profile.weight ?? '0'),
      height: double.parse(height ?? profile.height ?? '0'),
      age: double.parse(age ?? profile.age ?? '0'),
    );
    final String bmr = nilaiBmr.toStringAsFixed(2);
    await boxProfile.put('BMR', bmr);
    Publics.controller.getProfile.value = Storages.getProfile;
    return;
  }

  static Profile get getProfile =>
      Profile.fromJson(boxProfile.isNotEmpty ? boxProfile.toMap() : {});

  static Future<void> setHistory({required String query}) async {
    List<dynamic> listquery = Storages.getHistory;
    if (listquery.contains(query) == false) {
      await boxHistory.add(query);
    }
    Publics.controller.getHistory.value = Storages.getHistory;
  }

  static List<dynamic> get getHistory =>
      boxHistory.isNotEmpty ? boxHistory.values.toList() : [];

  static Future<void> setBahasa({required String language}) async {
    await boxBahasa.put('bahasa', language);
    Publics.controller.getBahasa.value = Storages.getBahasa;
    return;
  }

  static String get getBahasa {
    String bahasa = boxBahasa.isNotEmpty
        ? boxBahasa.values.first ??
            (Get.deviceLocale != null ? Get.deviceLocale!.languageCode : 'en')
        : 'en';
    return bahasa;
  }
}
