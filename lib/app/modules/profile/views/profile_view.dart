import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyTranslate = GlobalKey();
  GlobalKey keyProfile = GlobalKey();
  GlobalKey keyFloating = GlobalKey();

  final controller = Get.put(ProfileController());

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
          'Profile',
          style: Font.regular(),
        ),
        centerTitle: true,
        leading: Publics.leading,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.INPUTDATA),
            icon: const ImageIcon(
              AssetImage(
                IconApp.edit,
              ),
            ),
          ),
        ],
      ),
      body: RefreshPage(
        routes: Routes.PROFILE,
        child: ListView(
          children: [
            SizedBox(
              height: Get.height / 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          image: controller.getProfile.value.image != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(controller.getProfile.value.image!),
                                  ),
                                )
                              : const DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(IconApp.user),
                                ),
                          color: Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    teksLanguage(
                      'Name',
                      style: Font.regular(fontSize: 18),
                    ),
                    teksLanguage(
                      'Height',
                      style: Font.regular(fontSize: 18),
                    ),
                    teksLanguage(
                      'Weight',
                      style: Font.regular(fontSize: 18),
                    ),
                    teksLanguage(
                      'Age',
                      style: Font.regular(fontSize: 18),
                    ),
                    teksLanguage(
                      'Gender',
                      style: Font.regular(fontSize: 18),
                    ),
                    // Text(
                    //   'PAL',
                    //   style: Font.regular(fontSize: 18),
                    // ),
                    Text(
                      controller.getBahasa.value == 'en' ? 'BMI' : 'IMT',
                      style: Font.regular(fontSize: 18),
                    ),
                    Text(
                      controller.getBahasa.value == 'en' ? 'TDEE' : 'KKT',
                      style: Font.regular(fontSize: 18),
                    ),
                    teksLanguage(
                      'Deficit Calorie',
                      style: Font.regular(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ": ${controller.getProfile.value.name ?? 'null'}",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          ": ${controller.getProfile.value.height ?? 'null'} cm",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          ": ${controller.getProfile.value.weight ?? 'null'} kg",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        teksLanguage(
                          ": ${controller.getProfile.value.age ?? 'null'} years old",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        teksLanguage(
                          ": ${controller.getProfile.value.isMan == true ? 'Man' : 'female'}",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // teksLanguage(
                        //   ": ${controller.getProfile.value.pal} ➜ ${Kalkulator.kategoriPAL()}",
                        //   style: Font.regular(fontSize: 18),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        teksLanguage(
                          ": ${Kalkulator.kategoriIMT()}",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        teksLanguage(
                          ": ${controller.getProfile.value.kkt}",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        teksLanguage(
                          ": ${double.parse(controller.getProfile.value.kaloriPembakaran!).toInt() * -1} calorie",
                          style: Font.regular(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
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
      textSkip: 'SKIP >>',
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Profile",
        keyTarget: keyProfile,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation2",
        keyTarget: keyFloating,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation3",
        keyTarget: keyTranslate,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: Font.regular(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}
