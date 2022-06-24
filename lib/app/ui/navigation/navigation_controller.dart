// ignore_for_file: always_specify_types, strict_raw_type

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/resources.dart';
import '../../routes/app_pages.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class NavigationController extends BaseController {

  RxList<TestModel> raw = <TestModel>[].obs;

  RxInt index = 0.obs;

  GlobalKey<WidgetSliverLoadMoreVerticalState> messageLoadMoreKey = GlobalKey();

  @override
  Future<void> onInit() async {
    super.onInit();
    // ignore: avoid_function_literals_in_foreach_calls
  }

  void logout(){
    UserRepositoryHelper().updateFcmToken('', updateClause: "uid='${AppPrefs.user!.uid!}'");
    AppPrefs.accessToken = null;
    AppPrefs.user = null;
    Get.offAndToNamed(Routes.LOGIN_REGISTER);
  }
}
