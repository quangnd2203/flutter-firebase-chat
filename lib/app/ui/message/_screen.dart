// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../ui.dart';
import 'widget/widget_conversation.dart';

class MessageScreen extends BaseScreen<MessageController>{

  @override
  Widget? builder() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: viewPaddingTop,),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Message',
                      style: AppTextStyles.normalBold.copyWith(fontSize: 45),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 150, top: 10, left: 16, right: 16),
                  itemBuilder: (BuildContext context, int index) => const WidgetConversation(),
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 32,
          bottom: 100,
          child: FloatingActionButton(
            onPressed: () => null,
            backgroundColor: AppColors.pink,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

}
