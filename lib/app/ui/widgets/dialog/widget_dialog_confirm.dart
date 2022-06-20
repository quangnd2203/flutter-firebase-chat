import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';

class WidgetDialogConfirm extends StatelessWidget {

  const WidgetDialogConfirm({Key? key, required this.title}) : super(key: key);
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
            children: <Widget>[
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(result: false),
                      child: Container(
                        height: 40,
                        color: AppColors.primary,
                        child: Center(
                          child: Text(
                            'home_skip'.tr,
                            style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 1.2,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(result: true),
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
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
