import 'dart:async';
import 'package:get/get.dart';
import '../../resources/resources.dart';
import '../../routes/app_pages.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class NavigationController extends BaseController {

  RxList<TestModel> raw = <TestModel>[].obs;

  RxInt index = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // ignore: avoid_function_literals_in_foreach_calls
  }

  void logout(){
    AppPrefs.accessToken = null;
    AppPrefs.user = null;
    Get.offAllNamed(Routes.LOGIN_REGISTER);
  }
}
