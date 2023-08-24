import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/modules/inputdata/views/formprofile.dart';
import 'package:nobes/app/routes/app_pages.dart';

import '../../../data/services/kalkulasi.dart';
import '../controllers/inputdata_controller.dart';

class InputdataView extends GetView<InputdataController> {
  const InputdataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: teksLanguage(
          'Input Data Profile',
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              image: controller.getProfile.value.image !=
                                          null ||
                                      controller.imagePath.value.isNotEmpty
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(base64Decode(
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
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: Get.height / 3,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Divider(
                                      color: Colors.grey,
                                      endIndent: (Get.width / 2) - 50,
                                      indent: (Get.width / 2) - 50,
                                      thickness: 5,
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                          shape: const RoundedRectangleBorder(),
                                        ),
                                        onPressed: () async {
                                          Get.back();
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (image != null) {
                                            File imaged = File(image.path);
                                            List<int> imageBytes =
                                                await imaged.readAsBytes();
                                            String base64Image =
                                                base64Encode(imageBytes);
                                            controller.imagePath.value =
                                                base64Image;
                                            Storages.setProfile(
                                              image: controller.imagePath.value,
                                            );
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
                                        style: TextButton.styleFrom(
                                          shape: const RoundedRectangleBorder(),
                                        ),
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          if (image != null) {
                                            File imaged = File(image.path);
                                            List<int> imageBytes =
                                                await imaged.readAsBytes();
                                            String base64Image =
                                                base64Encode(imageBytes);
                                            controller.imagePath.value =
                                                base64Image;
                                            Storages.setProfile(
                                              image: controller.imagePath.value,
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.camera,
                                        ),
                                        label: teksLanguage(
                                          'Camera',
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
                  label: 'Name',
                  keyboardType: TextInputType.name,
                  controller: controller.nameController,
                ),
                FormProfile(
                  label: 'Weight (kg)*',
                  keyboardType: TextInputType.number,
                  controller: controller.weightController,
                ),
                FormProfile(
                  label: 'Height (cm)*',
                  keyboardType: TextInputType.number,
                  controller: controller.heightController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  child: TextFormField(
                    controller: controller.dobController,
                    readOnly: true,
                    onTap: () async {
                      final datePicker = await showDatePicker(
                        context: context,
                        initialDate: controller.calender.value,
                        firstDate: DateTime(1800),
                        lastDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 18)),
                      );
                      if (datePicker != null) {
                        controller.calender.value = datePicker;
                        controller.dobController.text = DateFormat('yyyy-MM-dd')
                            .format(controller.calender.value);
                      }
                    },
                    style: Font.regular(),
                    decoration: InputDecoration(
                      label: teksLanguage(
                        'Date of Birth*',
                        style: Font.regular(
                          color: Colors.grey,
                        ),
                      ),
                      suffix: const ImageIcon(
                        AssetImage(IconApp.date),
                        size: 20,
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
        onPressed: () async {
          if (controller.weightController.text.isNotEmpty &&
              controller.heightController.text.isNotEmpty &&
              controller.dobController.text.isNotEmpty &&
              controller.genderValue.value != null) {
            if (Kalkulator.umur(controller.dobController.text) >= 18) {
              await Storages.setProfile(
                isMan: controller.genderValue.value,
                name: controller.nameController.text,
                height: controller.heightController.text,
                weight: controller.weightController.text,
                age: Kalkulator.umur(controller.dobController.text).toString(),
              );
              Get.offNamed(Routes.HOME);
              Get.toNamed(Routes.PROFILE);
            } else {
              Publics.snackBarFail(
                'REQUIREMENT!',
                'Age must be above 18 years old.',
              );
            }
          } else {
            Publics.snackBarFail(
              'REQUIREMENT!',
              'weight, height, gender and age must be filled',
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
}
