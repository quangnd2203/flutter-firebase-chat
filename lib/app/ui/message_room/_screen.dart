// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/app/ui/message_room/widget_message_item.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class MessageRoomScreen extends BaseScreen<MessageRoomController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Column(
        children: <Widget>[
          buildAppbar(),
          Expanded(
            child: buildPage(),
          ),
          buildInputField(),
        ],
      ),
    );
  }

  Widget buildAppbar() {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(top: 16 + viewPaddingTop),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Center(
              child: Text(
                controller.conversation!.users!.firstWhere((UserModel e) => e.uid != AppPrefs.user!.uid).name!,
                style: AppTextStyles.normalBold.copyWith(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }

  Widget buildPage() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.only(top: 25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            child: ListView.builder(
              controller: controller.scrollController,
              reverse: true,
              itemCount: controller.messages.length,
              itemBuilder: (BuildContext context, int index){
                final MessageModel msg = controller.messages[index];
                return WidgetMessageItem(msg, isOwner: msg.user!.uid == AppPrefs.user!.uid,);
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'message'.tr,
            style: AppTextStyles.normalSemiBold
                .copyWith(color: AppColors.greyDark),
          ),
        )
      ],
    );
  }

  Widget buildInputField() {
    return Container(
      decoration:
          const BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.white,
            blurRadius: 20,
            spreadRadius: 5,
            offset: Offset(0, -1))
      ]),
      padding: const EdgeInsets.all(16).copyWith(top: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.bgLight,
        ),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              radius: 12,
              child: Icon(
                Icons.add,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextField(
                controller: controller.messageController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration.collapsed(
                  hintText: 'message...',
                ),
              ),
            ),
            InkWell(
              onTap: controller.sendMessage,
              child: Icon(
                Icons.send,
                color: AppColors.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
