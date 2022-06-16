// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../ui.dart';

class LoginRegisterScreen extends BaseScreen<LoginRegisterController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: SafeArea(
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                AppImages.png('app_icon'),
                scale: 3,
              ),
              const SizedBox(
                height: 50,
              ),
            ] +
            (controller.isRegister.value ? buildRegister() : buildLogin()),
      ),
    );
  }

  List<Widget> buildLogin() {
    return <Widget>[
      Text(
        'login'.tr.toUpperCase(),
        style: AppTextStyles.normalBold.copyWith(fontSize: 28),
      ),
      const SizedBox(
        height: 32,
      ),
      WidgetInput(
        controller: controller.userNameController,
        labelText: 'login_username'.tr,
        hintText: 'example@gmail.com',
        obscureText: true,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.passwordController,
        labelText: 'login_password'.tr,
        hintText: 'Asdf1234!',
        obscureText: true,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetButton(
        labelText: 'login'.tr,
        onPressed: () => null,
      ),
      const SizedBox(
        height: 16,
      ),
      buildRichText(
        label: 'login_not_account'.tr,
        keyAction: 'register'.tr,
      ),
    ];
  }

  List<Widget> buildRegister() {
    return <Widget>[
      Text(
        'register'.tr.toUpperCase(),
        style: AppTextStyles.normalBold.copyWith(fontSize: 28),
      ),
      const SizedBox(
        height: 32,
      ),
      WidgetInput(
        controller: controller.userNameController,
        labelText: 'login_username'.tr,
        hintText: 'example@gmail.com',
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.passwordController,
        labelText: 'login_password'.tr,
        hintText: 'Asdf1234!',
        obscureText: true,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.rePasswordController,
        labelText: 'register_re_password'.tr,
        hintText: 'Asdf1234!',
        obscureText: true,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetButton(
        labelText: 'register'.tr,
        onPressed: controller.registerAccount,
      ),
      const SizedBox(
        height: 16,
      ),
      buildRichText(
        label: 'login_have_account'.tr,
        keyAction: 'login'.tr,
      ),
    ];
  }

  Widget buildRichText({
    required String label,
    required String keyAction,
  }) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$label. ',
            style: AppTextStyles.normal,
          ),
          WidgetSpan(
            child: InkWell(
              onTap: controller.changeStateLoginRegister,
              child: Text(
                keyAction,
                style: AppTextStyles.normalSemiBold.copyWith(decoration: TextDecoration.underline, color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
