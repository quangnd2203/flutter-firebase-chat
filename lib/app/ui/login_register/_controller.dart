import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../ui.dart';

class LoginRegisterController extends BaseController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  UserRepository userRepository = UserRepository();

  RxBool isRegister = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void clearTextField() {
    userNameController.text = '';
    passwordController.text = '';
    rePasswordController.text = '';
  }

  void changeStateLoginRegister() {
    isRegister.value = !isRegister.value;
    clearTextField();
  }

  Future<void> registerAccount() async {
    final NetworkState<bool?> networkState = await userRepository.register(
      email: userNameController.text,
      password: passwordController.text,
    );
  }
}
