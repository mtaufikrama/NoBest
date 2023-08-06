import 'package:get/get.dart';
import 'package:nobes/app/data/services/public.dart';

import '../../../data/model/usda_search.dart';
import '../../../data/services/kalkulasi.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final getProfile = Publics.controller.getProfile;
  final getGenerate = Publics.controller.getGenerate;
  final getBahasa = Publics.controller.getBahasa;
  final getTutorial = Publics.controller.getTutorial;

  double get kalori => double.parse(getProfile.value.kaloriPembakaran!);

  Map<String, double> get maxNValue {
    double bmr = double.parse(getProfile.value.bmr!);
    double max;
    double value;
    if (kalori > 0.0) {
      max = bmr;
      value = bmr - kalori;
    } else {
      max = bmr - kalori;
      value = bmr;
    }
    Map<String, double> nilai = {'max': max, 'value': value};
    return nilai;
  }

  final defisitKalori = [
    -1.0,
    0.0,
    1.0,
    2.0,
  ];

  final selectedDeficitValue =
      double.parse(Publics.controller.getProfile.value.kiloPembakaran ?? '0.0')
          .obs;

  double get nilaiKcal {
    List<Foods> dataGenerate = (getGenerate[Kalkulator.timeNow] as List)
        .map((e) => Foods.fromJson(e))
        .toList();
    double nilai = 0;
    dataGenerate.map((e) {
      double value = e.servingSize != null && e.servingSizeUnit != null
          ? Kalkulator.porsi(
              size: e.servingSize ?? 100,
              value: e.foodNutrients!
                      .firstWhere(
                        (data) => data.nutrientId == 1008,
                        orElse: () => FoodNutrients(value: 0),
                      )
                      .value ??
                  0)
          : (e.foodNutrients!
                  .firstWhere(
                    (data) => data.nutrientId == 1008,
                    orElse: () => FoodNutrients(value: 0),
                  )
                  .value ??
              0);
      nilai += value;
    }).toList();
    return nilai;
  }
}
