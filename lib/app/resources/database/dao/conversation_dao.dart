// ignore_for_file: overridden_fields

import '../../resources.dart';

class ConversationDao extends Dao<ConversationModel>{

  factory ConversationDao() {
    return _instance ??= ConversationDao._();
  }
  ConversationDao._();

  static ConversationDao? _instance;

  /// Khởi tạo AppDataBase để có thể thao tác với Backendless

  @override
  AppDataBase appDatabase = AppDataBase();

  /// Gán tên của bảng trên Backendless vào đây.
  @override
  String tableName = 'Conversation';

  /// Phương thức này dùng để query CSDL trả ra List<ConversationModel>
  ///
  /// Cac biến:
  ///   queryBuilder: điều kiện đầu vào (có thể có hoặc không).
  @override
  Future<List<ConversationModel>> read({DataQueryBuilder? queryBuilder}) async {
    List<ConversationModel> result = <ConversationModel>[];
    final List<Map<dynamic, dynamic>?>? response = await appDatabase.read(tableName, queryBuilder: queryBuilder);
    if(response != null){
      result = response.map<ConversationModel>((Map<dynamic, dynamic>? e) => ConversationModel.fromJson(Map<String, dynamic>.from(e!))).toList();
    }
    return result;
  }

  @override
  Future<ConversationModel?> save({required Map<String, dynamic> data, bool isUpsert = false}) async {
    ConversationModel? result;
    final Map<dynamic, dynamic>? response = await appDatabase.save(tableName, data: data, isUpsert: isUpsert);
    if(response != null){
      result = ConversationModel.fromJson(Map<String, dynamic>.from(response));
    }
    return result;
  }

  @override
  Future<int> update({required String whereClause, required Map<String, dynamic> data}) async {
    final int? response = await appDatabase.update(tableName, whereClause: whereClause, data: data);
    return response ?? 0;
  }

}
