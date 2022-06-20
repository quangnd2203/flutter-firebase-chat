import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../resources/resources.dart';

class WidgetContact extends StatelessWidget {
  const WidgetContact({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: Image.asset(
                AppImages.jpg('anhnen'),
                fit: BoxFit.cover,
                width: 35,
                height: 35,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                user.name ?? '',
                style: AppTextStyles.normalSemiBold.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
