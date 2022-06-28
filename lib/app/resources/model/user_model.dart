
/// uid : "uid-1655258998474880"
/// password : "8c389f79e7d90ba088d7a2b05ef6ef6a29cb642110695fa0a7dc45f139cc4882"
/// accountType : "normal"
/// name : "Nguyen Dang Quang"
/// fcmToken : null
/// email : "quangnd.nta@gmail.com"

class UserModel {
  UserModel({
    this.uid,
    this.password,
    this.accountType,
    this.name,
    this.fcmToken,
    this.email,
    this.isNewUser,
    this.accessToken,
    this.objectId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String?;
    password = json['password'] as String?;
    accountType = json['accountType'] as String?;
    name = json['name'] as String?;
    fcmToken = json['fcmToken'] as String?;
    email = json['email'] as String?;
    isNewUser = json['isNewUser'] as bool?;
    accessToken = json['accessToken'] as String?;
    objectId = json['objectId'] as String?;
  }

  String? uid;
  String? password;
  String? accountType;
  String? name;
  String? fcmToken;
  String? email;
  String? accessToken;
  String? objectId;
  bool? isNewUser;

  UserModel copyWith({
    String? uid,
    String? password,
    String? accountType,
    String? name,
    String? fcmToken,
    String? email,
    bool? isNewUser,
    String? accessToken,
    String? objectId,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        password: password ?? this.password,
        accountType: accountType ?? this.accountType,
        name: name ?? this.name,
        fcmToken: fcmToken ?? this.fcmToken,
        email: email ?? this.email,
        isNewUser: isNewUser ?? this.isNewUser,
        accessToken: accessToken ?? this.accessToken,
        objectId: objectId ?? this.objectId,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['uid'] = uid;
    map['password'] = password;
    map['accountType'] = accountType;
    map['name'] = name;
    map['fcmToken'] = fcmToken;
    map['email'] = email;
    map['isNewUser'] = isNewUser;
    map['accessToken'] = accessToken;
    map['objectId'] = objectId;
    return map;
  }

  static List<UserModel> listToJson(dynamic json){
    List<UserModel> result = <UserModel>[];
    if(json != null){
      final List<Map<dynamic, dynamic>> data = List<Map<dynamic, dynamic>>.from(json as List<Object?>);
      result = data.map<UserModel>((Map<dynamic, dynamic> e) => UserModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return result;
  }
}
