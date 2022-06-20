import 'package:get/get.dart';

import '../ui.dart';

class ContactListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ContactListController>(ContactListController());
  }
}
