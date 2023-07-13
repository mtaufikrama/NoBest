import 'package:get/get.dart';

import '../controllers/listfood_controller.dart';

class ListfoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListfoodController>(
      () => ListfoodController(),
    );
  }
}
