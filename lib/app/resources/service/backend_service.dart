import '../../utils/app_utils.dart';

class BackendService {
  factory BackendService() {
    _instance ??= BackendService._();
    return _instance!;
  }

  BackendService._();

  static BackendService? _instance;

  String convertPasswordTo256(String password) {
    final String result = AppUtils.convertToSha256(password);
    return result;
  }

  String generateGUID() {
    final DateTime now = DateTime.now();
    return 'uid-${now.microsecondsSinceEpoch.toString()}';
  }
}
