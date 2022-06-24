import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../../routes/app_pages.dart';
import '../ui.dart';

class SplashController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await getConfig();
    await getProfile();
  }

  Future<void> getConfig() async {}

  Future<void> getProfile() async {
    final NetworkState<UserModel?> networkState = await UserRepository().authenticationUser();
    if (networkState.isSuccess) {
      Get.offAndToNamed(Routes.NAVIGATION);
    } else {
      Get.offAndToNamed(Routes.LOGIN_REGISTER);
    }
  }
}
