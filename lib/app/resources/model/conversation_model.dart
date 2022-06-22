import '../resources.dart';

/// conversationId : "test"
/// lastMessage : null
/// ownerId : null
/// objectId : "A9515F45-B9EC-46EF-88A8-5BF50C932D2D"
/// users : [{"created":1655707220569,"accountType":"normal","accessToken":"dWlkLTE2NTU3MDcyMTExNTk1NTZ1aWQtMTY1NTcwNzIxMTE1OTYwMnVpZC0xNjU1NzA3MjExMTU5NjExdWlkLTE2NTU3MDcyMTExNTk2MTd1aWQtMTY1NTcwNzIxMTE1OTYyM3VpZC0xNjU1NzA3MjExMTU5NjI5dWlkLTE2NTU3MDcyMTExNTk2MzV1aWQtMTY1NTcwNzIxMTE1OTY0M3VpZC0xNjU1NzA3MjExMTU5NjQ5","isNewUser":false,"ownerId":null,"uid":"uid-1655707211159676","password":"8c389f79e7d90ba088d7a2b05ef6ef6a29cb642110695fa0a7dc45f139cc4882","name":"Laura Adams","___class":"User","updated":1655713874921,"fcmToken":null,"email":"laura_adams_92584019@@gmail.com","objectId":"8F723B31-F221-446B-920E-7DE0E4C1930E"},{"created":1655707220645,"accountType":"normal","accessToken":"dWlkLTE2NTU3MDcyMTEzMjczODB1aWQtMTY1NTcwNzIxMTMyNzQyMXVpZC0xNjU1NzA3MjExMzI3NDI5dWlkLTE2NTU3MDcyMTEzMjc0MzV1aWQtMTY1NTcwNzIxMTMyNzQ0M3VpZC0xNjU1NzA3MjExMzI3NDQ5dWlkLTE2NTU3MDcyMTEzMjc0NTR1aWQtMTY1NTcwNzIxMTMyNzQ2MXVpZC0xNjU1NzA3MjExMzI3NDY3","isNewUser":false,"ownerId":null,"uid":"uid-1655707211327490","password":"8c389f79e7d90ba088d7a2b05ef6ef6a29cb642110695fa0a7dc45f139cc4882","name":"Cheryl Peterson","___class":"User","updated":1655713874921,"fcmToken":null,"email":"cheryl_peterson_84758271@@gmail.com","objectId":"A097B820-51DA-4692-A96C-B431C72AD054"}]

class ConversationModel {
  ConversationModel({
    this.conversationId,
    this.lastMessage,
    this.objectId,
    this.users,
  });

  ConversationModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'] as String?;
    lastMessage = json['lastMessage'] != null
        ? MessageModel.fromJson(Map<String, dynamic>.from(
            json['lastMessage'] as Map<dynamic, dynamic>))
        : null;
    objectId = json['objectId'] as String?;
    users = UserModel.listToJson(json['users']);
  }

  String? conversationId;
  MessageModel? lastMessage;
  String? objectId;
  List<UserModel>? users;

  ConversationModel copyWith({
    String? conversationId,
    MessageModel? lastMessage,
    String? objectId,
    List<UserModel>? users,
  }) =>
      ConversationModel(
        conversationId: conversationId ?? this.conversationId,
        lastMessage: lastMessage ?? this.lastMessage,
        objectId: objectId ?? this.objectId,
        users: users ?? this.users,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['conversationId'] = conversationId;
    map['lastMessage'] = lastMessage?.toJson();
    map['objectId'] = objectId;
    if (users != null) {
      map['users'] = users?.map((UserModel? v) => v?.toJson()).toList();
    }
    return map;
  }
}
