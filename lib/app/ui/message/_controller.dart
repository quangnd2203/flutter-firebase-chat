import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui.dart';

class MessageController extends BaseController {

  final ScrollController scrollController = ScrollController();

  RxInt currentOffset = 10.obs;

  RxBool isShowSearch = false.obs;

  @override
  Future<void> onInit() async {

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent <= scrollController.offset + 75){
        currentOffset += 10;
      }
    });

    super.onInit();
  }

  void changeSearchState(){
    isShowSearch.value = !isShowSearch.value;
  }
}
