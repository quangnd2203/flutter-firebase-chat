// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../ui.dart';

class MessageScreen extends BaseScreen<MessageController> {

  @override
  Widget? builder() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, viewPaddingTop, 16, 0),
      child: Expanded(
        child: Column(
          children: <Widget>[
            const Icon(Icons.search, size: 30,),
            Text('Message', style: AppTextStyles.normalBold.copyWith(fontSize: 45),),
          ],
        ),
      ),
    );
  }

}
