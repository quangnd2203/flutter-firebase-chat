import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class LoginRegisterController extends BaseController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final UserRepository userRepository = UserRepository();
  final GlobalKey<FormState> formKey = GlobalKey();
  final RxBool isRegister = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void clearTextField() {
    userNameController.text = '';
    passwordController.text = '';
    rePasswordController.text = '';
    formKey.currentState!.reset();
  }

  void changeStateLoginRegister() {
    isRegister.value = !isRegister.value;
    clearTextField();
  }

  Future<void> registerAccount() async {
    if(formKey.currentState!.validate()) {
      final dynamic next = await confirm();
      if (next == true) {
        setLoading(true);
        final NetworkState<UserModel?> networkState = await userRepository.register(
          email: userNameController.text,
          password: passwordController.text,
        );
        setLoading(false);
        if (networkState.isSuccess) {
          AppUtils.toast('Success');
        } else {
          notification(networkState.message!);
        }
      }
    }
  }

  Future<void> loginNormal() async {
    if(formKey.currentState!.validate()) {
      setLoading(true);
      final NetworkState<UserModel?> networkState = await userRepository.loginNormal(
        email: userNameController.text,
        password: passwordController.text,
      );
      setLoading(false);
      if (networkState.isSuccess) {
        AppUtils.toast('Success');
      } else {
        notification(networkState.message!);
      }
    }
  }
}
