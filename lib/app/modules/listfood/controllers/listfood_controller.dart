import 'package:get/get.dart';
import 'package:nobes/app/data/services/public.dart';

class ListfoodController extends GetxController {
  //TODO: Implement ListfoodController

  final query = Get.parameters['query'];
  final getRecently = Publics.controller.getRecommend;
}
