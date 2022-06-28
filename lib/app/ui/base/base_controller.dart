import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    final bool? success =
        await Get.dialog(WidgetDialogConfirm(title: title.tr));
    return success;
  }

  Future<bool?> notification(String title) async {
    return Get.dialog(WidgetDialogNotification(title: title));
  }

  Future<T?> bottomSheet<T>({
    required Widget child,
  }) {
    return showMaterialModalBottomSheet<T>(
      context: Get.context!,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => child,
    );
  }

  void unFocus() {
    Get.focusScope!.unfocus();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: <SystemUiOverlay>[]);
  }
}
