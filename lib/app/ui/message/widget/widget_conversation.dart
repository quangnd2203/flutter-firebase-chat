import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/utils.dart';
import '../../ui.dart';

class WidgetConversation extends StatelessWidget {
  WidgetConversation({Key? key, required this.conversation}) : super(key: key);
  final ConversationModel conversation;

  late final UserModel partner = conversation.users!
      .firstWhere((UserModel user) => user.uid != AppPrefs.user!.uid);

  String get showMessage {
    if (conversation.lastMessage == null) {
      return 'Bắt đầu cuộc hội thoại';
    } else if (conversation.lastMessage?.text == null) {
      return 'Đã gửi hình ảnh';
    }
    return '${conversation.lastMessage!.user!.uid != partner.uid ? 'Bạn: ' : ''}${conversation.lastMessage!.text!}';
  }

  bool get isNew =>
      AppPrefs.newConversations.contains(conversation.conversationId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WidgetAvatar(
                  avatar: partner.avatar,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        partner.name!,
                        style:
                            AppTextStyles.normalSemiBold.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        showMessage,
                        style: AppTextStyles.normal.copyWith(
                          fontSize: 14,
                          color: isNew ? AppColors.text : AppColors.grey,
                          fontWeight: isNew ? FontWeight.bold : FontWeight.w500,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                if (conversation.lastMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      AppUtils.getTimePeriod(AppUtils.convertString2DateTime(
                          conversation.lastMessage!.created,
                          format: 'yyyy-MM-dd HH:mm:SS.SSS')!),
                      style: AppTextStyles.normalRegular.copyWith(fontSize: 12),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
