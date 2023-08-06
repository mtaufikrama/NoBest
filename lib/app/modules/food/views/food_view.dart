import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_fdcid.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/fetch_data.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import '../controllers/food_controller.dart';

class FoodView extends GetView<FoodController> {
  const FoodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.fdcid != null
            ? FutureBuilder(
                future: API.getFdcId(fdcid: int.parse(controller.fdcid!)),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.data != null) {
                    USDAFdcId data = snapshot.data!;
                    return teksLanguage(
                      data.description!,
                      style: Font.regular(),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            : Text(
                "Null",
                style: Font.regular(),
              ),
        centerTitle: true,
        actions: [
          FutureBuilder(
            future: API.getFdcId(fdcid: int.parse(controller.fdcid!)),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState != ConnectionState.waiting &&
                  snapshot.data != null) {
                USDAFdcId data = snapshot.data!;
                return IconButton(
                  onPressed: () => Get.toNamed(Routes.IMAGES, parameters: {
                    'link': controller.link(data),
                  }),
                  icon: const ImageIcon(
                    AssetImage(
                      IconApp.gallery,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: RefreshPage(
        routes: Routes.FOOD,
        parameters: {'fdcid': controller.fdcid!},
        child: controller.fdcid != null
            ? FutureBuilder(
                future: API.getFdcId(fdcid: int.parse(controller.fdcid!)),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.data != null) {
                    USDAFdcId data = snapshot.data!;
                    controller.servingSize.value = data.servingSize!.toInt();
                    return ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: teksLanguage(
                            data.description.toString(),
                            style: Font.regular(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            isCapitalized: false,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              teksLanguage(
                                'Publication Date :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                data.publicationDate ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              teksLanguage(
                                'Brand Name :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                data.brandName ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              teksLanguage(
                                'Brand Owner :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                data.brandOwner ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              teksLanguage(
                                'Branded Food Category :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                data.brandedFoodCategory ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              teksLanguage(
                                'Data Source :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                data.dataSource ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              teksLanguage(
                                'Serving Size :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                "${data.servingSize ?? 0}",
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              teksLanguage(
                                'Data Type :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                data.dataType ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Ingredients :',
                                style: Font.regular(
                                  color: Warna.baseWhite.withOpacity(0.8),
                                ),
                              ),
                              teksLanguage(
                                data.ingredients ?? '-',
                                style: Font.regular(),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: data.foodPortions != null
                              ? data.foodPortions!.isNotEmpty
                                  ? DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      isExpanded: true,
                                      hint: teksLanguage('Food Portions',
                                          style: Font.regular()),
                                      items: data.foodPortions!
                                          .map(
                                            (item) => DropdownMenuItem(
                                              value: item,
                                              child: ListTile(
                                                title: Text(
                                                  (item.gramWeight ?? 0)
                                                      .toString(),
                                                  style: Font.regular(),
                                                ),
                                                subtitle: Text(
                                                  item.portionDescription ?? '',
                                                  style: Font.regular(),
                                                ),
                                                trailing: Text(
                                                  (item.measureUnit != null
                                                      ? item.measureUnit!
                                                              .name ??
                                                          ''
                                                      : ''),
                                                  style: Font.regular(),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        controller.servingSize.value =
                                            value!.gramWeight!;
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        height: 60,
                                        padding:
                                            EdgeInsets.only(left: 0, right: 10),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: ImageIcon(
                                            AssetImage(IconApp.arrowDown)),
                                        iconSize: 20,
                                        openMenuIcon: ImageIcon(
                                          AssetImage(IconApp.arrowUp),
                                          color: Warna.primary,
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    )
                                  // DropdownSearch<FoodPortions>(
                                  //     popupProps: const PopupProps.menu(
                                  //       fit: FlexFit.loose,
                                  //     ),
                                  //     itemAsString: (item) =>
                                  //         item.gramWeight.toString(),
                                  //     items: data.foodPortions!,
                                  //     dropdownDecoratorProps:
                                  //         DropDownDecoratorProps(
                                  //       dropdownSearchDecoration: InputDecoration(
                                  //         label: teksLanguage(
                                  //           "Food Portions",
                                  //           style: Font.regular(),
                                  //         ),
                                  //         border: OutlineInputBorder(
                                  //           borderRadius: BorderRadius.circular(20),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     onChanged: (value) => controller
                                  //         .servingSize.value = value!.gramWeight!,
                                  //   )
                                  : Container()
                              : Container(),
                        ),
                        Card(
                          margin: const EdgeInsets.all(0),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: teksLanguage(
                                  'Food Nutrients',
                                  style: Font.regular(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Obx(() {
                                return Column(
                                  children: data.foodNutrients!
                                      .map(
                                        (e) => ListTile(
                                          dense: true,
                                          title: teksLanguage(
                                            e.nutrient!.name!,
                                            style: Font.regular(
                                              color: Warna.baseWhite
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${Kalkulator.porsi(size: controller.servingSize.value.toDouble(), value: (e.amount ?? 0)).toStringAsFixed(2)} ${e.nutrient!.unitName!}',
                                            style: Font.regular(fontSize: 15),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : Center(child: Text("Food is Empty", style: Font.regular())),
      ),
    );
  }
}
