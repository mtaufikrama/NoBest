import 'package:get/get.dart';

import '../controllers/finishgenerate_controller.dart';

class FinishgenerateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinishgenerateController>(
      () => FinishgenerateController(),
    );
  }
}
