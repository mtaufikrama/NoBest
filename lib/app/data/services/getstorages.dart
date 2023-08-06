import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nobes/app/data/model/profile.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/public.dart';

import '../model/tutorial.dart';

class Storages {
  static const profileName = 'profile';
  static const recentlyName = 'recently menu';
  static const generateName = 'generate menu';
  static const dailyName = 'daily menu';
  static const searchName = 'search';
  static const bahasaName = 'bahasa';
  static const tutorialName = 'tutorial';
  static const listStoragesName = [
    profileName,
    recentlyName,
    generateName,
    dailyName,
    searchName,
    bahasaName,
    tutorialName,
  ];
  static final boxProfile = Hive.box(profileName);
  static final boxRecentlyMenu = Hive.box(recentlyName);
  static final boxGenerateMenu = Hive.box(generateName);
  static final boxDailyMenu = Hive.box(dailyName);
  static final boxSearch = Hive.box(searchName);
  static final boxBahasa = Hive.box(bahasaName);
  static final boxTutorial = Hive.box(tutorialName);

  static Future<void> setRecently({required Foods foods}) async {
    await boxRecentlyMenu.add(foods.toJson());
    Publics.controller.getRecently.value = Storages.getRecently;
    return;
  }

  static List get getRecently {
    List recently = boxRecentlyMenu.values.toList();
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

  // static Future<void> setDaily(
  //     {required List<Foods> foods, required Profile profile}) async {
  //   String time = Kalkulator.timeNow;
  //   List<Map<String, dynamic>> listFood = foods.map((e) => e.toJson()).toList();
  //   Map<String, dynamic> profileValue = profile.toJson();
  //   Map<String, dynamic> value = {
  //     'profile': profileValue,
  //     'foods': listFood,
  //   };
  //   await boxDailyMenu.put(time, value);
  //   Publics.controller.getDaily.value = Storages.getDaily;
  //   return;
  // }

  // static Map<dynamic, dynamic> get getDaily {
  //   Map<dynamic, dynamic> daily =
  //       boxDailyMenu.isNotEmpty ? boxDailyMenu.toMap() : {};
  //   return daily;
  // }

  static Future<void> setGenerate({required List<Foods> foods}) async {
    await boxGenerateMenu.clear();
    String time = Kalkulator.timeNow;
    List<Map<dynamic, dynamic>> listFood =
        foods.map((e) => e.toJson()).toList();
    await boxGenerateMenu.put(time, listFood);
    Publics.controller.getGenerate.value = Storages.getGenerate;
    return;
  }

  static Map<dynamic, dynamic> get getGenerate {
    Map<dynamic, dynamic> generate =
        boxGenerateMenu.isNotEmpty ? boxGenerateMenu.toMap() : {};
    return generate;
  }

  static Future<void> setProfile({
    String? image,
    String? name,
    String? height,
    String? weight,
    String? age,
    bool? isMan,
    String? pal,
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
    await boxProfile.put('gender', isMan ?? profile.isMan ?? false);
    await boxProfile.put('weight', weight ?? profile.weight ?? '0');
    await boxProfile.put('age', age ?? profile.age ?? '0');
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

  static Future<void> setSearch({required String query}) async {
    List<dynamic> listquery = Storages.getSearch;
    if (listquery.contains(query) == false) {
      await boxSearch.add(query);
    }
    Publics.controller.getSearch.value = Storages.getSearch;
  }

  static List<dynamic> get getSearch =>
      boxSearch.isNotEmpty ? boxSearch.values.toList() : [];

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
