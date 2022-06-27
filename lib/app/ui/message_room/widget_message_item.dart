import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../resources/resources.dart';
import '../../utils/app_utils.dart';

class WidgetMessageItem extends StatefulWidget {
  const WidgetMessageItem(
    this.messageModel, {
    Key? key,
    this.isOwner = true,
  }) : super(key: key);
  final bool isOwner;
  final MessageModel messageModel;

  @override
  State<WidgetMessageItem> createState() => _WidgetMessageItemState();
}

class _WidgetMessageItemState extends State<WidgetMessageItem> {
  bool isShowTime = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isOwner ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: widget.isOwner
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isShowTime = !isShowTime;
                });
              },
              child: Container(
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: widget.isOwner ? AppColors.primary : AppColors.bgLight,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(30)).copyWith(
                    bottomRight: widget.isOwner ? Radius.zero : null,
                    bottomLeft: widget.isOwner ? null : Radius.zero,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.messageModel.text!,
                  style: AppTextStyles.normalSemiBold.copyWith(
                      color: widget.isOwner ? Colors.white : AppColors.text),
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    AppUtils.getTimePeriod(AppUtils.convertString2DateTime(widget.messageModel.created, format: 'yyyy-MM-dd HH:mm:SS.SSS')!),
                    style: AppTextStyles.normalRegular
                        .copyWith(color: AppColors.greyDark, fontSize: 14),
                  ),
                ],
              ),
              secondChild: const SizedBox(
                width: 75,
              ),
              crossFadeState: isShowTime
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
