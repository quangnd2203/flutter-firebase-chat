// ignore_for_file: always_specify_types, strict_raw_type

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../resources/resources.dart';

class AppPrefs {
  AppPrefs._();

  static final GetStorage _box = GetStorage('AppPref');

  static final Rx<UserModel?> userBehavior = Rx<UserModel?>(null);

  static final GetStream<bool> notificationConversation = GetStream<bool>();

  static Future<void> initListener() async {
    await GetStorage.init('AppPref');
    _box.listenKey('user', (userModel) {
      userBehavior.value = user;
    });
    _box.listenKey('newConversations', (value) {
      notificationConversation.add(true);
    });
  }

  static set appMode(String? data) => _box.write('appMode', data);

  static String? get appMode => _box.read('appMode');

  static set accessToken(String? data) => _box.write('accessToken', data);

  static String? get accessToken => _box.read('accessToken');

  static set user(UserModel? user) {
    _box.write('user', user?.toJson());
  }

  static UserModel? get user {
    final data = _box.read('user');

    UserModel? model;
    if(data != null){
      model = UserModel.fromJson(_box.read<Map<String,dynamic>>('user')!);
    }
    return model;
  }

  static List<String> get newConversations {
    return List<String>.from(_box.read<List<dynamic>>('newConversations') ?? []);
  }

  static set newConversations(List<String> newConversations){
    _box.write('newConversations', newConversations);
  }
}
