import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        //الموجود في postman
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query, // اعتقد خاص ب api
    String lang='en',
    String? token,
  }) async
  {
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
    'Authorization':token??'',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang='en',
    String? token,
  })async
  {
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return dio!.post(url,queryParameters: query,data: data);
  }


  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio!.options.headers =
    {
      'lang':lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}