import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../ui.dart';

class ContactListController extends BaseController {
  final ScrollController scrollController = ScrollController();

  int currentOffset = 0;

  RxBool isShowSearch = false.obs;

  RxList<UserModel> users = <UserModel>[].obs;

  @override
  Future<void> onInit() async {
    onScrollControllerListen();
    setLoading(true);
    await onRefresh();
    setLoading(false);
    super.onInit();
  }

  void changeSearchState() {
    isShowSearch.value = !isShowSearch.value;
  }

  void onScrollControllerListen() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        await loadMore();
      }
    });
  }

  Future<void> onRefresh() async {
    currentOffset = 0;
    users.clear();
    users.addAll(await getUsers());
  }

  Future<List<UserModel>> getUsers() async {
    final NetworkState<List<UserModel>> networkState = await UserRepository().getUsers(offset: currentOffset);
    return networkState.data ?? <UserModel>[];
  }

  Future<void> loadMore() async {
    currentOffset += 15;
    users.addAll(await getUsers());
  }
}
