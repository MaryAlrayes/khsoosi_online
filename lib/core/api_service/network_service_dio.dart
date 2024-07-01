import 'dart:io';

import 'package:dio/dio.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import '../errors/dio_exceptions.dart';
import '../utils/services/shared_preferences.dart';
import 'base_api_service.dart';

class NetworkServiceDio implements BaseApiService {
  Future<Dio> get dio async {
    // String? token = PreferenceUtils.getString("TOKEN");

    BaseOptions options = BaseOptions(
      baseUrl: EndPointsManager.baseAppUrl,
      connectTimeout: const Duration(seconds: 100000),
      receiveTimeout: const Duration(seconds: 100000),
      headers: {
        "Content-Type": Headers.multipartFormDataContentType
        // if (token != null) 'Authorization': 'Bearer $token',
      },
      contentType: Headers.multipartFormDataContentType,
      responseType: ResponseType.json,
    );

    Dio dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        // Do something with response data

        return handler.next(response); // continue
      },
      onError: (e, handler) {
        print('error is $e');
        throw DioExceptions.handle(e).failure;
      },
    ));

    return dio;
  }

  @override
  Future deleteRequest({required String url}) {
    throw UnimplementedError();
  }

  @override
  Future getRequest({required String url}) async {
    print('API $url');
    Dio _dio = await dio;

    try {
      var response = await _dio.get(
        url,
      );

      print('status code ${response.statusCode}');
      print('response data ${response.data}');
      return response.data;
    } catch (error) {
      throw DioExceptions.handle(error).failure;
    }
  }

  @override
  Future multipartRequest({
    required String url,
    required Map<String, dynamic> jsonBody,
    Map<String, dynamic>? headers,
    bool saveCookies = false,
    String? cookieName,
    String? filesAttributeName,
    List<File>? files,
  }) async {
    print('API $url');
    Dio _dio = await dio;
    try {
      if (filesAttributeName != null && files != null) {
        List<MultipartFile> docsFile = [];
        for (var element in files) {
          String fileName = element.path.split('/').last;
          docsFile.add(
            await MultipartFile.fromFile(
              element.path,
              filename: fileName,
            ),
          );
        }
        jsonBody[filesAttributeName] = docsFile;
      }

      FormData formData = FormData.fromMap(jsonBody);
      print('body: ${formData.fields}');
      if (headers != null) {
        _dio.options.headers = headers;
      }
      final response = await _dio.post(
        url,
        data: formData,
      );

      //save specific cookie if the user send saveCookies as true
      if (saveCookies) {
        final setCookieHeader = response.headers['Set-Cookie'];
        if (setCookieHeader != null) {
          final cookieValue = extractSpecificCookieValue(
              cookiesList: setCookieHeader, cookieName: cookieName!);
          PreferenceUtils.setString(cookieName, cookieValue!);
          print('Stored value: $cookieValue');
        }
      }

      print('status code ${response.statusCode}');
      print('response data ${response.data}');
      print('cookies ${response.headers['Set-Cookie']}');
      return response.data;
    } catch (error) {
      throw DioExceptions.handle(error).failure;
    }
  }

  @override
  Future postRequest({
    required String url,
    required Map<String, dynamic> jsonBody,
  }) async {
    print('API $url');
    try {
      Dio _dio = await dio;
      var response = await _dio.post(url, data: jsonBody);
      print('body: $jsonBody');
      print('status code ${response.statusCode}');
      print('response data ${response.data}');
      return response.data;
    } catch (error) {
      throw DioExceptions.handle(error).failure;
    }
  }

  String? extractSpecificCookieValue(
      {required List<String> cookiesList, required String cookieName}) {
    for (String cookie in cookiesList) {
      if (cookie.startsWith('$cookieName=')) {
        final mobileQueriesValue =
            RegExp('$cookieName=([^;]+)').firstMatch(cookie)?.group(1);
        return mobileQueriesValue;
      }
    }
    return null;
  }
}
