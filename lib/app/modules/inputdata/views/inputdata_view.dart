import 'dart:io';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/modules/inputdata/views/formprofile.dart';
import 'package:nobes/app/routes/app_pages.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../data/model/tutorial.dart';
import '../controllers/inputdata_controller.dart';

class InputdataView extends StatefulWidget {
  const InputdataView({super.key});

  @override
  State<InputdataView> createState() => _InputdataViewState();
}

class _InputdataViewState extends State<InputdataView> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyFoto = GlobalKey();
  GlobalKey keyFloating = GlobalKey();
  GlobalKey keyName = GlobalKey();
  GlobalKey keyHeight = GlobalKey();
  GlobalKey keyWeight = GlobalKey();
  GlobalKey keyAge = GlobalKey();
  GlobalKey keyGender = GlobalKey();

  final controller = Get.put(InputdataController());

  @override
  void initState() {
    if (controller.getTutorial.value.inputProfile != true) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: teksLanguage(
          'Input Data',
          style: Font.regular(),
        ),
        centerTitle: true,
        leading: Publics.leading,
      ),
      body: RefreshPage(
        routes: Routes.INPUTDATA,
        child: ListView(
          children: [
            SizedBox(
              height: Get.height / 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Obx(() {
                          return Container(
                            key: keyFoto,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              image: controller.getProfile.value.image !=
                                          null ||
                                      controller.imagePath.value.isNotEmpty
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(
                                          controller.imagePath.value.isNotEmpty
                                              ? controller.imagePath.value
                                              : controller
                                                  .getProfile.value.image!)))
                                  : null,
                              color: Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: Get.height / 3,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: TextButton.icon(
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (image != null) {
                                            controller.imagePath.value =
                                                image.path;
                                          }
                                        },
                                        icon: const Icon(Icons.filter_rounded),
                                        label: teksLanguage(
                                          'Gallery',
                                          style: Font.regular(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton.icon(
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          if (image != null) {
                                            controller.imagePath.value =
                                                image.path;
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.camera,
                                        ),
                                        label: teksLanguage(
                                          'Gallery',
                                          style: Font.regular(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const ImageIcon(
                          AssetImage(
                            IconApp.camera,
                          ),
                          color: Warna.baseBlack,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                FormProfile(
                  key: keyName,
                  label: 'Name',
                  keyboardType: TextInputType.name,
                  controller: controller.nameController,
                ),
                FormProfile(
                  key: keyWeight,
                  label: 'Weight (kg) *',
                  keyboardType: TextInputType.number,
                  controller: controller.weightController,
                ),
                FormProfile(
                  key: keyHeight,
                  label: 'Height (cm)*',
                  keyboardType: TextInputType.number,
                  controller: controller.heightController,
                ),
                Padding(
                  key: keyAge,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  child: TextFormField(
                    controller: controller.ageController,
                    readOnly: true,
                    onTap: () async {
                      final datePicker = await showDatePicker(
                        context: context,
                        initialDate: controller.calender.value,
                        firstDate: DateTime(1800),
                        lastDate: DateTime.now(),
                      );
                      if (datePicker != null) {
                        controller.calender.value = datePicker;
                        controller.ageController.text = Kalkulator.umur(
                                DateFormat('yyyy-MM-dd')
                                    .format(controller.calender.value))
                            .toString();
                      }
                    },
                    style: Font.regular(),
                    decoration: InputDecoration(
                      label: teksLanguage(
                        'Age (years old)*',
                        style: Font.regular(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Warna.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  key: keyGender,
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    style: Font.regular(),
                    isDense: true,
                    isExpanded: true,
                    hint: teksLanguage(
                      controller.genderValue.value == null
                          ? 'Gender *'
                          : controller.genderValue.isFalse!
                              ? 'Female'
                              : 'Male',
                      style: Font.regular(),
                    ),
                    items: controller.gender
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: teksLanguage(
                              item.gender,
                              style: Font.regular(),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Gender';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.genderValue.value = value!.isMan;
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 60,
                      padding: EdgeInsets.only(left: 0, right: 10),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: ImageIcon(AssetImage(IconApp.arrowDown)),
                      iconSize: 20,
                      openMenuIcon: ImageIcon(
                        AssetImage(IconApp.arrowUp),
                        color: Warna.primary,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: keyFloating,
        onPressed: () async {
          if (controller.nameController.text.isNotEmpty &&
              controller.weightController.text.isNotEmpty &&
              controller.heightController.text.isNotEmpty &&
              controller.ageController.text.isNotEmpty &&
              controller.genderValue.value != null) {
            await Storages.setProfile(
              isMan: controller.genderValue.value!,
              image: controller.imagePath.value.isNotEmpty
                  ? controller.imagePath.value
                  : null,
              name: controller.nameController.text,
              height: controller.heightController.text,
              weight: controller.weightController.text,
              age: controller.ageController.text,
            );
            Get.offNamed(Routes.PROFILE);
          } else {
            Publics.snackBarFail(
              'REQUIREMENT!',
              'name, weight, height, and age are mandatory to fill in',
            );
          }
        },
        child: const ImageIcon(
          AssetImage(IconApp.send),
          color: Warna.baseBlack,
        ),
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.red,
      textSkip: 'SKIP >>',
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () async {
        await Storages.setTutorial(tutorial: TutorialModel(inputProfile: true));
        Get.toNamed(Routes.INPUTDATA);
      },
      onSkip: () async {
        await Storages.setTutorial(tutorial: TutorialModel(inputProfile: true));
        Get.toNamed(Routes.INPUTDATA);
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Foto",
        keyTarget: keyFoto,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return teksLanguage(
                "Titulo lorem ipsum",
                style: Font.regular(
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Floating",
        keyTarget: keyFloating,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "Age",
        keyTarget: keyAge,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        radius: 0,
        identify: "Height",
        keyTarget: keyHeight,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        radius: 0,
        identify: "Name",
        keyTarget: keyName,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        radius: 0,
        identify: "Weight",
        keyTarget: keyWeight,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        radius: 0,
        identify: "Gender",
        keyTarget: keyGender,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }
}
