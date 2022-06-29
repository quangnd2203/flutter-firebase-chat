// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

import '../constants/constants.dart';
import 'utils.dart';

class AppUtils {
  AppUtils._();

  static void toast(String? message, {Duration? duration}) {
    if(message != null){
      showOverlayNotification((BuildContext context) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary,
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.normalBold.copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      }, duration: duration ?? const Duration(milliseconds: 2000));
    }
  }

  static const List<String> _themes = <String>['dark', 'light'];

  static T valueByMode<T>({List<String> themes = _themes, required List<T> values}) {
    try {
      for (int i = 0; i < themes.length; i++) {
        if (AppPrefs.appMode == themes[i]) {
          if (i < values.length)
            return values[i];
          else
            values.first;
        }
      }
      return values.first;
    } catch (e) {
      return values.first;
    }
  }

  static String pathMediaToUrl(String? url) {
    if (url == null || url.startsWith('http')) {
      return url ?? '';
    }
    return "${"AppEndpoint.BASE_UPLOAD_URL"}$url";
  }

  static String convertDateTime2String(DateTime? dateTime, {String format = 'yy-MM-dd'}) {
    if (dateTime == null){
      return '';
    }
    return DateFormat(format).format(dateTime);
  }

  static DateTime? convertString2DateTime(String? dateTime,
      {String format = 'yyyy-MM-ddTHH:mm:ss.SSSZ'}) {
    if (dateTime == null){
      return null;
    }
    return DateFormat(format).parse(dateTime);
  }

  static String convertString2String(String? dateTime,
      {String inputFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ', String outputFormat = 'yyyy-MM-dd'}) {
    if (dateTime == null){
      return '';
    }
    final DateTime? input = convertString2DateTime(dateTime, format: inputFormat);
    return convertDateTime2String(input, format: outputFormat);
  }

  static String minimum(int? value) {
    if (value == null){
      return '00';
    }
    return value < 10 ? '0$value' : '$value';
  }

  static String convertPhoneNumber(String phone, {String code = '+84'}) {
    return '$code${phone.substring(1)}';
  }

  static String convertToSha256(String input){
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String getNameOfEnumValue(dynamic enumValue){
    return enumValue.toString().split('.').last;
  }

  static String convertObjectToBase64(dynamic object){
    final List<int> utf8List = utf8.encode(jsonEncode(object));
    return base64.encode(utf8List);
  }

  static dynamic convertBase64ToObject(String base64String){
    final List<int> utf8List = base64Decode(base64String);
    return jsonDecode(utf8.decode(utf8List));
  }

  static String getTimePeriod(DateTime date){
    final DateTime now = DateTime.now();
    final Duration duration = now.difference(date);
    if(duration.inMinutes < 2){
      return 'now';
    }
    if(duration.inMinutes < 60){
      return '${duration.inMinutes} min';
    }
    if(duration.inHours < 24){
      return '${duration.inHours} hours';
    }
    if(duration.inDays < 30){
      return '${duration.inDays} days';
    }
    return convertDateTime2String(date, format: 'dd/MM/yyyy');
  }

  static Future<CroppedFile?> cropImage(String filePath, {CropStyle? cropStyle, int ratioX = 4, int ratioY = 3}) async {
    final CroppedFile? imageCropper = await ImageCropper().cropImage(
      sourcePath: filePath,
      cropStyle: cropStyle ?? CropStyle.rectangle,
      compressQuality: 50,
      aspectRatio: CropAspectRatio(ratioX: ratioX.toDouble(), ratioY: ratioY.toDouble()),
      uiSettings: <PlatformUiSettings>[
        AndroidUiSettings(
          toolbarTitle: 'edit'.tr,
          backgroundColor: Colors.white,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'edit'.tr,
          hidesNavigationBar: true,
        ),
      ],
    );
    return imageCropper;
  }
}
