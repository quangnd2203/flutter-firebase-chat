import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../notification/firebase_messaging.dart';
import '../../utils/app_utils.dart';
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

  Future<NetworkState<UserModel?>> register({required String email, required String password, required String name, String? accountType}) async {
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

      final String? fcmToken = await FirebaseCloudMessaging.getFCMToken();
      final String accessToken = BackendService().generateToken();
      final String uid = BackendService().generateGUID();
      final String passwordEncode = BackendService().convertPasswordTo256(password);

      if(userNotExist){
        userModel = await helper.saveUser(
            UserModel(
            uid: uid,
            name: name,
            email: email,
            isNewUser: false,
            accessToken: accessToken,
            password: passwordEncode,
            accountType: accountType,
            fcmToken: fcmToken,
          ),
        );
        if(userModel != null){
          userModel.fcmToken = null;
          userModel.password = null;
          userModel.accessToken = null;
          await helper.updateFcmToken(fcmToken!, updateClause: "email='$email'");

          AppPrefs.user = userModel;
          AppPrefs.accessToken = accessToken;
        }
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
      final String havingClause = "email='$email' && password='${BackendService().convertPasswordTo256(password)}'";

      final List<UserModel> users = await helper.getListUser(
        whereClause: havingClause,
      );

      if(users.isNotEmpty){
        final String? fcmToken = await FirebaseCloudMessaging.getFCMToken();
        final String accessToken = BackendService().generateToken();
        await helper.updateFcmToken(fcmToken!, updateClause: havingClause);
        await helper.updateAccessToken(accessToken, updateClause: havingClause);
        AppPrefs.user = users.first;
        AppPrefs.accessToken = accessToken;
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

  Future<NetworkState<UserModel?>> loginSocial(LoginSocialResult loginSocialResult, SocialType type) async{
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel?>.withDisconnect();
    }
    try {
      final String havingClause = "email='${loginSocialResult.id}'";

      UserModel? userModel = await helper.getUser(
        whereClause: havingClause,
      );

      final bool userNotExist = userModel == null;

      final String? fcmToken = await FirebaseCloudMessaging.getFCMToken();
      final String accessToken = BackendService().generateToken();
      final String uid = BackendService().generateGUID();

      if(userNotExist){
        userModel = await helper.saveUser(
          UserModel(
            uid: uid,
            email: loginSocialResult.id.toString(),
            accountType: AppUtils.getNameOfEnumValue(type),
            name: loginSocialResult.fullName,
            fcmToken: fcmToken,
            accessToken: accessToken,
            isNewUser: loginSocialResult.fullName == null,
          ),
        );
      } else{
        await helper.updateFcmToken(fcmToken!, updateClause: havingClause);
      }

      if(userModel != null){
        userModel.fcmToken = null;
        userModel.password = null;
        userModel.accessToken = null;

        await helper.updateAccessToken(accessToken, updateClause: havingClause);
        AppPrefs.user = userModel;
        AppPrefs.accessToken = accessToken;
      }

      return NetworkState<UserModel>(
        status: userModel != null ? AppEndpoint.SUCCESS : AppEndpoint.FAILED,
        data: userModel,
        message: userModel != null ? 'success' : 'system_errors'.tr,
      );
    } on Exception catch(e) {
      return NetworkState<UserModel?>.withError(e);
    }
  }

  Future<NetworkState<UserModel?>> authenticationUser() async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel?>.withDisconnect();
    }
    try{
      final String? accessToken = AppPrefs.accessToken;

      final UserModel? userModel = await helper.getUser(
        whereClause: "accessToken='$accessToken'",
      );
      AppPrefs.user = userModel;
      if(userModel != null){
        final String? fcmToken = await FirebaseCloudMessaging.getFCMToken();
        await helper.updateFcmToken(fcmToken!, updateClause: "accessToken='$accessToken'");
      }
      return NetworkState<UserModel>(
        status: userModel != null ? AppEndpoint.SUCCESS : AppEndpoint.FAILED,
        data: userModel,
        message: userModel != null ? 'success' : 'system_errors'.tr,
      );
    }on Exception catch(e) {
      return NetworkState<UserModel?>.withError(e);
    }
  }

  Future<NetworkState<UserModel?>> getUserById(String uid) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel?>.withDisconnect();
    }
    try{
      final UserModel? userModel = await helper.getUser(
        whereClause: "uid='$uid'",
      );
      return NetworkState<UserModel>(
        status: userModel != null ? AppEndpoint.SUCCESS : AppEndpoint.FAILED,
        data: userModel,
        message: userModel != null ? 'success' : 'system_errors'.tr,
      );
    }on Exception catch(e) {
      return NetworkState<UserModel?>.withError(e);
    }
  }

  Future<NetworkState<List<UserModel>>> getUsers({int limit = 15, int offset = 0, String keyword = ''}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<UserModel>>.withDisconnect();
    }
    try{
      UserModel? userModel;
      final List<UserModel> listUserExist = await helper.getListUser(
        whereClause: "name like '%$keyword%' AND accessToken != '${AppPrefs.accessToken}'",
        limit: limit,
        offset: offset
      );

      return NetworkState<List<UserModel>>(
        status: AppEndpoint.SUCCESS,
        data: listUserExist,
        message: userModel != null ? 'success' : 'system_errors'.tr,
      );
    }on Exception catch(e) {
      return NetworkState<List<UserModel>>.withError(e);
    }
  }
}
