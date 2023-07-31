import 'dart:convert';
import 'dart:ui';
import 'package:d_chart/d_chart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/tutorial.dart';
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
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late TutorialCoachMark tutorialCoachMark;
  late TutorialCoachMark tutorialCoachMark1;

  GlobalKey keyGenerate = GlobalKey();
  GlobalKey keyBMI = GlobalKey();
  GlobalKey keyBMR = GlobalKey();

  GlobalKey keyTranslate = GlobalKey();
  GlobalKey keyProfile = GlobalKey();
  GlobalKey keyFloating = GlobalKey();

  final controller = Get.put(HomeController());

  @override
  void initState() {
    if (controller.getTutorial.value.homepage != true) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
    } else {
      if (controller.getTutorial.value.finish != true) {
        if (controller.getProfile.value.age != null ||
            controller.getProfile.value.age!.isNotEmpty) {
          createTutorial1();
          Future.delayed(Duration.zero, showTutorial1);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOBES',
          style: Font.regular(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: PopupMenuButton(
          key: keyTranslate,
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
                  backgroundImage: MemoryImage(
                      base64Decode(controller.getProfile.value.image!)),
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
                            child: GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                    title:
                                        'INFO ${controller.getBahasa.value == 'id' ? 'IMT' : 'BMI'}',
                                    titleStyle: Font.regular(),
                                    content: Column(
                                      children: [
                                        Text(
                                          controller.getBahasa.value == 'id'
                                              ? 'Indeks Massa Tubuh\n'
                                              : 'Body Mass Index\n',
                                          style: Font.regular(),
                                          textAlign: TextAlign.center,
                                        ),
                                        teksLanguage(
                                          "calculation is based on the World Health Organization (WHO) standards, and it is determined by one's height, weight, and gender.",
                                          style: Font.regular(),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Text(""),
                                        teksLanguage(
                                          "The formula for calculating BMI is as follows:",
                                          style: Font.regular(),
                                          textAlign: TextAlign.center,
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: teksLanguage(
                                            "weight(kg) / height(cm)²",
                                            style: Font.regular(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () => Get.back(),
                                        child: const ImageIcon(
                                          AssetImage(IconApp.close),
                                          size: 20.0,
                                        ),
                                      )
                                    ]);
                              },
                              child: Card(
                                key: keyBMI,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    width: 1.5,
                                    color: Warna.baseWhite,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                            imt: double.parse(controller
                                                .getProfile.value.imt!),
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
                                        isMan:
                                            controller.getProfile.value.isMan!,
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
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                    title:
                                        'INFO ${controller.getBahasa.value == 'id' ? 'AMB' : 'BMR'}',
                                    titleStyle: Font.regular(),
                                    content: Column(
                                      children: [
                                        Text(
                                          controller.getBahasa.value == 'id'
                                              ? 'Angka Metabolisme Badan\n'
                                              : 'Body Metabolic Rate\n',
                                          style: Font.regular(),
                                          textAlign: TextAlign.center,
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              teksLanguage(
                                                "calculation is based on the World Health Organization (WHO) standards, and it is determined by one's height, weight, and gender.",
                                                style: Font.regular(),
                                                textAlign: TextAlign.center,
                                              ),
                                              const Text(""),
                                              DropdownButtonFormField2(
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                hint: controller
                                                            .getProfile
                                                            .value
                                                            .kaloriPembakaran ==
                                                        null
                                                    ? teksLanguage(
                                                        'Energy Deficit',
                                                        style: Font.regular(
                                                            fontSize: 14),
                                                      )
                                                    : ListTile(
                                                        title: teksLanguage(
                                                          double.parse(controller
                                                                      .getProfile
                                                                      .value
                                                                      .kiloPembakaran!) <
                                                                  0.0
                                                              ? 'Add ${Kalkulator.kaloriPembakaran(kilo: double.parse(controller.getProfile.value.kiloPembakaran!)).abs()} kcal/day'
                                                              : double.parse(controller
                                                                          .getProfile
                                                                          .value
                                                                          .kiloPembakaran!) ==
                                                                      0.0
                                                                  ? 'No change'
                                                                  : 'Subtract ${Kalkulator.kaloriPembakaran(kilo: double.parse(controller.getProfile.value.kiloPembakaran!)).abs()} kcal/day',
                                                          style: Font.regular(
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                        subtitle: teksLanguage(
                                                          double.parse(controller
                                                                      .getProfile
                                                                      .value
                                                                      .kiloPembakaran!) <
                                                                  0.0
                                                              ? 'Weight gain of 1 kg in 4 weeks'
                                                              : double.parse(controller
                                                                          .getProfile
                                                                          .value
                                                                          .kiloPembakaran!) ==
                                                                      0.0
                                                                  ? 'No change in 4 weeks'
                                                                  : 'Weight loss of ${double.parse(controller.getProfile.value.kiloPembakaran!)} kg in 4 weeks',
                                                          style: Font.regular(
                                                            fontSize: 13.0,
                                                            color: Colors.grey,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                items: controller.defisitKalori
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem(
                                                        value: item,
                                                        child: ListTile(
                                                          title: teksLanguage(
                                                            item < 0.0
                                                                ? 'Add ${Kalkulator.kaloriPembakaran(kilo: item).abs()} kcal/day'
                                                                : item == 0.0
                                                                    ? 'No change'
                                                                    : 'Subtract ${Kalkulator.kaloriPembakaran(kilo: item).abs()} kcal/day',
                                                            style: Font.regular(
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          subtitle:
                                                              teksLanguage(
                                                            item < 0.0
                                                                ? 'Weight gain of 1 kg in 4 weeks'
                                                                : item == 0.0
                                                                    ? 'No change in 4 weeks'
                                                                    : 'Weight loss of $item kg in 4 weeks',
                                                            style: Font.regular(
                                                              fontSize: 13.0,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          trailing: item ==
                                                                  Kalkulator
                                                                      .nilaiKiloPembakaran()
                                                              ? const ImageIcon(
                                                                  AssetImage(
                                                                    IconApp
                                                                        .recommend,
                                                                  ),
                                                                )
                                                              : null,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) async {
                                                  await Storages.setProfile(
                                                    height: controller
                                                            .getProfile
                                                            .value
                                                            .height ??
                                                        '',
                                                    weight: controller
                                                            .getProfile
                                                            .value
                                                            .weight ??
                                                        '',
                                                    age: controller.getProfile
                                                            .value.age ??
                                                        '',
                                                    isMan: controller.getProfile
                                                            .value.isMan ??
                                                        false,
                                                    kiloPembakaran:
                                                        value.toString(),
                                                  );
                                                },
                                                buttonStyleData:
                                                    const ButtonStyleData(
                                                  height: 60,
                                                  padding: EdgeInsets.only(
                                                      left: 0, right: 10),
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: ImageIcon(AssetImage(
                                                      IconApp.arrowDown)),
                                                  iconSize: 20,
                                                  openMenuIcon: ImageIcon(
                                                    AssetImage(IconApp.arrowUp),
                                                    color: Warna.primary,
                                                  ),
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                              const Text(""),
                                              TextButton(
                                                onPressed: () {},
                                                child: teksLanguage(
                                                  "${controller.getBahasa.value == 'id' ? 'AMB' : 'BMR'} = ${controller.getProfile.value.isMan == true ? '655.1 + (9.563 * weight) + (1.850 * height) + (4.676 * age)' : '66.5 + (13.75 * weight) + (5.003 * height) + (6.775 * age)'}",
                                                  style: Font.regular(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Obx(
                                                () {
                                                  return Column(
                                                    children: [
                                                      Text(
                                                        "${controller.getBahasa.value == 'id' ? 'AMB' : 'BMR'} = ${controller.getProfile.value.kkt} kcal",
                                                        style: Font.regular(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        "${controller.getBahasa.value == 'id' ? 'Defisit Kalori' : 'Deficit Calorie'} = ${controller.getProfile.value.kaloriPembakaran} kcal",
                                                        style: Font.regular(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const Text(""),
                                                      TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          controller.getBahasa
                                                                      .value !=
                                                                  'id'
                                                              ? 'Calories In = BMR - Calorie Deficit'
                                                              : 'Kalori Masuk = AMB - Defisit Kalori',
                                                          style: Font.regular(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${controller.getBahasa.value != 'id' ? 'Calorie In' : 'Kalori Masuk'} = ${double.parse(controller.getProfile.value.kkt ?? '0') - double.parse(controller.getProfile.value.kaloriPembakaran ?? '0')} kcal",
                                                        style: Font.regular(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const Text(""),
                                                      teksLanguage(
                                                        double.parse(controller
                                                                    .getProfile
                                                                    .value
                                                                    .kiloPembakaran!) <
                                                                0.0
                                                            ? 'Weight gain of 1 kg in 4 weeks'
                                                            : double.parse(controller
                                                                        .getProfile
                                                                        .value
                                                                        .kiloPembakaran!) ==
                                                                    0.0
                                                                ? 'No change in 4 weeks'
                                                                : 'Weight loss of ${double.parse(controller.getProfile.value.kiloPembakaran!)} kg in 4 weeks',
                                                        style: Font.regular(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () => Get.back(),
                                        child: const ImageIcon(
                                          AssetImage(IconApp.close),
                                          size: 20.0,
                                        ),
                                      )
                                    ]);
                              },
                              child: Card(
                                key: keyBMR,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    width: 1.5,
                                    color: Warna.baseWhite,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        controller.getBahasa.value == 'id'
                                            ? 'Kebutuhan Kalori'
                                            : 'Calorie Needs',
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
                                        isMan:
                                            controller.getProfile.value.isMan!,
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
                        ),
                      ],
                    ),
                    controller.getGenerate.isNotEmpty
                        ? controller.getGenerate[Kalkulator.timeNow] != null
                            ? Column(
                                children: [
                                  // Row(
                                  //   children: [1008, 1003, 1004, 1005].map(
                                  //     (nutrientId) {
                                  //       List<Foods> dataGenerate =
                                  //           (controller.getGenerate[
                                  //                   Kalkulator.timeNow] as List)
                                  //               .map((e) => Foods.fromJson(e))
                                  //               .toList();
                                  //       double nilai = 0;
                                  //       dataGenerate.map((e) {
                                  //         double value = e.servingSize !=
                                  //                     null &&
                                  //                 e.servingSizeUnit != null
                                  //             ? Kalkulator.porsi(
                                  //                 size: e.servingSize ?? 100,
                                  //                 value: e.foodNutrients!
                                  //                         .firstWhere(
                                  //                           (data) =>
                                  //                               data.nutrientId ==
                                  //                               nutrientId,
                                  //                           orElse: () =>
                                  //                               FoodNutrients(
                                  //                                   value: 0),
                                  //                         )
                                  //                         .value ??
                                  //                     0)
                                  //             : (e.foodNutrients!
                                  //                     .firstWhere(
                                  //                       (data) =>
                                  //                           data.nutrientId ==
                                  //                           nutrientId,
                                  //                       orElse: () =>
                                  //                           FoodNutrients(
                                  //                               value: 0),
                                  //                     )
                                  //                     .value ??
                                  //                 0);
                                  //         nilai += value;
                                  //       }).toList();
                                  //       return Expanded(
                                  //         child: AspectRatio(
                                  //           aspectRatio: 1,
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(3),
                                  //             child: Card(
                                  //               shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(15),
                                  //                 side: const BorderSide(
                                  //                   color: Colors.grey,
                                  //                   width: 1.5,
                                  //                 ),
                                  //               ),
                                  //               color: Colors.black,
                                  //               child: Column(
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment
                                  //                         .stretch,
                                  //                 children: [
                                  //                   Padding(
                                  //                     padding:
                                  //                         const EdgeInsets.only(
                                  //                             top: 8),
                                  //                     child: teksLanguage(
                                  //                       dataGenerate.first
                                  //                               .foodNutrients!
                                  //                               .firstWhere(
                                  //                                 (data) =>
                                  //                                     data.nutrientId ==
                                  //                                     nutrientId,
                                  //                                 orElse: () =>
                                  //                                     FoodNutrients(
                                  //                                         nutrientName:
                                  //                                             'null'),
                                  //                               )
                                  //                               .nutrientName ??
                                  //                           'null',
                                  //                       style: Font.regular(
                                  //                         color:
                                  //                             Warna.baseWhite,
                                  //                         fontSize: 10.0,
                                  //                         fontWeight:
                                  //                             FontWeight.w500,
                                  //                       ),
                                  //                       maxLines: 1,
                                  //                       overflow: TextOverflow
                                  //                           .ellipsis,
                                  //                       textAlign:
                                  //                           TextAlign.center,
                                  //                     ),
                                  //                   ),
                                  //                   const Divider(),
                                  //                   Expanded(
                                  //                     child: Center(
                                  //                       child: AutoSizeText(
                                  //                         nilai.toStringAsFixed(
                                  //                             2),
                                  //                         style: Font.number(
                                  //                           color:
                                  //                               Warna.secondary,
                                  //                           fontSize: 50,
                                  //                         ),
                                  //                         maxLines: 1,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Text(
                                  //                     dataGenerate.first
                                  //                             .foodNutrients!
                                  //                             .firstWhere(
                                  //                               (data) =>
                                  //                                   data.nutrientId ==
                                  //                                   nutrientId,
                                  //                               orElse: () =>
                                  //                                   FoodNutrients(
                                  //                                       unitName:
                                  //                                           'null'),
                                  //                             )
                                  //                             .unitName ??
                                  //                         'null',
                                  //                     style: Font.regular(
                                  //                       color: Warna.secondary,
                                  //                       fontSize: 12.0,
                                  //                       fontWeight:
                                  //                           FontWeight.w500,
                                  //                     ),
                                  //                     textAlign:
                                  //                         TextAlign.center,
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ).toList(),
                                  // ),
                                  Card(
                                    margin: const EdgeInsets.all(5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              teksLanguage(
                                                '- ${(controller.kkt.toInt() - controller.nilaiKcal.toInt()).toStringAsFixed(2)} kcal',
                                                style: Font.number(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: controller.nilaiKcal
                                                    .toInt(),
                                                child: const Divider(
                                                  thickness: 5,
                                                ),
                                              ),
                                              Expanded(
                                                flex: (controller.kkt.toInt() -
                                                    controller.nilaiKcal
                                                        .toInt()),
                                                child: const Divider(
                                                  thickness: 5,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                              "LIST RECOMMENDATIONS FOOD",
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
                                        AnimationLimiter(
                                          child: ListView.builder(
                                            itemCount: controller
                                                .getGenerate[Kalkulator.timeNow]
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              Foods foods = Foods.fromJson(
                                                  controller.getGenerate[
                                                          Kalkulator.timeNow]
                                                      [index]);
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                position: index,
                                                duration:
                                                    const Duration(seconds: 3),
                                                child: SlideAnimation(
                                                  horizontalOffset: 50.0,
                                                  child: FadeInAnimation(
                                                    child: CardFood(
                                                        foods: foods,
                                                        isRecently: true),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                                    'Food recommendations',
                                    style: Font.regular(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              )
                        : Center(
                            child: ElevatedButton.icon(
                              key: keyGenerate,
                              onPressed: () => Get.toNamed(Routes.GENERATE),
                              icon: const ImageIcon(
                                AssetImage(
                                  IconApp.setting,
                                ),
                                size: 24.0,
                              ),
                              label: teksLanguage(
                                'Going to Food recommendations',
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
                    key: keyProfile,
                    label: teksLanguage(
                      'Input Data Profile',
                      style: Font.regular(
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
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              height: 100,
              key: keyFloating,
            ),
          ),
          ExpandableFab(
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
        ],
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void showTutorial1() {
    tutorialCoachMark1.show(context: context);
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
        await Storages.setTutorial(tutorial: TutorialModel(homepage: true));
        Get.toNamed(Routes.INPUTDATA);
      },
      onSkip: () async {
        await Storages.setTutorial(tutorial: TutorialModel(homepage: true));
      },
    );
  }

  void createTutorial1() {
    tutorialCoachMark1 = TutorialCoachMark(
      targets: _createTargets1(),
      textStyleSkip: Font.regular(),
      textSkip: 'SKIP >>',
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () async {
        await Storages.setTutorial(tutorial: TutorialModel(finish: true));
        Get.toNamed(Routes.GENERATE);
      },
      onSkip: () async {
        await Storages.setTutorial(tutorial: TutorialModel(finish: true));
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Translate",
        keyTarget: keyTranslate,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return teksLanguage(
                "Translate button:\nUsed to select the language to be displayed on each slide. The default language is determined by your mobile phone.",
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
        identify: "floating",
        keyTarget: keyFloating,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Menu button:\nUsed to select various available menus.",
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
        identify: "Profile",
        keyTarget: keyProfile,
        color: Colors.red,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Profile button:\nUsed to input data such as weight, height, age, etc., in order to determine the user's BMR (Basal Metabolic Rate) and suitable calorie deficit.",
                style: Font.regular(
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }

  List<TargetFocus> _createTargets1() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "BMI",
        keyTarget: keyBMI,
        shape: ShapeLightFocus.RRect,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return teksLanguage(
                "BMI Chart:\nTo display the user's BMI chart and the corresponding results of their BMI.",
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
        identify: "BMR",
        keyTarget: keyBMR,
        shape: ShapeLightFocus.RRect,
        alignSkip: Alignment.topRight,
        color: Warna.primary,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return teksLanguage(
                "BMR Chart:\nTo display the user's BMR chart and the results of subtracting the user's BMR with their calorie deficit.",
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
        identify: "Generate",
        keyTarget: keyGenerate,
        color: Colors.red,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return teksLanguage(
                "Generate Food Button:\nUsed to organize today's food from the inputted food list, based on the calorie requirements of the user's body calculated by subtracting the desired calorie deficit from the BMR formula.",
                style: Font.regular(
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}
