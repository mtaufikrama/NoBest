import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/translate.dart';

class UniverseController extends GetxController {
  final getProfile = Storages.getProfile.obs;
  final getRecently = Storages.getRecently.obs;
  final getGenerate = Storages.getGenerate.obs;
  final getBahasa = Storages.getBahasa.obs;
  final getSearch = Storages.getSearch.obs;
}

class Publics {
  static var controller = Get.put(UniverseController());
  static final leading = IconButton(
    onPressed: () => Get.back(),
    icon: const ImageIcon(
      AssetImage(IconApp.back),
    ),
  );
  static snackBarFail(String title, String message) => Get.snackbar(
        '',
        '',
        titleText: teksLanguage(
          title,
          isCapitalized: true,
          style: Font.regular(
            color: Colors.red,
          ),
        ),
        messageText: teksLanguage(
          message,
          style: Font.regular(),
        ),
      );
  static snackBarSuccess(String title, String message) => Get.snackbar(
        '',
        '',
        titleText: teksLanguage(
          title,
          isCapitalized: true,
          style: Font.regular(
            color: Colors.green,
          ),
        ),
        messageText: teksLanguage(
          message,
          style: Font.regular(),
        ),
      );
}
