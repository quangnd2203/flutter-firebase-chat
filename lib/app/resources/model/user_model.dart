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
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String?;
    password = json['password'] as String?;
    accountType = json['accountType'] as String?;
    name = json['name'] as String?;
    fcmToken = json['fcmToken'] as String?;
    email = json['email'] as String?;
  }

  String? uid;
  String? password;
  String? accountType;
  String? name;
  String? fcmToken;
  String? email;

  UserModel copyWith({
    String? uid,
    String? password,
    String? accountType,
    String? name,
    String? fcmToken,
    String? email,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        password: password ?? this.password,
        accountType: accountType ?? this.accountType,
        name: name ?? this.name,
        fcmToken: fcmToken ?? this.fcmToken,
        email: email ?? this.email,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['uid'] = uid;
    map['password'] = password;
    map['accountType'] = accountType;
    map['name'] = name;
    map['fcmToken'] = fcmToken;
    map['email'] = email;
    return map;
  }
}
