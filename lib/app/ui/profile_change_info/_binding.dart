import 'package:get/get.dart';

import '../ui.dart';

class ProfileChangInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileChangInfoController>(ProfileChangInfoController());
  }
}
