import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/kalkulasi.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/card_food.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';

import '../controllers/finishgenerate_controller.dart';

class FinishgenerateView extends GetView<FinishgenerateController> {
  const FinishgenerateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: teksLanguage(
          'Finish Generate Food',
          style: Font.regular(),
        ),
        centerTitle: true,
      ),
      body: RefreshPage(
        routes: Routes.FINISHGENERATE,
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: controller.getGenerate[Kalkulator.timeNow].length,
            itemBuilder: (context, index) {
              Foods foods = Foods.fromJson(
                  controller.getGenerate[Kalkulator.timeNow][index]);
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(seconds: 3),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: CardFood(foods: foods, isRecently: true),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
