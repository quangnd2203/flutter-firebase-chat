// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../ui.dart';
import 'widget/widget_contact.dart';

class ContactListScreen extends BaseScreen<ContactListController> {

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      edgeOffset: 200,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        slivers: <Widget>[
          SliverAppBar(
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
                'contact_list'.tr,
                style: AppTextStyles.normalBold.copyWith(fontSize: 35),
              ),
            ),
          ),
          if(controller.users.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                  return WidgetContact(user: controller.users[index],);
                },
                childCount: controller.users.length,
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
