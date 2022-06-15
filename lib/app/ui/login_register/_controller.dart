import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../ui.dart';

class LoginRegisterController extends BaseController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  RxBool isRegister = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void clearTextField(){
    userNameController.text = '';
    passwordController.text = '';
    rePasswordController.text = '';
  }

  void changeStateLoginRegister(){
    isRegister.value = !isRegister.value;
    clearTextField();
  }
}
