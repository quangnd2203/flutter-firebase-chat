import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import '../../resources/resources.dart';
import '../../utils/app_pref.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class ProfileController extends BaseController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> showDialogPickImage([bool isAvatar = true]) async {
    File? file = await bottomSheet<File>(
      child: WidgetDialogImagePicker(),
    );
    if (file != null) {
      final CroppedFile? imageCropper = await AppUtils.cropImage(
        file.path,
        cropStyle: isAvatar ? CropStyle.circle : CropStyle.rectangle,
        ratioY: isAvatar ? 4 : 3,
      );
      if (imageCropper != null) {
        file = File(imageCropper.path);
        final String fileName = '${isAvatar ? 'avatar' : 'background'}-${AppPrefs.user!.uid!}.jpg';
        final String newPath = path.join(path.dirname(file.path), fileName);
        file = file.renameSync(newPath);
        await UserRepository().uploadUserMedia(file, isAvatar: isAvatar);
      }
    }
  }
}
