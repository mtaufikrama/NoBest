import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/icon_add_food.dart';
import 'package:nobes/app/routes/app_pages.dart';

class CardFood extends StatelessWidget {
  const CardFood({
    super.key,
    required this.foods,
    this.controller,
    this.isRecently = false,
  });
  final Foods foods;
  final bool isRecently;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.FOOD,
          parameters: {'fdcid': foods.fdcId.toString()}),
      child: Card(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        foods.brandName != null
                            ? Text(
                                '${foods.brandName!.toTitleCase()}\n${foods.brandOwner!.toTitleCase()}',
                                style: Font.regular(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              )
                            : Container(),
                        teksLanguage(
                          (foods.description ?? '').toUpperCase(),
                          style: Font.regular(
                            fontSize: 15.0,
                          ),
                        ),
                        foods.servingSize != null
                            ? teksLanguage(
                                'Serving Size : ${(foods.servingSize ?? 0.0).toInt()} ${foods.servingSizeUnit ?? ''}',
                                style: Font.regular(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  isRecently == false
                      ? AddFood(
                          foods: foods,
                          controller: controller!,
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Warna.baseWhite),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  teksLanguage(
                    foods.foodNutrients!
                            .firstWhere(
                              (data) => data.nutrientId == 1008,
                              orElse: () => FoodNutrients(nutrientName: 'null'),
                            )
                            .nutrientName ??
                        'null',
                    style: Font.regular(
                      color: Warna.baseWhite,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: AutoSizeText(
                      foods.servingSize != null && foods.servingSizeUnit != null
                          ? (Kalkulator.porsi(
                                  size: foods.servingSize ?? 100,
                                  value: foods.foodNutrients!
                                          .firstWhere(
                                            (data) => data.nutrientId == 1008,
                                            orElse: () =>
                                                FoodNutrients(value: 0),
                                          )
                                          .value ??
                                      0))
                              .toStringAsFixed(2)
                          : (foods.foodNutrients!
                                      .firstWhere(
                                        (data) => data.nutrientId == 1008,
                                        orElse: () => FoodNutrients(value: 0),
                                      )
                                      .value ??
                                  0)
                              .toDouble()
                              .toString(),
                      style: Font.number(
                        color: Warna.secondary,
                        fontSize: 50,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    foods.foodNutrients!
                            .firstWhere(
                              (data) => data.nutrientId == 1008,
                              orElse: () => FoodNutrients(unitName: 'null'),
                            )
                            .unitName ??
                        'null',
                    style: Font.regular(
                      color: Warna.secondary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [1008, 1003, 1004, 1005]
            //       .map(
            //         (e) => Expanded(
            //           child: AspectRatio(
            //             aspectRatio: 1,
            //             child: Padding(
            //               padding: const EdgeInsets.all(3),
            //               child: Card(
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(15),
            //                   side: const BorderSide(
            //                     color: Colors.grey,
            //                     width: 1.5,
            //                   ),
            //                 ),
            //                 color: Colors.black,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.only(top: 8),
            //                       child: teksLanguage(
            //                         foods.foodNutrients!
            //                                 .firstWhere(
            //                                   (data) => data.nutrientId == e,
            //                                   orElse: () => FoodNutrients(
            //                                       nutrientName: 'null'),
            //                                 )
            //                                 .nutrientName ??
            //                             'null',
            //                         style: Font.regular(
            //                           color: Warna.baseWhite,
            //                           fontSize: 10.0,
            //                           fontWeight: FontWeight.w500,
            //                         ),
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         textAlign: TextAlign.center,
            //                       ),
            //                     ),
            //                     const Divider(),
            //                     Expanded(
            //                       child: Center(
            //                         child: AutoSizeText(
            //                           foods.servingSize != null &&
            //                                   foods.servingSizeUnit != null
            //                               ? (Kalkulator.porsi(
            //                                       size:
            //                                           foods.servingSize ?? 100,
            //                                       value: foods.foodNutrients!
            //                                               .firstWhere(
            //                                                 (data) =>
            //                                                     data.nutrientId ==
            //                                                     e,
            //                                                 orElse: () =>
            //                                                     FoodNutrients(
            //                                                         value: 0),
            //                                               )
            //                                               .value ??
            //                                           0))
            //                                   .toStringAsFixed(2)
            //                               : (foods.foodNutrients!
            //                                           .firstWhere(
            //                                             (data) =>
            //                                                 data.nutrientId ==
            //                                                 e,
            //                                             orElse: () =>
            //                                                 FoodNutrients(
            //                                                     value: 0),
            //                                           )
            //                                           .value ??
            //                                       0)
            //                                   .toDouble()
            //                                   .toString(),
            //                           style: Font.number(
            //                             color: Warna.secondary,
            //                             fontSize: 50,
            //                           ),
            //                           maxLines: 1,
            //                         ),
            //                       ),
            //                     ),
            //                     Text(
            //                       foods.foodNutrients!
            //                               .firstWhere(
            //                                 (data) => data.nutrientId == e,
            //                                 orElse: () =>
            //                                     FoodNutrients(unitName: 'null'),
            //                               )
            //                               .unitName ??
            //                           'null',
            //                       style: Font.regular(
            //                         color: Warna.secondary,
            //                         fontSize: 12.0,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                       textAlign: TextAlign.center,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //       .toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
