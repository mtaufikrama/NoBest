import 'package:get/get.dart';

import '../controllers/inputdata_controller.dart';

class InputdataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputdataController>(
      () => InputdataController(),
    );
  }
}
