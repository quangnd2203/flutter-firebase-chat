import 'package:get/get.dart';

import '../ui.dart';

class LoginRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginRegisterController>(LoginRegisterController());
  }
}
