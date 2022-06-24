import '../resources.dart';

/// created : 1655888036245
/// ___class : "Message"
/// messageId : "test1"
/// media : null
/// text : "Chao em yeu cua anh"
/// user : {"created":1655437161953,"accountType":"normal","accessToken":"dWlkLTE2NTU4NzE4MTQ0MzA1MzJ1aWQtMTY1NTg3MTgxNDQzMjcxOHVpZC0xNjU1ODcxODE0NDMzNzE0dWlkLTE2NTU4NzE4MTQ0MzM3NDh1aWQtMTY1NTg3MTgxNDQzMzc2NHVpZC0xNjU1ODcxODE0NDMzNzc1dWlkLTE2NTU4NzE4MTQ0MzM3ODN1aWQtMTY1NTg3MTgxNDQzMzc5MXVpZC0xNjU1ODcxODE0NDMzNzk4","isNewUser":false,"ownerId":null,"uid":"uid-1655437159440561","password":"8c389f79e7d90ba088d7a2b05ef6ef6a29cb642110695fa0a7dc45f139cc4882","name":"Quang Nguyễn1","___class":"User","updated":1655871815505,"fcmToken":"cypWnjRyRaGrvxldi17k1X:APA91bFZ8g_kG3wStXZr-Nf72AqrAEPHDdUqHpuEcTnTrymwe5miTWYy8cGZbhgU11wyWiGo5IORhI0mfa5f7v1izxvqjpvP5_mmoj5XIdVVKOrZsWLhaArtIeoBG6tzlOy-QF39TpG1","email":"quangnd.nta@gmail.com","objectId":"18473F1A-7366-4184-A7F8-8038B1D43207"}
/// objectId : "0F32A5A1-7691-4AA2-BDE9-426E5BF816F8"
/// conversation : {"conversationId":"cid-1655887999552272","created":1655888003336,"___class":"Conversation","ownerId":null,"updated":null,"objectId":"5F0BB2FA-281C-4E1D-9E6D-04B0613A78DE","users":[{"created":1655437161953,"accountType":"normal","accessToken":"dWlkLTE2NTU4NzE4MTQ0MzA1MzJ1aWQtMTY1NTg3MTgxNDQzMjcxOHVpZC0xNjU1ODcxODE0NDMzNzE0dWlkLTE2NTU4NzE4MTQ0MzM3NDh1aWQtMTY1NTg3MTgxNDQzMzc2NHVpZC0xNjU1ODcxODE0NDMzNzc1dWlkLTE2NTU4NzE4MTQ0MzM3ODN1aWQtMTY1NTg3MTgxNDQzMzc5MXVpZC0xNjU1ODcxODE0NDMzNzk4","isNewUser":false,"ownerId":null,"uid":"uid-1655437159440561","password":"8c389f79e7d90ba088d7a2b05ef6ef6a29cb642110695fa0a7dc45f139cc4882","name":"Quang Nguyễn1","___class":"User","updated":1655871815505,"fcmToken":"cypWnjRyRaGrvxldi17k1X:APA91bFZ8g_kG3wStXZr-Nf72AqrAEPHDdUqHpuEcTnTrymwe5miTWYy8cGZbhgU11wyWiGo5IORhI0mfa5f7v1izxvqjpvP5_mmoj5XIdVVKOrZsWLhaArtIeoBG6tzlOy-QF39TpG1","email":"quangnd.nta@gmail.com","objectId":"18473F1A-7366-4184-A7F8-8038B1D43207"},{"created":1655372642595,"accountType":"google","accessToken":"dWlkLTE2NTU3MTM4NzQ2MjQ5ODd1aWQtMTY1NTcxMzg3NDYyNzIxMXVpZC0xNjU1NzEzODc0NjI4MjIydWlkLTE2NTU3MTM4NzQ2MjgyNzB1aWQtMTY1NTcxMzg3NDYyODI4MnVpZC0xNjU1NzEzODc0NjI4MjkydWlkLTE2NTU3MTM4NzQ2MjgzMDB1aWQtMTY1NTcxMzg3NDYyODMxMHVpZC0xNjU1NzEzODc0NjI4MzE4","isNewUser":false,"ownerId":null,"uid":"uid-1655372642279979","password":null,"name":"Kim Trâm Lê Thị","___class":"User","updated":1655713976142,"fcmToken":null,"email":"111471591272174862520","objectId":"344EB5BE-1B1A-47E9-B5C2-42F3FA95ECE4"}]}

class MessageModel {
  MessageModel({
    this.created,
    this.messageId,
    this.media,
    this.text,
    this.user,
    this.objectId,
    this.conversation,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    created = json['created'].toString();
    messageId = json['messageId'] as String?;
    media = json['media'] as String?;
    text = json['text'] as String?;
    user = json['user'] != null
        ? UserModel.fromJson(
            Map<String, dynamic>.from(json['user'] as Map<dynamic, dynamic>))
        : null;
    objectId = json['objectId'] as String?;
    conversation = json['conversation'] != null
        ? ConversationModel.fromJson(Map<String, dynamic>.from(
            json['conversation'] as Map<dynamic, dynamic>))
        : null;
  }
  String? created;
  String? messageId;
  String? media;
  String? text;
  UserModel? user;
  String? objectId;
  ConversationModel? conversation;

  MessageModel copyWith({
    String? created,
    String? messageId,
    String? media,
    String? text,
    UserModel? user,
    String? objectId,
    ConversationModel? conversation,
  }) =>
      MessageModel(
        created: created ?? this.created,
        messageId: messageId ?? this.messageId,
        media: media ?? this.media,
        text: text ?? this.text,
        user: user ?? this.user,
        objectId: objectId ?? this.objectId,
        conversation: conversation ?? this.conversation,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['created'] = created?.toString();
    map['messageId'] = messageId;
    map['media'] = media;
    map['text'] = text;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['objectId'] = objectId;
    if (conversation != null) {
      map['conversation'] = conversation?.toJson();
    }
    return map;
  }
}
