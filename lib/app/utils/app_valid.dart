import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppValid {
  AppValid._();
  
  static String? validateFullName(String? value) {
    if (value?.isEmpty ?? true) {
      return 'valid_enter'.tr;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'valid_enter'.tr;
    } else {
      final RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regex.hasMatch(value!))
        return 'valid_email'.tr;
      else
        return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'valid_password'.tr;
    } else {
      final RegExp regex = RegExp(r'^[0-9a-zA-Z!@#\$&*~]{6,}$');
      if (!regex.hasMatch(value))
        return 'valid_password'.tr;
      else
        return null;
    }
  }

  static String? validatePasswordConfirm(TextEditingController controller, String? value) {
    if (controller.text != value)
      return 'valid_password_confirm'.tr;
    else
      return null;
  }

  static String? validatePhoneNumber(String? value) {
    final RegExp regExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (value?.isEmpty ?? true) {
      return 'valid_enter'.tr;
    } else if (value!.length != 10) {
      return 'valid_phone'.tr;
    } else if (!regExp.hasMatch(value)) {
      return 'valid_phone'.tr;
    } else {
      return null;
    }
  }
}
