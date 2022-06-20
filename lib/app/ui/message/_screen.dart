// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../../constants/constants.dart';
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
          bottom: 90 + viewPaddingTop,
          child: FloatingActionButton(
            onPressed: () => null,
            backgroundColor: AppColors.pink,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      edgeOffset: 200,
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 100,
            stretch: true,
            actions: <Widget>[
              Icon(
                Icons.search,
                size: 30,
                color: AppColors.text,
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
                'Message',
                style: AppTextStyles.normalBold.copyWith(fontSize: 35),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return const WidgetConversation();
              },
              childCount: controller.currentOffset.value,
            ),
          ),
          if(!controller.loading.value) const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                  child: CircularProgressIndicator(
              )),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
            ),
          )
        ],
      ),
    );
  }
}
