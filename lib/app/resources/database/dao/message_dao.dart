// ignore_for_file: overridden_fields

import '../../resources.dart';

class MessageDao extends Dao<MessageModel>{

  factory MessageDao() {
    return _instance ??= MessageDao._();
  }
  MessageDao._();

  static MessageDao? _instance;

  /// Khởi tạo AppDataBase để có thể thao tác với Backendless

  @override
  AppDataBase appDatabase = AppDataBase();

  /// Gán tên của bảng trên Backendless vào đây.
  @override
  String tableName = 'Message';

  /// Phương thức này dùng để query CSDL trả ra List<MessageModel>
  ///
  /// Cac biến:
  ///   queryBuilder: điều kiện đầu vào (có thể có hoặc không).
  @override
  Future<List<MessageModel>> read({DataQueryBuilder? queryBuilder}) async {
    List<MessageModel> result = <MessageModel>[];
    final List<Map<dynamic, dynamic>?>? response = await appDatabase.read(tableName, queryBuilder: queryBuilder);
    if(response != null){
      result = response.map<MessageModel>((Map<dynamic, dynamic>? e) => MessageModel.fromJson(Map<String, dynamic>.from(e!))).toList();
    }
    return result;
  }

  @override
  Future<MessageModel?> save({required Map<String, dynamic> data, bool isUpsert = false}) async {
    MessageModel? result;
    final Map<dynamic, dynamic>? response = await appDatabase.save(tableName, data: data, isUpsert: isUpsert);
    if(response != null){
      result = MessageModel.fromJson(Map<String, dynamic>.from(response));
    }
    return result;
  }

  @override
  Future<int> update({required String whereClause, required Map<String, dynamic> data}) async {
    final int? response = await appDatabase.update(tableName, whereClause: whereClause, data: data);
    return response ?? 0;
  }

}
