import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/constants.dart';

class WidgetDialogImagePicker extends StatelessWidget {
  WidgetDialogImagePicker({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                buildField(
                  'picker_image_gallery',
                  onTap: () => pickImage(ImageSource.gallery),
                ),
                Divider(
                  height: 0,
                  color: AppColors.greyDark,
                ),
                buildField(
                  'picker_image_take_photo',
                  onTap: () => pickImage(ImageSource.camera),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          buildField(
            'close',
            onTap: Get.back,
            textStyle: AppTextStyles.normalBoldBlack
                .copyWith(fontSize: 20, color: AppColors.primary),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildField(
    String title, {
    TextStyle? textStyle,
    Color? backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor ?? Colors.transparent,
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            title.tr,
            style: textStyle ??
                AppTextStyles.normalSemiBold.copyWith(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? xFile = await picker.pickImage(source: source);
    if (xFile != null) {
      final File file = File(xFile.path);
      Get.back(result: file);
    }
  }
}
