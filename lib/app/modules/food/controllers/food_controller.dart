import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_fdcid.dart';

class FoodController extends GetxController {
  //TODO: Implement FoodController

  final fdcid = Get.parameters['fdcid'];
  String link(USDAFdcId usdaFdcId) =>
      'https://www.google.com/search?q=${usdaFdcId.brandName ?? usdaFdcId.brandOwner ?? ''} ${usdaFdcId.description}&tbm=isch&ved=2ahUKEwiA4uvi29D-AhVPg2MGHfFkBt0Q2-cCegQIABAC';
  final servingSize = 100.obs;
}
