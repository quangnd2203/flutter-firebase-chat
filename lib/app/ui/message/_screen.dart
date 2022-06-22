// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../resources/resources.dart';
import '../ui.dart';
import 'widget/widget_conversation.dart';

class MessageScreen extends BaseScreen<MessageController> {
  @override
  Widget? builder() {
    return Stack(
      children: <Widget>[
        buildBody(),
        Positioned(
          right: 32,
          bottom: 100,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.pink,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return WidgetSliverLoadMoreVertical<ConversationModel>.build(
      appBar: SliverAppBar(
        backgroundColor: Colors.white,
        expandedHeight: 100,
        stretch: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.search,
              size: 30,
              color: AppColors.text,
            ),
          )
        ],
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          expandedTitleScale: 1.25,
          titlePadding: const EdgeInsets.only(left: 16, bottom: 10, top: 16),
          title: Text(
            'message'.tr,
            style: AppTextStyles.normalBold.copyWith(fontSize: 35),
          ),
        ),
      ),
      dataRequester: (int offset) => controller.getConversations(offset),
      initRequester: () => controller.getConversations(0),
      itemBuilder: (List<ConversationModel> data, BuildContext context, int index) {
        return WidgetConversation(conversation: data[index],);
      },
    );
  }
}
