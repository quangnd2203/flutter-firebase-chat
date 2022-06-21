import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class WidgetMessageItem extends StatefulWidget {
  const WidgetMessageItem(
    this.text, {
    Key? key,
    this.isOwner = true,
  }) : super(key: key);
  final bool isOwner;
  final String text;

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
                  widget.text,
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
                    '02:00 AM',
                    style: AppTextStyles.normalRegular
                        .copyWith(color: AppColors.greyDark, fontSize: 14),
                  )
                ],
              ),
              secondChild: const SizedBox(width: 65,),
              crossFadeState: isShowTime ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
