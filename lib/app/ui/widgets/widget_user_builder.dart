// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/resources.dart';
import '../../utils/utils.dart';

typedef _UserBuilder = Widget Function(UserModel? user);

class WidgetUserBuilder extends StatelessWidget {
  const WidgetUserBuilder({Key? key, required this.userBuilder})
      : super(key: key);

  final _UserBuilder userBuilder;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => userBuilder(AppPrefs.userBehavior.value),
    );
  }
}
