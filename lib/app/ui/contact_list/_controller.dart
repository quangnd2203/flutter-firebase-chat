import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../ui.dart';

class ContactListController extends BaseController {
  final ScrollController scrollController = ScrollController();

  RxBool isShowSearch = false.obs;

  @override
  Future<void> onInit() async {
    setLoading(true);
    setLoading(false);
    super.onInit();
  }

  void changeSearchState() {
    isShowSearch.value = !isShowSearch.value;
  }

  Future<List<UserModel>> getUsers(int offset) async {
    final NetworkState<List<UserModel>> networkState = await UserRepository().getUsers(offset: offset);
    return networkState.data ?? <UserModel>[];
  }

  Future<void> createConversation(UserModel userModel) async {
    final NetworkState<ConversationModel?> networkState = await ConversationRepository().createConversation(userModel);
  }
}
