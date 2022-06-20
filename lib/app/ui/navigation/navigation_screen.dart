// ignore_for_file: use_key_in_widget_constructors, flutter_style_todos

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../ui.dart';

class NavigationScreen extends BaseScreen<NavigationController> {
  @override
  Widget? builder() {
    // TODO: implement builder
    return Scaffold(
      body: FadeIndexedStack(
        index: controller.index.value,
        duration: const Duration(milliseconds: 300),
        children: <Widget>[
          MessageScreen(),
          ContactListScreen(),
          const SizedBox(),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 32),
        child: CustomNavigationBar(
          scaleFactor: 0.25,
          elevation: 4,
          borderRadius: const Radius.circular(15),
          currentIndex: controller.index.value,
          onTap: (int index) => controller.index.value = index,
          selectedColor: AppColors.text,
          unSelectedColor: AppColors.grey,
          strokeColor: AppColors.grey,
          iconSize: 30,
          items: <CustomNavigationBarItem>[
            CustomNavigationBarItem(
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
