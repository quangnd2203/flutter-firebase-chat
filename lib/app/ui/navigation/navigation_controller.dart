// ignore_for_file: always_specify_types, strict_raw_type

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../notification/firebase_messaging.dart';
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
    FirebaseCloudMessaging.subscribeToTopic('conversation-${AppPrefs.user!.uid!}');
  }

  Future<void> logout() async {
    UserRepositoryHelper().updateFcmToken('', updateClause: "uid='${AppPrefs.user!.uid!}'");
    FirebaseCloudMessaging.unSubscribeFromTopic('conversation-${AppPrefs.user!.uid!}');
    Get.offAndToNamed(Routes.LOGIN_REGISTER);
    await Future.delayed(const Duration(milliseconds: 500));
    AppPrefs.accessToken = null;
    AppPrefs.user = null;
  }
}
