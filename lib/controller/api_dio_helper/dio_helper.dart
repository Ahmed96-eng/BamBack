import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "http://qatan-ksa.com/api/",
          receiveDataWhenStatusError: true),
    );
  }

  static getData({
    required String? endpoint,
  }) async {
    return await dio!.get(
      endpoint!,
    );
  }

  static postData({
    required String? endpoint,
    required Map<String, dynamic>? data,
  }) async {
    FormData formData = FormData.fromMap(data!);
    try {
      return await dio!.post(
        endpoint!,
        data: formData,
      );
    } catch (error) {
      print(error);
    }
  }

  static Future<Response> putData({
    @required String? endpoint,
    @required Map<String, dynamic>? data,
    // dynamic quray,
    // String lang = 'en',
    // String? token,
  }) async {
    dio!.options.headers = {
      // "lang": lang,
      // 'Content-Type': 'application/json',
      // "Authorization": token,
    };
    return await dio!.put(
      endpoint!,
      data: data,
      // queryParameters: quray ?? null,
    );
  }
}
