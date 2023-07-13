import 'package:get/get.dart';
import 'package:nobes/app/data/model/profile.dart';
import 'package:nobes/app/data/services/public.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  Rx<Profile> getProfile = Publics.controller.getProfile;
  final getBahasa = Publics.controller.getBahasa;
}
