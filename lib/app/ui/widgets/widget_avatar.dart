import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'widget_image_network.dart';

class WidgetAvatar extends StatelessWidget {
  const WidgetAvatar(
      {Key? key, this.avatar, this.edge = 56, this.borderHeight = 4})
      : super(key: key);

  final String? avatar;
  final double edge;
  final double borderHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: <Color>[
            AppColors.pink,
            Colors.yellowAccent,
            Colors.yellowAccent,
            AppColors.primary,
            AppColors.pink,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      padding: EdgeInsets.all(borderHeight),
      child: ClipOval(
        child: Material(
          color: Colors.white,
          child: WidgetImageNetwork(
            url: avatar,
            width: edge,
            height: edge,
            assetError: AppImages.png('user_empty'),
          ),
        ),
      ),
    );
  }
}
