import '../../constants/constants.dart';
import '../../utils/utils.dart';
import '../resources.dart';
import 'helper/message_repository_helper.dart';

class MessageRepository {
  factory MessageRepository() {
    _instance ??= MessageRepository._();
    return _instance!;
  }
  MessageRepository._();

  static MessageRepository? _instance;

  final MessageRepositoryHelper _helper = MessageRepositoryHelper();

  Future<NetworkState<List<MessageModel>>> getMessageOfConversation(
      String conversationId) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<MessageModel>>.withDisconnect();
    }
    try {
      final String whereClause =
          "conversation.conversationId = '$conversationId'";
      final List<MessageModel> result = await _helper.getListMessage(
        whereClause: whereClause,
      );
      return NetworkState<List<MessageModel>>(
        status: AppEndpoint.SUCCESS,
        data: result,
      );
    } on Exception catch (e) {
      return NetworkState<List<MessageModel>>.withError(e);
    }
  }

  Future<NetworkState<MessageModel?>> sendMessage(
    ConversationModel conversationModel, {
    String? text,
    String? media,
  }) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<MessageModel?>.withDisconnect();
    }
    try {
      MessageModel? messageModel = await _helper.saveMessage(
        MessageModel(
          text: text,
          media: media,
          messageId: BackendService().generateGUID('mid'),
        ),
      );

      if (messageModel != null) {
        await MessageDao().setRelation(
          parentObjectId: messageModel.objectId!,
          relationColumnName: 'conversation',
          childrenObjectIds: <String>[
            conversationModel.objectId!,
          ],
        );
        await MessageDao().setRelation(
          parentObjectId: messageModel.objectId!,
          relationColumnName: 'user',
          childrenObjectIds: <String>[
            AppPrefs.user!.objectId!,
          ],
        );
        await ConversationDao().setRelation(
          parentObjectId: conversationModel.objectId!,
          relationColumnName: 'lastMessage',
          childrenObjectIds: <String>[
            messageModel.objectId!,
          ],
        );
        messageModel = await _helper.getMessage(
          whereClause: "objectId = '${messageModel.objectId}'"
        );
      }
      return NetworkState<MessageModel?>(
        status: messageModel != null ? AppEndpoint.SUCCESS : AppEndpoint.FAILED,
        data: messageModel,
      );

    } on Exception catch (e) {
      return NetworkState<MessageModel?>.withError(e);
    }
  }
}
