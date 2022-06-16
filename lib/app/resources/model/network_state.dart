import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x;
import '../../constants/app_endpoint.dart';

typedef NetworkStateConverter<T> = T Function(Map<String, dynamic> json);

class NetworkState<T> {
  NetworkState({this.message, this.data, this.status});

  factory NetworkState.fromResponse(Response<T> response, {NetworkStateConverter<T>? converter, T? value, String? prefix}) {
    try {
      final Map<String, dynamic> json = jsonDecode(jsonEncode(response.data)) as Map<String, dynamic>;
      return NetworkState<T>._fromJson(
        json,
        converter: converter,
        prefix: prefix,
        value: value,
      );
    } catch (e) {
      log('Error NetworkResponse.fromResponse: $e');
      return NetworkState<T>.withErrorConvert();
    }
  }

  NetworkState._fromJson(Map<String, dynamic> json, {NetworkStateConverter<T>? converter, T? value, String? prefix}) {
    status = json['status'] as int?;
    message = json['message'] as String?;
    if (value != null)
      data = value;
    else if (prefix != null) {
      if (prefix.trim().isEmpty){
        data = converter != null && json != null ? converter(json) : json as T?;
      } else{
        data = converter != null && json[prefix] != null ? converter(json[prefix] as Map<String, dynamic>) : json[prefix] as T?;
      }
    } else {
      data = converter != null && json['data'] != null ? converter(json['data'] as Map<String, dynamic>) : json['data'] as T?;
    }
  }

  NetworkState.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    status = json['status'] as int ?;
    data = json['data'] as T;
  }

  NetworkState.withError(Exception error) {
    String message;
    int? code;
    if(error is DioError){
      final Response<T>? response = error.response as Response<T>?;
      code = response?.statusCode ??  AppEndpoint.ERROR_SERVER;
      final String? serverMessage = (response?.data as Map<String, dynamic>?)?['message'] as String?;
      message = serverMessage ?? 'Không thể kết nối đến máy chủ!';
    } else {
      code = AppEndpoint.ERROR_DISCONNECT;
      message = 'system_errors'.tr;
    }
    this.message = message;
    status = code;
    data = null;
  }

  NetworkState.withDisconnect() {
    message = 'Mất kết nối internet, vui lòng kiểm tra wifi/3g và thử lại!';
    status = AppEndpoint.ERROR_DISCONNECT;
    data = null;
  }

  NetworkState.withErrorConvert() {
    data = null;
  }

  int? status;
  String? message;
  T? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['data'] = this.data;
    return data;
  }

  bool get isSuccess => status == AppEndpoint.SUCCESS;

  bool get isError => status != AppEndpoint.SUCCESS;
}
