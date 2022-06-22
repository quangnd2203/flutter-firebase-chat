import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../resources/resources.dart';
import '../../../utils/utils.dart';

class WidgetConversation extends StatelessWidget {
  WidgetConversation({Key? key, required this.conversation}) : super(key: key);
  final ConversationModel conversation;

  late final UserModel partner = conversation.users!.firstWhere((UserModel user) => user.uid != AppPrefs.user!.uid);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.asset(
                    AppImages.jpg('anhnen'),
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        partner.name!,
                        style: AppTextStyles.normalSemiBold.copyWith(fontSize: 18),
                      ),
                      Text(
                          'Anh yeu em anh yeu em anh yem Anh yeu em anh yeu em anh yem Anh yeu em anh yeu em anh yem Anh yeu em anh yeu em anh yem ',
                        style: AppTextStyles.normal.copyWith(fontSize: 14, color: AppColors.grey, height: 1.35),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16,),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('2 min', style: AppTextStyles.normalRegular.copyWith(fontSize: 12),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
