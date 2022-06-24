import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../notification/message_notification.dart';
import '../../notification/notification.dart';
import '../../notification/notification_data.dart';
import '../../resources/resources.dart';
import '../ui.dart';

class MessageRoomController extends BaseController {
  final ConversationModel? conversation = Get.arguments as ConversationModel?;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  final RxList<MessageModel> _messages = <MessageModel>[].obs;

  List<MessageModel> get messages => _messages.toList();

  @override
  Future<void> onInit() async {
    setLoading(true);
    _messages.addAll(await getMessageOfConversation());
    onNotificationReceiver();
    onScrollControllerListener();
    super.onInit();
    setLoading(false);
  }

  Future<List<MessageModel>> getMessageOfConversation() async {
    final NetworkState<List<MessageModel>> networkState =
        await MessageRepository().getMessageOfConversation(
            conversation!.conversationId!,
            offset: messages.length);
    return networkState.data ?? <MessageModel>[];
  }

  void onScrollControllerListener() {
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        final List<MessageModel> messageMore = await getMessageOfConversation();
        if (messageMore.isNotEmpty) {
          _messages.addAll(messageMore);
        }
      }
    });
  }

  Future<void> sendMessage() async {
    if(messageController.text.isEmpty){
      return;
    }
    final NetworkState<MessageModel?> networkState = await MessageRepository().sendMessage(conversation!, text: messageController.text);
    if(networkState.isSuccess){
      messageController.text = '';
    }
  }

  void onNotificationReceiver(){
    notificationSubject.listen((Data? event) {
      if(event?.type == 'message'){
        final MessageNotification messageNotification = event!.data as MessageNotification;
        if(messageNotification.message!.conversation!.conversationId == conversation!.conversationId){
          _messages.insert(0, messageNotification.message!);
        }
      }
    });
  }
}
