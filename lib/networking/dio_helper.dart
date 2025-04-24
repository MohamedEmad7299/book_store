

import 'package:dio/dio.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://gutendex.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
  }) async {

    dio!.options.headers = {
      'Content-Type': 'application/json',
    };

    return await dio!.get(
      path,
    );
  }
}