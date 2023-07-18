import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/profile.dart';
import 'package:nobes/app/data/model/gender.dart';
import 'package:nobes/app/data/services/public.dart';

class InputdataController extends GetxController {
  //TODO: Implement InputdataController

  TextEditingController nameController =
      TextEditingController(text: Publics.controller.getProfile.value.name);
  TextEditingController weightController =
      TextEditingController(text: Publics.controller.getProfile.value.weight);
  TextEditingController heightController =
      TextEditingController(text: Publics.controller.getProfile.value.height);
  TextEditingController ageController =
      TextEditingController(text: Publics.controller.getProfile.value.age);
  Rx<Profile> getProfile = Publics.controller.getProfile;
  final genderValue = Publics.controller.getProfile.value.isMan.obs;
  final getTutorial = Publics.controller.getTutorial;
  final imagePath = ''.obs;
  final calender = DateTime.now().obs;

  final gender = [
    GenderModel(true, 'Male'),
    GenderModel(false, 'Female'),
  ];

  // @override
  // void onClose() {
  //   nameController.clear();
  //   weightController.clear();
  //   heightController.clear();
  //   ageController.clear();
  //   super.onClose();
  // }
}
