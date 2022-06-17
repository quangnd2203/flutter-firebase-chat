import 'package:get/get.dart';

import '../ui.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MessageController>(MessageController());
  }
}
