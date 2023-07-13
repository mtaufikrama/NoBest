import 'package:get/get.dart';
import 'package:nobes/app/data/services/kategori_pal.dart';
import 'package:nobes/app/data/services/public.dart';

class GenerateController extends GetxController {
  //TODO: Implement GenerateController

  final getProfile = Publics.controller.getProfile;
  final getRecently = Publics.controller.getRecently;
  final pal = [
    KategoriPAL.tidakPernah,
    KategoriPAL.jarang,
    KategoriPAL.normal,
    KategoriPAL.sering,
    KategoriPAL.sangatSering,
  ];
  final defisitKalori = [
    -1.0,
    0.0,
    1.0,
    2.0,
  ];
  Rx<PALModels> get kategoriPAL => pal
      .firstWhere(
        (data) => data.nilai == double.parse(getProfile.value.pal!),
        orElse: () => KategoriPAL.tidakPernah,
      )
      .obs;
  final selectedValue = KategoriPAL.tidakPernah.obs;
  final selectedDeficitValue =
      double.parse(Publics.controller.getProfile.value.kiloPembakaran ?? '0.0')
          .obs;
}
