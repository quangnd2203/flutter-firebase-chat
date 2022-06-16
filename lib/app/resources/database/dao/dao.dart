import 'package:backendless_sdk/backendless_sdk.dart';
import '../app_database.dart';
export 'package:backendless_sdk/backendless_sdk.dart';
export 'user_dao.dart';

abstract class Dao<T>{
  /// Tên bảng
  late String tableName;

  /// Lớp AppDataBase để thao tác với CSDL
  late AppDataBase appDatabase;

  Future<List<T>> read({DataQueryBuilder? queryBuilder});

  Future<T?> save({required Map<String, dynamic> data, bool isUpsert = false});

  Future<int> update({required String whereClause, required Map<String, dynamic> data});
}
