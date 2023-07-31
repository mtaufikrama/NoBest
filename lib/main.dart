import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'app/data/services/getstorages.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Storages.dailyName);
  await Hive.openBox(Storages.generateName);
  await Hive.openBox(Storages.profileName);
  await Hive.openBox(Storages.recentlyName);
  await Hive.openBox(Storages.searchName);
  await Hive.openBox(Storages.bahasaName);
  await Hive.openBox(Storages.tutorialName);
  // await Storages.boxBahasa.clear();
  // await Storages.boxProfile.clear();
  // await Storages.boxSearch.clear();
  // await Storages.boxTutorial.clear();
  // await Storages.boxGenerateMenu.clear();
  // await Storages.boxDailyMenu.clear();
  // await Storages.boxRecentlyMenu.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nobes",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          background: Warna.baseBlack,
          primary: Warna.primary,
          secondary: Warna.secondary,
          secondaryContainer: Warna.secondary,
          onSecondaryContainer: Warna.secondary,
        ),
        primaryColorDark: Warna.baseBlack,
        primaryColorLight: Warna.baseWhite,
        appBarTheme: AppBarTheme(
          color: Warna.secondary,
          foregroundColor: Warna.baseBlack,
          titleTextStyle: Font.regular(
            fontSize: 22,
            color: Warna.baseBlack,
          ),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
