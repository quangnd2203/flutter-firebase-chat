// ignore_for_file: always_specify_types, avoid_dynamic_calls
//
// class FirebaseNotification {
//
//   FirebaseNotification(
//       this.notification,
//       this.data,
//       );
//
//   factory FirebaseNotification.fromJson(Map<String, dynamic> json) =>
//       FirebaseNotification(
//         json['notification'] == null
//             ? null
//             : Notification.fromJson((json['notification'] as Map).map(
//               (k, e) => MapEntry(k as String, e),
//         )),
//         json['data'] == null
//             ? null
//             : Data.fromJson((json['data'] as Map).map(
//               (k, e) => MapEntry(k as String, e),
//         )),
//       );
//   Notification? notification;
//   Data? data;
//
//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'notification': notification,
//     'data': data,
//   };
//
//   @override
//   String toString() {
//     return 'FirebaseNotification{notification: $notification, data: $data}';
//   }
// }

import '../resources/model/network_state.dart';

class Data {
  Data({this.type, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    data = json['data'] as String?;
  }

  String? type;
  dynamic data;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'type': type, 'data': data};

  @override
  String toString() {
    return '''{"type": "$type","data": "${data.toJson()}"}''';
  }

  Data copyWith({
    String? type,
    dynamic data,
  }) =>
      Data(
        type: type ?? this.type,
        data: data ?? this.data,
      );
}

// class Notification {
//
//   Notification(
//       this.title,
//       this.body,
//       );
//
//   factory Notification.fromJson(Map<String, dynamic>? json) => Notification(
//     json?['title'] as String,
//     json?['body'] as String,
//   );
//   String title;
//   String body;
//
//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'title': title,
//     'body': body,
//   };
//
//   @override
//   String toString() {
//     return 'Notification{title: $title, body: $body}';
//   }
// }
