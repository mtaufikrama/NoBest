import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/modules/inputdata/views/formprofile.dart';
import 'package:nobes/app/routes/app_pages.dart';

import '../controllers/inputdata_controller.dart';

class InputdataView extends GetView<InputdataController> {
  const InputdataView({Key? key}) : super(key: key);
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
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            controller.imagePath.value = image.path;
                          }
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
            FormProfile(
              label: 'Name',
              keyboardType: TextInputType.name,
              controller: controller.nameController,
            ),
            FormProfile(
              label: 'Weight *',
              keyboardType: TextInputType.number,
              controller: controller.weightController,
            ),
            FormProfile(
              label: 'Height *',
              keyboardType: TextInputType.number,
              controller: controller.heightController,
            ),
            FormProfile(
              label: stringTranslate('Age *'),
              keyboardType: TextInputType.number,
              controller: controller.ageController,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const ImageIcon(
          AssetImage(IconApp.send),
          color: Warna.baseBlack,
        ),
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
            Get.back();
          } else {
            Publics.snackBarFail(
              'REQUIREMENT!',
              'name, weight, height, and age are mandatory to fill in',
            );
          }
        },
      ),
    );
  }
}
