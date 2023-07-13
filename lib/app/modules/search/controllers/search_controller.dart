import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/fetch_data.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/card_food.dart';
import 'package:search_page/search_page.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController
  final searchController = TextEditingController();
  final getSearch = Publics.controller.getSearch;
  final getBahasa = Publics.controller.getBahasa;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> onSearch(String query) async {
    Get.defaultDialog(
      title: 'Loading',
      titleStyle: Font.regular(),
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
    );
    String text;
    if (getBahasa.value == 'en') {
      text = query;
    } else {
      text = await translates(query, to: 'en');
    }
    final getSearchAPI = await API.getSearch(query: text);
    List<Foods> searchFood = getSearchAPI.foods ?? [];
    Get.back();
    showSearch(
      context: Get.context!,
      delegate: SearchPage<Foods>(
        items: searchFood,
        searchLabel: 'Search Food',
        searchStyle: Font.regular(
          fontStyle: FontStyle.italic,
        ),
        failure: Center(
          child: Text(
            'No food found :(',
            style: Font.regular(),
          ),
        ),
        showItemsOnEmpty: true,
        filter: (foods) => [
          foods.description,
          (foods.foodNutrients!
                      .firstWhere(
                        (data) => data.nutrientId == 1008,
                        orElse: () => FoodNutrients(value: 0),
                      )
                      .value ??
                  0)
              .toDouble()
              .toString(),
          (foods.foodNutrients!
                      .firstWhere(
                        (data) => data.nutrientId == 1008,
                        orElse: () => FoodNutrients(value: 0),
                      )
                      .value ??
                  0)
              .toDouble()
              .toString(),
        ],
        builder: (foods) {
          final servingSizeController = TextEditingController();
          return CardFood(
            foods: foods,
            controller: servingSizeController,
          );
        },
      ),
    );
  }

  void onSubmit() async {
    if (searchController.text.isNotEmpty) {
      await Storages.setSearch(
        query: searchController.value.text,
      );
      getSearch.value = Storages.getSearch;
      await onSearch(searchController.value.text);
    }
  }
}
