// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
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
          const Icon(Icons.arrow_back),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Center(
              child: Text(
                'Nguyen Dang Quang',
                style: AppTextStyles.normalBold.copyWith(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Icon(Icons.settings_outlined),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 25),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdmAnh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdmeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                    isOwner: false,
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                    isOwner: false,
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                    isOwner: false,
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                    isOwner: false,
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                    isOwner: false,
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                  ),
                  buildMessage(
                    'Anh yeu em anh yeu em anh yeu em ang yeu em anh yeu em ammsdsdm',
                  ),
                ],
              ),
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

  Widget buildMessage(String text, {bool isOwner = true}) {
    return Align(
      alignment: isOwner ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: Get.width * 0.8,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isOwner ? AppColors.primary : AppColors.bgLight,
          borderRadius: const BorderRadius.all(Radius.circular(30)).copyWith(
            bottomRight: isOwner ? Radius.zero : null,
            bottomLeft: isOwner ? null : Radius.zero,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: AppTextStyles.normalSemiBold
              .copyWith(color: isOwner ? Colors.white : AppColors.text),
        ),
      ),
    );
  }

  Widget buildInputField() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
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
            const SizedBox(width: 16,),
            const Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'message...',
                ),
              ),
            ),
            Icon(
              Icons.send,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
