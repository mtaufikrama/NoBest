import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/card_food.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import '../controllers/listfood_controller.dart';

class ListfoodView extends GetView<ListfoodController> {
  const ListfoodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: teksLanguage(
          'List Food',
          style: Font.regular(),
        ),
        centerTitle: true,
        leading: Publics.leading,
      ),
      body: RefreshPage(
        routes: Routes.LISTFOOD,
        child: controller.getListFood.isNotEmpty
            ? ListView.builder(
                itemCount: controller.getListFood.length,
                itemBuilder: (BuildContext context, int index) {
                  Foods foods = Foods.fromJson(controller.getListFood[index]);
                  final servingSizeController = TextEditingController();
                  return CardFood(
                    foods: foods,
                    isRecently: true,
                    controller: servingSizeController,
                  );
                },
              )
            : Center(
                child: Text(
                  "List Food is Empty",
                  style: Font.regular(
                    fontSize: 12.0,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const ImageIcon(AssetImage(IconApp.setting)),
        onPressed: () => Get.toNamed(Routes.GENERATE),
      ),
    );
  }
}
