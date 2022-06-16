import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../notification/firebase_messaging.dart';
import '../../utils/utils.dart';
import '../resources.dart';

class UserRepository {

  factory UserRepository() {
    _instance ??= UserRepository._();
    return _instance!;
  }
  UserRepository._();

  static UserRepository? _instance;

  final UserRepositoryHelper helper = UserRepositoryHelper();

  Future<NetworkState<UserModel?>> register({required String email, required String password, String? accountType}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel?>.withDisconnect();
    }
    try {
      UserModel? userModel;
      final List<UserModel> listUserExist = await helper.getListUser(
        properties: <String>['uid', 'name', 'email'],
        whereClause: "email='$email'",
      );
      final bool userNotExist = listUserExist.isEmpty;

      if(userNotExist){
        final Map<String, dynamic> data = UserModel(
          uid: BackendService().generateGUID(),
          email: email,
          password: BackendService().convertPasswordTo256(password),
          accountType: accountType,
          fcmToken: await FirebaseCloudMessaging.getFCMToken(),
        ).toJson();
        data.removeWhere((String key, dynamic value) => value == null);
        userModel = await UserDao().save(data: data);
        AppPrefs.user = userModel;
      }
      return NetworkState<UserModel>(
        status: userModel != null ? AppEndpoint.SUCCESS : AppEndpoint.FAILED,
        data: userModel,
        message: (userNotExist && userModel != null) ? 'success' : (userNotExist ? 'system_errors'.tr : 'user_exist'.tr),
      );
    } on Exception catch(e) {
      return NetworkState<UserModel?>.withError(e);
    }
  }

  Future<NetworkState<UserModel?>> loginNormal({required String email, required String password}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel?>.withDisconnect();
    }
    try {
      final List<String> properties = <String>['uid', 'name', 'email', 'isNewUser', 'fcmToken', 'accountType'];
      final String havingClause = "email='$email' && password='${BackendService().convertPasswordTo256(password)}'";

      final List<UserModel> users = await helper.getListUser(
        properties: properties,
        whereClause: havingClause,
      );

      if(users.isNotEmpty){
        users.first.fcmToken = await FirebaseCloudMessaging.getFCMToken();
        await helper.updateFcmToken(users.first.fcmToken!, updateClause: havingClause);
        AppPrefs.user = users.first;
      }

      return NetworkState<UserModel>(
        status: users.isNotEmpty ? AppEndpoint.SUCCESS : AppEndpoint.FAILED,
        data: users.isNotEmpty ? users.first : null,
        message: users.isNotEmpty ? 'success' : 'login_failed'.tr,
      );
    } on Exception catch(e) {
      return NetworkState<UserModel?>.withError(e);
    }
  }
}
