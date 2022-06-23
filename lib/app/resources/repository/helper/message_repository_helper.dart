import '../../resources.dart';

class MessageRepositoryHelper{

  factory MessageRepositoryHelper() {
    _instance ??= MessageRepositoryHelper._();
    return _instance!;
  }
  MessageRepositoryHelper._();

  static MessageRepositoryHelper? _instance;

  static const List<String> _defaultProperties = <String>['messageId', 'objectId', 'text', 'created', 'media'];
  static const List<String> _defaultRelations = <String>['conversation', 'user', 'conversation.users'];

  Future<MessageModel?> saveMessage(MessageModel model) async {
    MessageModel? messageModel;
    final Map<String, dynamic> data = model.toJson();
    data.removeWhere((String key, dynamic value) => value == null);
    messageModel = await MessageDao().save(data: data);
    return messageModel;
  }

  Future<List<MessageModel>> getListMessage({
    String whereClause = '',
    List<String> properties = _defaultProperties,
    int limit = 15,
    int offset = 0,
  }) async {
    List<MessageModel> result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties;
    query.related = _defaultRelations;
    query.whereClause = whereClause;
    query.sortBy = <String>['created DESC'];
    query.pageSize = limit;
    query.offset = offset;
    result = await MessageDao().read(queryBuilder: query);
    return result;
  }

  Future<MessageModel?> getMessage({
    String whereClause = '',
    List<String> properties = _defaultProperties,
  }) async {
    MessageModel? result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties;
    query.related = _defaultRelations;
    query.whereClause = whereClause;
    final List<MessageModel> listMessage = await MessageDao().read(queryBuilder: query);
    if(listMessage.isNotEmpty){
      result = listMessage.first;
    }
    return result;
  }
}
