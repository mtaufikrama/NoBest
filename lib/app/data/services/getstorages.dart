import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nobes/app/data/model/profile.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/public.dart';

class Storages {
  static const profileName = 'profile';
  static const recentlyName = 'recently menu';
  static const generateName = 'generate menu';
  static const dailyName = 'daily menu';
  static const searchName = 'search';
  static const bahasaName = 'bahasa';
  static const listStoragesName = [
    profileName,
    recentlyName,
    generateName,
    dailyName,
    searchName,
    bahasaName,
  ];
  static final boxProfile = Hive.box(profileName);
  static final boxRecentlyMenu = Hive.box(recentlyName);
  static final boxGenerateMenu = Hive.box(generateName);
  static final boxDailyMenu = Hive.box(dailyName);
  static final boxSearch = Hive.box(searchName);
  static final boxBahasa = Hive.box(bahasaName);

  static Future<void> setRecently({required Foods foods}) async {
    await boxRecentlyMenu.add(foods.toJson());
    Publics.controller.getRecently.value = Storages.getRecently;
    return;
  }

  static List get getRecently {
    List recently = boxRecentlyMenu.values.toList();
    return recently;
  }

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
    required String height,
    required String weight,
    required String age,
    required bool isMan,
    String? pal,
    String? kaloriPembakaran,
    String? kiloPembakaran,
  }) async {
    Profile profile = Storages.getProfile;
    await boxProfile.clear();
    final String imt = Kalkulator.imt(
      weight: double.parse(weight),
      height: double.parse(height),
    ).toString();
    await boxProfile.put('image', image ?? profile.image);
    await boxProfile.put('name', name ?? profile.name);
    await boxProfile.put('height', height);
    await boxProfile.put('gender', isMan);
    await boxProfile.put('weight', weight);
    await boxProfile.put('age', age);
    await boxProfile.put('IMT', imt);
    await boxProfile.put('PAL', pal ?? profile.pal ?? '1.2');
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

    final bmr = Kalkulator.bmr(
      isMan: isMan,
      weight: double.parse(weight),
      height: double.parse(height),
      age: double.parse(age),
    );
    final String kkt = Kalkulator.kkt(
      bmr: bmr,
      pal: pal != null
          ? double.parse(pal)
          : profile.pal != null
              ? double.parse(profile.pal!)
              : null,
    ).toStringAsFixed(2);
    await boxProfile.put('KKT', kkt);
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
