import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_exception.dart';

class ApiBaseHelper {
  ApiBaseHelper();
  Dio dio = Dio();

  Future<Response> get(String url) async {
    debugPrint('Url : $url');
    Response response;
    try {
      dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url);
      debugPrint(response.data.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection.');
    }
    return response;
  }

  Future<Response> post(String url, dynamic data) async {
    debugPrint('{Url : $url,\nbody: ${data.toString()}');
    // String? token = await LocalPrefs.getToken();
    Response response;
    try {
      dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      debugPrint(response.data.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection.');
    }
    return response;
  }
}
