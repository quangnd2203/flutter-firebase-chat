import '../../resources.dart';

class ConversationRepositoryHelper{

  factory ConversationRepositoryHelper() {
    _instance ??= ConversationRepositoryHelper._();
    return _instance!;
  }
  ConversationRepositoryHelper._();

  static ConversationRepositoryHelper? _instance;

  static const List<String> _defaultProperties = <String>['conversationId', 'objectId'];
  static const List<String> _defaultRelations = <String>['lastMessage', 'users'];

  Future<ConversationModel?> saveConversation(ConversationModel model) async {
    ConversationModel? conversationModel;
    final Map<String, dynamic> data = model.toJson();
    data.removeWhere((String key, dynamic value) => value == null);
    conversationModel = await ConversationDao().save(data: data);
    return conversationModel;
  }

  Future<ConversationModel?> getConversationByUsers({
    required List<UserModel> users,
    List<String> properties = _defaultProperties,
  }) async {
    ConversationModel? result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties;
    query.groupBy = _defaultProperties;
    query.related = _defaultRelations;
    query.whereClause = 'users.uid IN ${users.map((UserModel e) => "'${e.uid}'").toString().replaceAll('[', '(').replaceAll(']', ')')}';
    final List<ConversationModel> listConversation = await ConversationDao().read(queryBuilder: query);
    if(listConversation.isNotEmpty){
      result = listConversation.first;
    }
    return result;
  }

}
