// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class LoginRegisterScreen extends BaseScreen<LoginRegisterController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
                Image.asset(
                  AppImages.png('app_icon'),
                  scale: 7,
                ),
              ] +
              (controller.isRegister.value ? buildRegister() : buildLogin()) +
              <Widget>[
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'login_social_another'.tr,
                  style: AppTextStyles.normal,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildLoginSocialItem('login_google', SocialType.google),
                    const SizedBox(
                      width: 16,
                    ),
                    buildLoginSocialItem('login_facebook', SocialType.facebook),
                  ],
                )
              ],
        ),
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
        labelText: 'login_email'.tr,
        hintText: 'example@gmail.com',
        validator: AppValid.validateEmail,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.passwordController,
        labelText: 'login_password'.tr,
        hintText: 'Asdf1234!',
        obscureText: true,
        validator: AppValid.validatePassword,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetButton(
        labelText: 'login'.tr,
        onPressed: controller.loginNormal,
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
        labelText: 'login_email'.tr,
        hintText: 'example@gmail.com',
        validator: AppValid.validateEmail,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.nameController,
        labelText: 'login_name'.tr,
        hintText: 'example1234',
        validator: AppValid.validateFullName,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.passwordController,
        labelText: 'login_password'.tr,
        hintText: 'Asdf1234!',
        obscureText: true,
        validator: AppValid.validatePassword,
      ),
      const SizedBox(
        height: 16,
      ),
      WidgetInput(
        controller: controller.rePasswordController,
        labelText: 'register_re_password'.tr,
        hintText: 'Asdf1234!',
        obscureText: true,
        validator: (String? value) => AppValid.validatePasswordConfirm(
            controller.passwordController, value),
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
                style: AppTextStyles.normalSemiBold.copyWith(
                    decoration: TextDecoration.underline,
                    color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginSocialItem(String image, SocialType type) {
    return GestureDetector(
      onTap: () => controller.loginSocial(type),
      child: Image.asset(
        AppImages.png(image),
        scale: 1.75,
      ),
    );
  }
}
