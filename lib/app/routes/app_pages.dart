import 'package:get/get.dart';

import '../modules/finishgenerate/bindings/finishgenerate_binding.dart';
import '../modules/finishgenerate/views/finishgenerate_view.dart';
import '../modules/food/bindings/food_binding.dart';
import '../modules/food/views/food_view.dart';
import '../modules/generate/bindings/generate_binding.dart';
import '../modules/generate/views/generate_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/images/bindings/images_binding.dart';
import '../modules/images/views/images_view.dart';
import '../modules/inputdata/bindings/inputdata_binding.dart';
import '../modules/inputdata/views/inputdata_view.dart';
import '../modules/listfood/bindings/listfood_binding.dart';
import '../modules/listfood/views/listfood_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchs/bindings/searchs_binding.dart';
import '../modules/searchs/views/searchs_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      transition: Transition.noTransition,
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.INPUTDATA,
      page: () => const InputdataView(),
      binding: InputdataBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.GENERATE,
      page: () => const GenerateView(),
      binding: GenerateBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.LISTFOOD,
      page: () => const ListfoodView(),
      binding: ListfoodBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.SEARCH,
      page: () => const SearchsView(),
      binding: SearchsBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FOOD,
      page: () => const FoodView(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: _Paths.IMAGES,
      page: () => const ImagesView(),
      binding: ImagesBinding(),
    ),
    GetPage(
      name: _Paths.FINISHGENERATE,
      page: () => const FinishgenerateView(),
      binding: FinishgenerateBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
