import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/modules/inputdata/views/formprofile.dart';

class AddFood extends StatelessWidget {
  final Foods foods;
  final TextEditingController controller;
  const AddFood({super.key, required this.foods, required this.controller});

  @override
  Widget build(BuildContext context) {
    final foodList = Publics.controller.getListFood
        .map((element) => Foods.fromJson(element).fdcId ?? 0)
        .toList();
    controller.text = (foods.servingSize ?? 0).toInt().toString();
    return foodList.contains(foods.fdcId ?? 0) != true
        ? IconButton(
            icon: const ImageIcon(
              AssetImage(
                IconApp.add,
              ),
              color: Warna.primary,
              size: 20.0,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: 'Serving Size',
                onConfirm: () async {
                  if (controller.text.isNotEmpty) {
                    foods.servingSize = double.parse(controller.text);
                    await Storages.setListFood(foods: foods);
                    Get.back();
                    Publics.snackBarSuccess(
                      'Successfully Added to the Food List',
                      foods.description!,
                    );
                  } else {
                    Publics.snackBarFail('Fail To Input Serving Size',
                        'serving size must be filled.');
                  }
                },
                textConfirm: 'ADD',
                content: FormProfile(
                  label:
                      'Serving Size  ${foods.servingSizeUnit != null ? '(${foods.servingSizeUnit})' : ''}*',
                  controller: controller,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                ),
              );
            })
        : IconButton(
            icon: const ImageIcon(
              AssetImage(
                IconApp.close,
              ),
              color: Colors.red,
              size: 20.0,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete this food?',
                onCancel: () async {
                  await Storages.deleteListFood(foods: foods);
                  Publics.snackBarSuccess(
                    'Successfully Deleted to the Food List',
                    foods.description!,
                  );
                },
                buttonColor: Colors.red,
                cancelTextColor: Colors.red,
                textCancel: 'DELETE',
                content: const Text("Want to delete this food from list food?"),
              );
            });
  }
}
