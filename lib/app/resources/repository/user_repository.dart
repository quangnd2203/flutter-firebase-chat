import '../resources.dart';

class UserRepository {

  factory UserRepository() {
    _instance ??= UserRepository._();
    return _instance!;
  }
  UserRepository._();

  static UserRepository? _instance;
  
  Future<List<UserModel>> checkUserExist({required String name, required String password}) async {
    final List<UserModel> userModel = await UserDao().read();
    return userModel;
  }
}
