import '../../resources.dart';

class ConversationRepositoryHelper{

  factory ConversationRepositoryHelper() {
    _instance ??= ConversationRepositoryHelper._();
    return _instance!;
  }
  ConversationRepositoryHelper._();

  static ConversationRepositoryHelper? _instance;

  static const List<String> _defaultProperties = <String>['conversationId', 'objectId'];
  static const List<String> _defaultRelations = <String>['lastMessage', 'users', 'lastMessage.user'];

  Future<ConversationModel?> saveConversation(ConversationModel model) async {
    ConversationModel? conversationModel;
    final Map<String, dynamic> data = model.toJson();
    data.removeWhere((String key, dynamic value) => value == null);
    conversationModel = await ConversationDao().save(data: data);
    return conversationModel;
  }

  Future<ConversationModel?> getConversation({
    String whereClause = '',
    required UserModel partner,
    List<String> properties = _defaultProperties,
  }) async {
    ConversationModel? result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties;
    query.related = _defaultRelations;
    query.whereClause = whereClause;
    final List<ConversationModel> listConversation = await ConversationDao().read(queryBuilder: query);
    if(listConversation.isNotEmpty){
      for(final ConversationModel item in listConversation){
        if(result != null){
          break;
        }
        for(final UserModel user in item.users!){
          if(partner.uid!.contains(user.uid!)){
            result = item;
            break;
          }
        }
      }
    }
    return result;
  }

  Future<List<ConversationModel>> getListConversations({
    String whereClause = '',
    List<String> properties = _defaultProperties,
    int limit = 15,
    int offset = 0,
  }) async {
    List<ConversationModel> result;
    final DataQueryBuilder query = DataQueryBuilder();
    query.properties = properties;
    query.related = _defaultRelations;
    query.whereClause = whereClause;
    query.pageSize = limit;
    query.offset = offset;
    result = await ConversationDao().read(queryBuilder: query);
    return result;
  }
}
