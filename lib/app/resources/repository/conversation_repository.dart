import '../../constants/constants.dart';
import '../../utils/utils.dart';
import '../resources.dart';
import 'helper/conversation_repository_helper.dart';

class ConversationRepository {
  factory ConversationRepository() {
    _instance ??= ConversationRepository._();
    return _instance!;
  }
  ConversationRepository._();

  static ConversationRepository? _instance;

  final ConversationRepositoryHelper _helper = ConversationRepositoryHelper();

  Future<NetworkState<ConversationModel?>> createConversation(UserModel partner) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<ConversationModel?>.withDisconnect();
    }
    try {
      final String conversationId = BackendService().generateGUID('cid');

      final String queryClause = "users.accessToken='${AppPrefs.accessToken}'";

      ConversationModel? conversationModel = await _helper.getConversation(
        whereClause: queryClause,
        partner: partner,
      );

      conversationModel ??= await _helper.saveConversation(ConversationModel(
        conversationId: conversationId,
      ));

      if (conversationModel != null) {
        ConversationDao().setRelation(
          parentObjectId: conversationModel.objectId!,
          relationColumnName: 'users',
          childrenObjectIds: <String>[
            partner.objectId!,
            AppPrefs.user!.objectId!
          ],
        );
        conversationModel.users = <UserModel>[
          partner,
          AppPrefs.user!,
        ];
      }

      return NetworkState<ConversationModel?>(
        status: conversationModel != null
            ? AppEndpoint.SUCCESS
            : AppEndpoint.FAILED,
        data: conversationModel,
      );
    } on Exception catch (e) {
      return NetworkState<ConversationModel?>.withError(e);
    }
  }

  Future<NetworkState<List<ConversationModel>>> getConversation({int offset = 0, int limit = 15,}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<ConversationModel>>.withDisconnect();
    }
    try {
      final List<ConversationModel> conversations = await _helper.getListConversations(
        limit: limit,
        offset: offset,
        whereClause: "users.accessToken = '${AppPrefs.accessToken}'",
      );
      return NetworkState<List<ConversationModel>>(
        status: AppEndpoint.SUCCESS,
        data: conversations,
      );
    } on Exception catch (e) {
      return NetworkState<List<ConversationModel>>.withError(e);
    }
  }
}
