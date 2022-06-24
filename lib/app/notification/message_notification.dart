import '../resources/resources.dart';

/// conversation : null
/// message : null

class MessageNotification {
  MessageNotification({
    this.conversation,
    this.message,
  });

  MessageNotification.fromJson(Map<String, dynamic> json) {
    conversation = json['conversation'] != null
        ? ConversationModel.fromJson(Map<String, dynamic>.from(
            json['conversation'] as Map<dynamic, dynamic>))
        : null;
    message = json['message'] != null
        ? MessageModel.fromJson(
            Map<String, dynamic>.from(json['message'] as Map<dynamic, dynamic>))
        : null;
  }

  ConversationModel? conversation;
  MessageModel? message;

  MessageNotification copyWith({
    ConversationModel? conversation,
    MessageModel? message,
  }) =>
      MessageNotification(
        conversation: conversation ?? this.conversation,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['conversation'] = conversation?.toJson();
    map['message'] = message?.toJson();
    return map;
  }
}
