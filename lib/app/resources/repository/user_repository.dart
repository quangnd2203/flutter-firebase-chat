import '../../constants/constants.dart';
import '../resources.dart';

class UserRegisterRepository {

  factory UserRegisterRepository() {
    _instance ??= UserRegisterRepository._();
    return _instance!;
  }
  UserRegisterRepository._();

  static UserRegisterRepository? _instance;
  
  Future<List<UserModel>> checkUserExist({required String name, required String password}) async {
    final List<UserModel> userModel = await UserDao().read();
    return userModel;
  }
}
