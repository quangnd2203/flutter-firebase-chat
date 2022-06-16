import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../notification/firebase_messaging.dart';
import '../resources.dart';

class UserRepository {

  factory UserRepository() {
    _instance ??= UserRepository._();
    return _instance!;
  }
  UserRepository._();

  static UserRepository? _instance;

  Future<NetworkState<UserModel?>> register({required String email, required String password, String? accountType}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel?>.withDisconnect();
    }
    try {
      final DataQueryBuilder query = DataQueryBuilder();
      query.properties = <String>['uid', 'name', 'email'];
      query.havingClause = "email='$email'";
      final bool userNotExist = (await UserDao().read(queryBuilder: query)).isEmpty;
      UserModel? userModel;
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
}
