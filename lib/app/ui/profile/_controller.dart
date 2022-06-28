import 'dart:io';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../resources/resources.dart';
import '../ui.dart';

class ProfileController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> showDialogPickImage() async {
    final File? file = await bottomSheet<File>(
      child: WidgetDialogImagePicker(),
    );
    if (file != null) {
      final CroppedFile? imageCropper = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 2),
        cropStyle: CropStyle.circle,
      );
    }
  }
}
