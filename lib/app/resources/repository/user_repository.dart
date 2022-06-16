import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../resources.dart';

class UserRepository {

  factory UserRepository() {
    _instance ??= UserRepository._();
    return _instance!;
  }
  UserRepository._();

  static UserRepository? _instance;
  
  Future<NetworkState<bool?>> register({required String email, required String password}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<bool?>.withDisconnect();
    }
    try {
      final DataQueryBuilder query = DataQueryBuilder();
      query.properties = <String>[
        'uid',
        'name',
        'email',
      ];
      query.havingClause = "email='$email'";
      final bool userNotExist = (await UserDao().read(queryBuilder: query)).isEmpty;
      bool success = false;
      if(userNotExist){
        success = true;
      }
      return NetworkState<bool?>(
        status: AppEndpoint.SUCCESS,
        data: userNotExist && success,
        message: userNotExist && success ? 'success' : (userNotExist ? 'user_exist'.tr : 'system_errors'.tr),
      );
    } on Exception catch(e) {
      return NetworkState<bool?>.withError(e);
    }
  }
}
