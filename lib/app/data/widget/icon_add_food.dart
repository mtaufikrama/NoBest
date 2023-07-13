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
    return IconButton(
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
                await Storages.setRecently(foods: foods);
                Get.back();
                Publics.snackBarSuccess(
                  'Successfully Added to the Food List',
                  foods.description!,
                );
              } else {
                Publics.snackBarFail('Fail To Input Serving Size',
                    'Form serving size must be filled.');
              }
            },
            textConfirm: 'OK',
            content: FormProfile(
              label: 'Serving Size *',
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
          );
        });
  }
}
