// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../resources/resources.dart';
import '../ui.dart';

class ProfileScreen extends BaseScreen<ProfileController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        children: <Widget>[
          buildInfo(),
          const SizedBox(
            height: 16,
          ),
          buildTab(
            icon: Icons.edit_outlined,
            title: 'profile_edit',
          ),
          buildTab(
            icon: Icons.settings_outlined,
            title: 'profile_setting',
          ),
          buildTab(
            icon: Icons.contact_support_outlined,
            title: 'profile_contact',
          ),
          const SizedBox(
            height: 30,
          ),
          buildTab(
            icon: Icons.logout_outlined,
            iconColor: Colors.red,
            textAlign: TextAlign.center,
            textStyle: AppTextStyles.normalBold
                .copyWith(fontSize: 20, color: Colors.red),
            title: 'profile_logout',
          ),
        ],
      ),
    );
  }

  Widget buildInfo() {
    return WidgetUserBuilder(
      userBuilder: (UserModel? user) {
        return Column(
          children: <Widget>[
            buildImages(),
            const SizedBox(
              height: 4,
            ),
            Text(
              user!.name!,
              style: AppTextStyles.normalBold.copyWith(fontSize: 24),
            ),
          ],
        );
      },
    );
  }

  Widget buildImages() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(
                    AppImages.jpg('anhnen'),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: buildButtonEditAvatar(
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.black.withOpacity(0.05),
                    onTap: () => null,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.jpg('anhnen'),
                          width: double.maxFinite,
                          height: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: buildButtonEditAvatar(
                    onTap: () => controller.showDialogPickImage(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildButtonEditAvatar({
    Color? borderColor,
    Color? backgroundColor,
    Color? iconColor,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: CircleAvatar(
        backgroundColor: borderColor ?? Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: CircleAvatar(
            backgroundColor: backgroundColor ?? AppColors.greyDark,
            child: Icon(
              Icons.edit_outlined,
              color: iconColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab({
    required IconData icon,
    required String title,
    TextAlign textAlign = TextAlign.left,
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey, width: 0.25),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 25,
                color: iconColor ?? AppColors.text,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  title.tr,
                  style: textStyle ??
                      AppTextStyles.normalSemiBold.copyWith(fontSize: 16),
                  textAlign: textAlign,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Opacity(
                opacity: 0,
                child: Icon(
                  icon,
                  size: 25,
                  color: iconColor ?? AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
