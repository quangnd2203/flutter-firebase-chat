import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui.dart';

class MessageController extends BaseController {

  final ScrollController scrollController = ScrollController();

  RxInt currentOffset = 0.obs;

  RxBool isShowSearch = false.obs;

  @override
  Future<void> onInit() async {
    onScrollControllerListen();
    setLoading(true);
    await onRefresh();
    setLoading(false);
    super.onInit();
  }

  void changeSearchState(){
    isShowSearch.value = !isShowSearch.value;
  }

  void onScrollControllerListen(){
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent <= scrollController.offset + 100){
        currentOffset += 10;
      }
    });
  }

  Future<void> onRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    currentOffset.value = 10;
  }
}
