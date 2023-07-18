import 'package:get/get.dart';
import 'package:nobes/app/data/services/public.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final getProfile = Publics.controller.getProfile;
  final getGenerate = Publics.controller.getGenerate;
  final getBahasa = Publics.controller.getBahasa;
  final getTutorial = Publics.controller.getTutorial;

  double get kalori => double.parse(getProfile.value.kaloriPembakaran!);

  Map<String, double> get maxNValue {
    double bmr = double.parse(getProfile.value.kkt!);
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

  double get kkt {
    double kalori = double.parse(getProfile.value.kaloriPembakaran!);
    double kkt = double.parse(getProfile.value.kkt!);
    double value = kkt - kalori;
    return value;
  }
}
