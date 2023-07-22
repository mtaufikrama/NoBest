import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_list.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../data/model/tutorial.dart';
import '../../../data/services/getstorages.dart';
import '../controllers/searchs_controller.dart';

class SearchsView extends StatefulWidget {
  const SearchsView({super.key});

  @override
  State<SearchsView> createState() => _SearchsViewState();
}

class _SearchsViewState extends State<SearchsView> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keySearch = GlobalKey();
  GlobalKey keySend = GlobalKey();
  GlobalKey keyHistory = GlobalKey();

  final controller = Get.put(SearchsController());

  @override
  void initState() {
    if (controller.getTutorial.value.profile != true) {
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
          'Search Food',
          style: Font.regular(),
        ),
        centerTitle: true,
        leading: Publics.leading,
      ),
      body: RefreshPage(
        routes: Routes.SEARCH,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      label: teksLanguage(
                        "Search Food",
                        style: Font.regular(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Warna.primary,
                        ),
                      ),
                    ),
                    onEditingComplete: controller.onSubmit,
                  ),
                ),
                IconButton(
                  onPressed: controller.onSubmit,
                  icon: const ImageIcon(
                    AssetImage(
                      IconApp.send,
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              return ListView.builder(
                itemCount: controller.getSearch.length,
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await controller.onSearch(controller.getSearch[index]);
                    },
                    child: Card(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          controller.getSearch[index].toString(),
                          style: Font.regular(
                            fontSize: 15.0,
                            color: Warna.baseWhite,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
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
        await Storages.setTutorial(tutorial: TutorialModel(profile: true));
        Get.offNamed(Routes.HOME);
      },
      onSkip: () async {
        await Storages.setTutorial(tutorial: TutorialModel(profile: true));
        Get.offNamed(Routes.HOME);
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Foto",
        keyTarget: keySearch,
        alignSkip: Alignment.topRight,
        color: Warna.primary,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Profile photo:To display the user's photo.",
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
        identify: "Form",
        shape: ShapeLightFocus.RRect,
        keyTarget: keySend,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Profile Data:\nDisplaying user data that has been inputted on the data input page.",
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
        identify: "Back",
        keyTarget: keyHistory,
        color: Warna.primary,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return teksLanguage(
                "Back To Home Page",
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

class ListFoodWidget extends StatelessWidget {
  const ListFoodWidget({
    super.key,
    required this.datas,
  });

  final List<USDAList> datas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: datas.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        USDAList data = datas[index];
        double kalori = (data.foodNutrients!
                    .firstWhere(
                      (data) =>
                          data.unitName == 'KCAL' && data.name == 'Energy',
                      orElse: () => FoodNutrients(amount: 0),
                    )
                    .amount ??
                0)
            .toDouble();
        return Card(
          child: ListTile(
            leading: Text(kalori.toString()),
            title: Text(data.description!),
            subtitle: Text(data.publicationDate!),
          ),
        );
      },
    );
  }
}
