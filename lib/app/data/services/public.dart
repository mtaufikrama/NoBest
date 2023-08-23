import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/translate.dart';

class UniverseController extends GetxController {
  final getProfile = Storages.getProfile.obs;
  final getListFood = Storages.getListFood.obs;
  final getRecommend = Storages.getRecommend.obs;
  final getBahasa = Storages.getBahasa.obs;
  final getHistory = Storages.getHistory.obs;
  final getTutorial = Storages.getTutorial.obs;
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
            color: Colors.black,
          ),
        ),
        messageText: teksLanguage(
          message,
          style: Font.regular(),
        ),
      );
}
