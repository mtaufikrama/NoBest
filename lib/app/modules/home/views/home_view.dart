import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/kategori_imt.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/card_food.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double kkad = -100.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOBES',
          style: Font.regular(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: PopupMenuButton(
          key: controller.keyButton,
          tooltip: stringTranslate('Translate'),
          icon: const ImageIcon(
            AssetImage(
              IconApp.translate,
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: teksLanguage(
                'Indonesian',
                style: Font.regular(),
              ),
              onTap: () async => await Storages.setBahasa(language: 'id'),
            ),
            PopupMenuItem(
              child: teksLanguage(
                'English',
                style: Font.regular(),
              ),
              onTap: () async => await Storages.setBahasa(language: 'en'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Obx(() {
              if (controller.getProfile.value.image == null) {
                return const ImageIcon(AssetImage(IconApp.user));
              } else {
                return CircleAvatar(
                  backgroundImage:
                      FileImage(File(controller.getProfile.value.image!)),
                );
              }
            }),
            onPressed: () => controller.getProfile.value.weight != null
                ? Get.toNamed(Routes.PROFILE)
                : Get.toNamed(Routes.INPUTDATA),
          ),
        ],
      ),
      body: RefreshPage(
        routes: Routes.HOME,
        child: Obx(
          () => controller.getGenerate.isNotEmpty ||
                  controller.getProfile.value.kkt != null
              ? ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Warna.baseWhite,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      controller.getBahasa.value == 'id'
                                          ? 'IMT'
                                          : 'BMI',
                                      style: Font.regular(
                                        fontSize: 20.0,
                                        color: Warna.baseWhite,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Divider(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: DChartGauge(
                                      data: const [
                                        {
                                          'domain': KategoriIMT.kurus,
                                          'measure': 1
                                        },
                                        {
                                          'domain': KategoriIMT.normal,
                                          'measure': 1
                                        },
                                        {
                                          'domain': KategoriIMT.kegemukkan,
                                          'measure': 1
                                        },
                                        {
                                          'domain': KategoriIMT.obesitas,
                                          'measure': 1
                                        },
                                      ],
                                      fillColor: (pieData, index) {
                                        String imt = Kalkulator.kategoriIMT(
                                          isMan: controller
                                              .getProfile.value.isMan!,
                                          imt: double.parse(
                                              controller.getProfile.value.imt!),
                                        );
                                        if (pieData['domain'] == imt) {
                                          switch (
                                              (pieData['domain'] as String)) {
                                            case KategoriIMT.kurus:
                                              return Colors.blue;
                                            case KategoriIMT.normal:
                                              return Colors.green;
                                            case KategoriIMT.kegemukkan:
                                              return Colors.orange;
                                            default:
                                              return Colors.red;
                                          }
                                        } else {
                                          return Colors.grey;
                                        }
                                      },
                                      animationDuration:
                                          const Duration(milliseconds: 500),
                                      showLabelLine: false,
                                      pieLabel: (pieData, index) {
                                        return "";
                                      },
                                      strokeWidth: 0,
                                      donutWidth: 10,
                                    ),
                                  ),
                                  Text(
                                    controller.getProfile.value.imt
                                        .toString()
                                        .toUpperCase(),
                                    style: Font.number(
                                      fontSize: 20.0,
                                      color: Warna.baseWhite,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  teksLanguage(
                                    Kalkulator.kategoriIMT(
                                      isMan: controller.getProfile.value.isMan!,
                                      imt: double.parse(
                                          controller.getProfile.value.imt!),
                                    ).toUpperCase(),
                                    style: Font.regular(
                                      fontSize: 15.0,
                                      color: Warna.baseWhite,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Warna.baseWhite,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      controller.getBahasa.value == 'id'
                                          ? 'KKT'
                                          : 'TDEE',
                                      style: Font.regular(
                                        fontSize: 20.0,
                                        color: Warna.baseWhite,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Divider(height: 5),
                                  Expanded(
                                    child: DChartSingleBar(
                                      backgroundColor: controller.kalori > 0.0
                                          ? Colors.red
                                          : controller.kalori == 0.0
                                              ? Colors.grey
                                              : Colors.green,
                                      forgroundColor: Colors.blue,
                                      value: controller.maxNValue['value']!,
                                      max: controller.maxNValue['max']!,
                                    ),
                                  ),
                                  Text(
                                    controller.kkt.toStringAsFixed(2),
                                    style: Font.number(
                                      fontSize: 20.0,
                                      color: Warna.baseWhite,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  teksLanguage(
                                    Kalkulator.kategoriIMT(
                                      isMan: controller.getProfile.value.isMan!,
                                      imt: double.parse(
                                          controller.getProfile.value.imt!),
                                    ).toUpperCase(),
                                    style: Font.regular(
                                      fontSize: 15.0,
                                      color: Warna.baseWhite,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    controller.getGenerate.isNotEmpty
                        ? controller.getGenerate[Kalkulator.timeNow] != null
                            ? Column(
                                children: [
                                  Row(
                                    children: [1008, 1003, 1004, 1005].map(
                                      (nutrientId) {
                                        List<Foods> dataGenerate =
                                            (controller.getGenerate[
                                                    Kalkulator.timeNow] as List)
                                                .map((e) => Foods.fromJson(e))
                                                .toList();
                                        double nilai = 0;
                                        dataGenerate.map((e) {
                                          double value = e.servingSize !=
                                                      null &&
                                                  e.servingSizeUnit != null
                                              ? Kalkulator.porsi(
                                                  size: e.servingSize ?? 100,
                                                  value: e.foodNutrients!
                                                          .firstWhere(
                                                            (data) =>
                                                                data.nutrientId ==
                                                                nutrientId,
                                                            orElse: () =>
                                                                FoodNutrients(
                                                                    value: 0),
                                                          )
                                                          .value ??
                                                      0)
                                              : (e.foodNutrients!
                                                      .firstWhere(
                                                        (data) =>
                                                            data.nutrientId ==
                                                            nutrientId,
                                                        orElse: () =>
                                                            FoodNutrients(
                                                                value: 0),
                                                      )
                                                      .value ??
                                                  0);
                                          nilai += value;
                                        }).toList();
                                        return Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                color: Colors.black,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: teksLanguage(
                                                        dataGenerate.first
                                                                .foodNutrients!
                                                                .firstWhere(
                                                                  (data) =>
                                                                      data.nutrientId ==
                                                                      nutrientId,
                                                                  orElse: () =>
                                                                      FoodNutrients(
                                                                          nutrientName:
                                                                              'null'),
                                                                )
                                                                .nutrientName ??
                                                            'null',
                                                        style: Font.regular(
                                                          color:
                                                              Warna.baseWhite,
                                                          fontSize: 10.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    const Divider(),
                                                    Expanded(
                                                      child: Center(
                                                        child: AutoSizeText(
                                                          nilai.toStringAsFixed(
                                                              2),
                                                          style: Font.number(
                                                            color:
                                                                Warna.secondary,
                                                            fontSize: 50,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      dataGenerate.first
                                                              .foodNutrients!
                                                              .firstWhere(
                                                                (data) =>
                                                                    data.nutrientId ==
                                                                    nutrientId,
                                                                orElse: () =>
                                                                    FoodNutrients(
                                                                        unitName:
                                                                            'null'),
                                                              )
                                                              .unitName ??
                                                          'null',
                                                      style: Font.regular(
                                                        color: Warna.secondary,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: teksLanguage(
                                              "LIST GENERATE FOODS",
                                              style: Font.regular(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          height: 5,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .getGenerate[Kalkulator.timeNow]
                                              .length,
                                          itemBuilder: (context, index) {
                                            Foods foods = Foods.fromJson(
                                                controller.getGenerate[
                                                    Kalkulator.timeNow][index]);
                                            return CardFood(
                                              foods: foods,
                                              isRecently: true,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: ElevatedButton.icon(
                                  onPressed: () => Get.toNamed(Routes.GENERATE),
                                  icon: const ImageIcon(
                                    AssetImage(
                                      IconApp.setting,
                                    ),
                                    size: 24.0,
                                  ),
                                  label: teksLanguage(
                                    'Going To Generate Food',
                                    style: Font.regular(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              )
                        : Center(
                            child: ElevatedButton.icon(
                              onPressed: () => Get.toNamed(Routes.GENERATE),
                              icon: const ImageIcon(
                                AssetImage(
                                  IconApp.setting,
                                ),
                                size: 24.0,
                              ),
                              label: teksLanguage(
                                'Going To Generate Food',
                                style: Font.regular(
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              : Center(
                  child: ElevatedButton.icon(
                    label: teksLanguage(
                      'Input Data Profile',
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    onPressed: () => Get.toNamed(Routes.INPUTDATA),
                    icon: const ImageIcon(
                      AssetImage(IconApp.user),
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        closeButtonStyle: const ExpandableFabCloseButtonStyle(
          backgroundColor: Colors.red,
          child: ImageIcon(AssetImage(IconApp.close)),
        ),
        overlayStyle: ExpandableFabOverlayStyle(blur: 5),
        type: ExpandableFabType.left,
        child: const ImageIcon(
          AssetImage(IconApp.menu),
        ),
        children: [
          FloatingActionButton.small(
              tooltip: 'Generate Food',
              heroTag: IconApp.setting,
              child: const ImageIcon(AssetImage(IconApp.setting)),
              onPressed: () => Get.toNamed(Routes.GENERATE)),
          FloatingActionButton.small(
            tooltip: 'List Food',
            heroTag: IconApp.note,
            child: const ImageIcon(AssetImage(IconApp.note)),
            onPressed: () => Get.toNamed(Routes.LISTFOOD),
          ),
          FloatingActionButton.small(
            tooltip: 'Search Food',
            heroTag: IconApp.search,
            child: const ImageIcon(AssetImage(IconApp.search)),
            onPressed: () => Get.toNamed(Routes.SEARCH),
          ),
        ],
      ),
    );
  }
}
