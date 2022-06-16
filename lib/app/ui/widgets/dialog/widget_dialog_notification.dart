import 'package:flutter/material.dart';import 'package:get/get.dart';
import '../../../constants/constants.dart';

class WidgetDialogNotification extends StatelessWidget {

  const WidgetDialogNotification({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width - 56,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                style: AppTextStyles.normalBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  height: 40,
                  color: AppColors.primary,
                  child: Center(
                    child: Text(
                      'home_agree'.tr,
                      style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
