import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../utils/app_utils.dart';
import 'local_notification.dart';
import 'message_notification.dart';
import 'notification.dart';
import 'notification_data.dart';

//This method will be call in background where have a new message
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  //Do not thing...
  log('OnBackgroundMessage: ${message.data}');
  return FirebaseCloudMessaging._handler(message);
}

class FirebaseCloudMessaging {
  FirebaseCloudMessaging._();

  static final FirebaseMessaging instance = FirebaseMessaging.instance;

  static Future<String?> getFCMToken() async {
    final String? resultFCMToken = await FirebaseMessaging.instance.getToken();
    return resultFCMToken;
  }

  static Future<void> subscribeToTopic(String topic) async {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unSubscribeFromTopic(String topic) async {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  static Future<void> initFirebaseMessaging() async {
    await instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('OnMessage: ${message.data}');
      _handler(message, isOpenApp: true);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('OnMessageOpenedApp: ${message.data}');
      _handler(message, isOpenApp: true);
    });
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    final RemoteMessage? initMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initMessage != null) {
      _handler(initMessage);
    }
  }

  static void _handler(RemoteMessage message, {bool isOpenApp = false}) {
    Data payload = Data.fromJson(message.data);

    final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(payload.data.toString()) as Map<String, dynamic>);

    switch(payload.type){
      case 'message':
        payload = payload.copyWith(data: MessageNotification.fromJson(data));
        break;
    }

    if(!isOpenApp){
      LocalNotification.showNotification(message.notification?.title, message.notification?.body, payload.toString());
      selectNotificationSubject.add(payload.toString());
    }
    notificationSubject.add(payload);
  }
}
