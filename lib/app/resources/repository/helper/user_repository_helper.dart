import '../../resources.dart';

class UserRepositoryHelper{

  factory UserRepositoryHelper() {
    _instance ??= UserRepositoryHelper._();
    return _instance!;
  }
  UserRepositoryHelper._();

  static UserRepositoryHelper? _instance;

  Future<void> updateFcmToken(String fcmToken, {required String updateClause}) async {
    final String whereClauseDelete = "fcmToken = '$fcmToken'";
    await UserDao().update(whereClause: whereClauseDelete, data: <String, dynamic>{
      'fcmToken': null,
    });
    await UserDao().update(whereClause: updateClause, data: <String, dynamic>{
      'fcmToken': fcmToken,
    });
  }

  Future<List<UserModel>> getListUser({String whereClause = '', List<String>? properties}) async {
    List<UserModel> result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties ?? [];
    query.havingClause = whereClause;
    result = await UserDao().read(queryBuilder: query);
    return result;
  }
}
