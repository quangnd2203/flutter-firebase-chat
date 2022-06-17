import '../../resources.dart';

class UserRepositoryHelper{

  factory UserRepositoryHelper() {
    _instance ??= UserRepositoryHelper._();
    return _instance!;
  }
  UserRepositoryHelper._();

  static UserRepositoryHelper? _instance;

  static const List<String> _defaultProperties = <String>['uid', 'name', 'email', 'isNewUser', 'accountType'];

  Future<void> updateFcmToken(String fcmToken, {required String updateClause}) async {
    final String whereClauseDelete = "fcmToken = '$fcmToken'";
    await UserDao().update(whereClause: whereClauseDelete, data: <String, dynamic>{
      'fcmToken': null,
    });
    await UserDao().update(whereClause: updateClause, data: <String, dynamic>{
      'fcmToken': fcmToken,
    });
  }

  Future<List<UserModel>> getListUser({String whereClause = '', List<String> properties = _defaultProperties}) async {
    List<UserModel> result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties;
    query.havingClause = whereClause;
    result = await UserDao().read(queryBuilder: query);
    return result;
  }

  Future<UserModel?> saveUser(UserModel model) async {
    UserModel? userModel;
    final Map<String, dynamic> data = model.toJson();
    data.removeWhere((String key, dynamic value) => value == null);
    userModel = await UserDao().save(data: data);
    return userModel;
  }

  Future<void> updateAccessToken(String accessToken, {required String updateClause}) async {
    await UserDao().update(whereClause: updateClause, data: <String, dynamic>{
      'accessToken': accessToken,
    });
  }
}
