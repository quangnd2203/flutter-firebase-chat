import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../../routes/app_pages.dart';
import '../ui.dart';

class MessageController extends BaseController {

  RxBool isShowSearch = false.obs;

  @override
  Future<void> onInit() async {
    // onScrollControllerListen();
    setLoading(true);
    // await onRefresh();
    setLoading(false);
    super.onInit();
  }

  void changeSearchState(){
    isShowSearch.value = !isShowSearch.value;
  }

  Future<List<ConversationModel>> getConversations(int offset) async {
    final NetworkState<List<ConversationModel>> networkState = await ConversationRepository().getConversation(offset: offset);
    return networkState.data ?? <ConversationModel>[];
  }

  void toConversation(ConversationModel model){
    Get.toNamed(Routes.MESSAGE_ROOM, arguments: model);
  }
}
