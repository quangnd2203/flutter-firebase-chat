// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../resources/resources.dart';
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
    return WidgetSliverLoadMoreVertical<UserModel>.build(
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
            'contact_list'.tr,
            style: AppTextStyles.normalBold.copyWith(fontSize: 35),
          ),
        ),
      ),
      dataRequester: (int offset) => controller.getUsers(offset),
      initRequester: () => controller.getUsers(0),
      itemBuilder: (List<UserModel> data, BuildContext context, int index) {
        return WidgetContact(user: data[index],);
      },
    );
  }
}
