import 'package:get/get.dart';

import '../ui.dart';

class MessageRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MessageRoomController>(MessageRoomController());
  }
}
