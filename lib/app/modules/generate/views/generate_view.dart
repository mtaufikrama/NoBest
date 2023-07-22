import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/getstorages.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/card_food.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../data/model/tutorial.dart';
import '../controllers/generate_controller.dart';

class GenerateView extends StatefulWidget {
  const GenerateView({super.key});

  @override
  State<GenerateView> createState() => _GenerateViewState();
}

class _GenerateViewState extends State<GenerateView> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyProfile = GlobalKey();
  GlobalKey keyDeficit = GlobalKey();
  GlobalKey keyListFood = GlobalKey();
  GlobalKey keyFloating = GlobalKey();

  final controller = Get.put(GenerateController());

  @override
  void initState() {
    if (controller.getTutorial.value.generateFood != true) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: teksLanguage(
          'Generate Food',
          style: Font.regular(),
        ),
        centerTitle: true,
        leading: Publics.leading,
      ),
      body: RefreshPage(
        routes: Routes.GENERATE,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Card(
                    key: keyProfile,
                    color: Warna.baseBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        width: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        controller.getProfile.value.height != null
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: teksLanguage(
                                  "Is your current data correct?",
                                  style: Font.regular(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: teksLanguage(
                                  "Profile Data's is Not Available",
                                  style: Font.regular(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                        controller.getProfile.value.height != null
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        teksLanguage(
                                          'height',
                                          style: Font.regular(fontSize: 18),
                                        ),
                                        teksLanguage(
                                          'weight',
                                          style: Font.regular(fontSize: 18),
                                        ),
                                        teksLanguage(
                                          'age',
                                          style: Font.regular(fontSize: 18),
                                        ),
                                        teksLanguage(
                                          'Gender',
                                          style: Font.regular(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Obx(() {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ": ${controller.getProfile.value.height ?? 'null'} cm",
                                            style: Font.regular(fontSize: 18),
                                          ),
                                          Text(
                                            ": ${controller.getProfile.value.weight ?? 'null'} kg",
                                            style: Font.regular(fontSize: 18),
                                          ),
                                          teksLanguage(
                                            ": ${controller.getProfile.value.age ?? 'null'} years old",
                                            style: Font.regular(fontSize: 18),
                                          ),
                                          teksLanguage(
                                            ": ${controller.getProfile.value.isMan == true ? 'Male' : 'Female'}",
                                            style: Font.regular(fontSize: 18),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: ElevatedButton.icon(
                            icon: const ImageIcon(
                              AssetImage(
                                IconApp.edit,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey),
                            onPressed: () => Get.toNamed(Routes.INPUTDATA),
                            label: teksLanguage(
                              "Edit Profile",
                              style: Font.regular(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // DropdownButtonFormField2(
                //   decoration: InputDecoration(
                //     isDense: true,
                //     contentPadding: EdgeInsets.zero,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(25),
                //     ),
                //   ),
                //   isExpanded: true,
                //   hint: controller.getProfile.value.pal == null
                //       ? teksLanguage(
                //           'Select your Physical Activity Level',
                //           style: Font.regular(fontSize: 14),
                //         )
                //       : ListTile(
                //           title: teksLanguage(
                //             controller.kategoriPAL.value.kategori,
                //             style: Font.regular(
                //               fontSize: 14.0,
                //             ),
                //           ),
                //           subtitle: teksLanguage(
                //             controller.kategoriPAL.value.harian,
                //             style: Font.regular(
                //               fontSize: 13.0,
                //               color: Colors.grey,
                //             ),
                //             maxLines: 1,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //           trailing: teksLanguage(
                //             controller.kategoriPAL.value.nilai.toString(),
                //             style: Font.regular(),
                //           ),
                //         ),
                //   items: controller.pal
                //       .map(
                //         (item) => DropdownMenuItem(
                //           value: item,
                //           child: ListTile(
                //             title: teksLanguage(
                //               item.kategori,
                //               style: Font.regular(
                //                 fontSize: 14.0,
                //               ),
                //             ),
                //             subtitle: teksLanguage(
                //               item.harian,
                //               style: Font.regular(
                //                 fontSize: 13.0,
                //                 color: Colors.grey,
                //               ),
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //             trailing: teksLanguage(
                //               item.nilai.toString(),
                //               style: Font.regular(),
                //             ),
                //           ),
                //         ),
                //       )
                //       .toList(),
                //   validator: (value) {
                //     if (value == null) {
                //       return 'Please select Physical Activity Level';
                //     }
                //     return null;
                //   },
                //   onChanged: (value) {
                //     controller.selectedValue.value = value!;
                //   },
                //   buttonStyleData: const ButtonStyleData(
                //     height: 60,
                //     padding: EdgeInsets.only(left: 0, right: 10),
                //   ),
                //   iconStyleData: const IconStyleData(
                //     icon: ImageIcon(AssetImage(IconApp.arrowDown)),
                //     iconSize: 20,
                //     openMenuIcon: ImageIcon(
                //       AssetImage(IconApp.arrowUp),
                //       color: Warna.primary,
                //     ),
                //   ),
                //   dropdownStyleData: DropdownStyleData(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                DropdownButtonFormField2(
                  key: keyDeficit,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  isExpanded: true,
                  hint: controller.getProfile.value.pal == null
                      ? teksLanguage(
                          'Energy Deficit',
                          style: Font.regular(fontSize: 14),
                        )
                      : ListTile(
                          title: teksLanguage(
                            double.parse(controller
                                        .getProfile.value.kiloPembakaran!) <
                                    0.0
                                ? 'Add ${Kalkulator.kaloriPembakaran(kilo: double.parse(controller.getProfile.value.kiloPembakaran!)).abs()} kcal/day'
                                : double.parse(controller.getProfile.value
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
                                        .getProfile.value.kiloPembakaran!) <
                                    0.0
                                ? 'Weight gain of 1 kg in 4 weeks'
                                : double.parse(controller.getProfile.value
                                            .kiloPembakaran!) ==
                                        0.0
                                    ? 'No change in 4 weeks'
                                    : 'Weight loss of ${double.parse(controller.getProfile.value.kiloPembakaran!)} kg in 4 weeks',
                            style: Font.regular(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                  items: controller.defisitKalori
                      .map(
                        (item) => DropdownMenuItem(
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
                            subtitle: teksLanguage(
                              item < 0.0
                                  ? 'Weight gain of 1 kg in 4 weeks'
                                  : item == 0.0
                                      ? 'No change in 4 weeks'
                                      : 'Weight loss of $item kg in 4 weeks',
                              style: Font.regular(
                                fontSize: 13.0,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: item == Kalkulator.nilaiKiloPembakaran()
                                ? const ImageIcon(
                                    AssetImage(
                                      IconApp.recommend,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Physical Activity Level';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.selectedDeficitValue.value = value!;
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    key: keyListFood,
                    color: Warna.baseBlack,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          width: 1.5,
                          color: Colors.white,
                        )),
                    child: controller.getRecently.isNotEmpty
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: teksLanguage(
                                  'Food List',
                                  style: Font.regular(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: controller.getRecently.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  Foods foods = Foods.fromJson(
                                      controller.getRecently[index]);
                                  return CardFood(
                                    foods: foods,
                                    isRecently: true,
                                  );
                                },
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: teksLanguage(
                                    'Food list is Not Available',
                                    style: Font.regular(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  icon: const ImageIcon(
                                    AssetImage(
                                      IconApp.search,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey),
                                  onPressed: () => Get.toNamed(Routes.SEARCH),
                                  label: teksLanguage(
                                    "Add Food List",
                                    style: Font.regular(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: keyFloating,
        child: const ImageIcon(AssetImage(IconApp.send)),
        onPressed: () async {
          if (controller.getProfile.value.height != null &&
              controller.getRecently.isNotEmpty) {
            List<Foods> listFood = controller.getRecently
                .map((element) => Foods.fromJson(element))
                .toList();
            await Storages.setProfile(
              height: controller.getProfile.value.height!,
              weight: controller.getProfile.value.weight!,
              age: controller.getProfile.value.age!,
              isMan: controller.getProfile.value.isMan!,
              kiloPembakaran: controller.selectedDeficitValue.value.toString(),
              pal: controller.selectedValue.value.nilai.toString(),
            );
            List<Foods> foodGenerate =
                Kalkulator.generateKnapSack(foods: listFood);
            await Storages.setGenerate(foods: foodGenerate);
            Get.toNamed(Routes.FINISHGENERATE);
          } else {
            Publics.snackBarFail(
              'Fail to Process',
              '',
            );
          }
        },
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      textStyleSkip: Font.regular(),
      textSkip: 'SKIP >>',
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () async {
        await Storages.setTutorial(tutorial: TutorialModel(generateFood: true));
      },
      onSkip: () async {
        await Storages.setTutorial(tutorial: TutorialModel(generateFood: true));
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Profile",
        shape: ShapeLightFocus.RRect,
        keyTarget: keyProfile,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return teksLanguage(
                "Titulo lorem ipsum",
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
        shape: ShapeLightFocus.RRect,
        radius: 0,
        identify: "Deficit",
        keyTarget: keyDeficit,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Enter name:\nEntering a name is not mandatory, but it will be displayed on the profile page.",
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
        shape: ShapeLightFocus.RRect,
        radius: 0,
        identify: "List Food",
        keyTarget: keyListFood,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Enter weight:\nEntering weight is mandatory as it is used to calculate the user's BMI (Body Mass Index) and BMR (Basal Metabolic Rate).",
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
        radius: 0,
        identify: "Floating",
        keyTarget: keyFloating,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Enter height:\nEntering height is mandatory as it is used to calculate the user's BMI (Body Mass Index) and BMR (Basal Metabolic Rate).",
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
