import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/app_endpoint.dart';
import '../../constants/app_values.dart';
import '../../utils/utils.dart';
import '../resources.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../../constants/constants.dart';
// import '../../utils/app_clients.dart';
// import '../model/model.dart';
// import '../service/wifi_service.dart';
// import 'package:dio/dio.dart';

class FirebaseRepository {
  factory FirebaseRepository() {
    _instance ??= FirebaseRepository._();
    return _instance!;
  }
  FirebaseRepository._();

  static FirebaseRepository? _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<UserCredential> signInWithCredential(AuthCredential authCredential) =>
      _auth.signInWithCredential(authCredential);

  Future<User?> getUser(UserCredential authResult) async {
    final User? user = authResult.user;
    final User? currentUser = _auth.currentUser;
    if (user != null && currentUser != null && user.uid == currentUser.uid) {
      return user;
    }
    return null;
  }

  Future<void> signOut() => _auth.signOut();

  Future<NetworkState<dynamic>> pushNotification({
    required String title,
    required String content,
    Map<String, dynamic>? data,
    required List<String> fcmToken,
  }) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<dynamic>.withDisconnect();
    }
    try {
      final Response<dynamic> response = await AppClients(
          options: BaseOptions(headers: <String, dynamic>{
        'Authorization': FIRE_BASE_MESSAGE_TOKEN,
      })).post(
        AppEndpoint.SEND_FCM_TOKEN,
        data: <String, dynamic>{
          'priority': 'HIGH',
          'notification': <String, dynamic>{'title': title, 'body': content},
          'data': data,
          'registration_ids': fcmToken,
        },
      );
      return NetworkState<dynamic>(
        status: AppEndpoint.SUCCESS,
        data: response.data,
      );
    } on DioError catch (e) {
      return NetworkState<dynamic>.withError(e);
    }
  }
}
