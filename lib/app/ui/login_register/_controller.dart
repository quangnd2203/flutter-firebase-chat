import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_utils.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class LoginRegisterController extends BaseController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final UserRepository userRepository = UserRepository();
  final GlobalKey<FormState> formKey = GlobalKey();
  final RxBool isRegister = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await createUser();
  }

  void clearTextField() {
    userNameController.text = '';
    passwordController.text = '';
    rePasswordController.text = '';
    formKey.currentState!.reset();
  }

  void changeStateLoginRegister() {
    unFocus();
    isRegister.value = !isRegister.value;
    clearTextField();
  }

  Future<void> registerAccount() async {
    unFocus();
    if(formKey.currentState!.validate()) {
      final dynamic next = await confirm();
      if (next == true) {
        setLoading(true);
        final NetworkState<UserModel?> networkState = await userRepository.register(
          email: userNameController.text,
          password: passwordController.text,
          name: nameController.text,
        );
        setLoading(false);
        if (networkState.isSuccess) {
          AppUtils.toast('Success');
          Get.offAllNamed(Routes.NAVIGATION);
        } else {
          notification(networkState.message!);
        }
      }
    }
  }

  Future<void> loginNormal() async {
    unFocus();
    if(formKey.currentState!.validate()) {
      setLoading(true);
      final NetworkState<UserModel?> networkState = await userRepository.loginNormal(
        email: userNameController.text,
        password: passwordController.text,
      );
      setLoading(false);
      if (networkState.isSuccess) {
        AppUtils.toast('Success');
        Get.offAllNamed(Routes.NAVIGATION);
      } else {
        notification(networkState.message!);
      }
    }
  }

  Future<void> loginSocial(SocialType type) async {
    LoginSocialResult? loginSocialResult;

    switch(type){
      case SocialType.google:
        loginSocialResult = await SocialService().signInGoogle();
        break;
      case SocialType.facebook:
        loginSocialResult = await SocialService().signInFacebook();
        break;
      case SocialType.twitter:
        break;
      case SocialType.apple:
        break;
    }

    if(loginSocialResult?.id != null){
      setLoading(true);
      final NetworkState<UserModel?> networkState = await userRepository.loginSocial(loginSocialResult!, type);
      setLoading(false);
      if (networkState.isSuccess) {
        AppUtils.toast('Success');
        Get.offAllNamed(Routes.NAVIGATION);
      } else {
        notification(networkState.message!);
      }
    }
  }

  // Future<void> createUser() async {
  //   for(int i = 0; i < 1; i++){
  //     UserRepository().register(email: AppEmail().createEmail(), password: 'Aa22032001!', name: AppEmail().createEmail());
  //   }
  // }
}
