import 'dart:convert';
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

  String generateGUID([String prefix = 'uid']) {
    final DateTime now = DateTime.now();
    return '$prefix-${now.microsecondsSinceEpoch.toString()}';
  }

  String generateToken(){
    final List<int> bytes = <int>[];
    for(int i = 0; i < 9; i++){
      bytes.addAll(utf8.encode(generateGUID()));
    }
    final String token = base64.encode(bytes);
    return token;
  }
}
