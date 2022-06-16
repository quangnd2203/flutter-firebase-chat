import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../widgets/dialog/dialog.dart';

class BaseController extends GetxController {
  RxBool loading = false.obs;

  void setLoading(bool status) {
    if (status)
      loading.value = true;
    else
      loading.value = false;
  }

  Future<bool?> confirm([String title = 'system_confirm_title']) async {
    final bool? success = await Get.dialog(WidgetDialogConfirm(title: title.tr));
    return success;
  }

  Future<bool?> notification(String title) async {
    return Get.dialog(WidgetDialogNotification(title: title));
  }

  void unFocus() {
    Get.focusScope!.unfocus();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: <SystemUiOverlay>[]);
  }
}
