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

  Future<NetworkState<ConversationModel?>> createConversation(
      UserModel partner) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<ConversationModel?>.withDisconnect();
    }
    try {
      final String conversationId = BackendService().generateGUID('cid');

      ConversationModel? conversationModel = await _helper.getConversationByUsers(
        users: <UserModel>[partner, AppPrefs.user!],
      );

      conversationModel ??= await _helper.saveConversation(ConversationModel(
        conversationId: conversationId,
      ));

      if (conversationModel != null) {
        await ConversationDao().setRelation(
          parentObjectId: conversationModel.objectId!,
          relationColumnName: 'users',
          childrenObjectIds: <String>[
            partner.objectId!,
            AppPrefs.user!.objectId!
          ],
        );
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
}
