import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import '../errors/dio_exceptions.dart';
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
    // TODO: implement deleteRequest
    throw UnimplementedError();
  }

  @override
  Future getRequest({required String url}) async {
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
    String? filesAttributeName,
    List<File>? files,
  }) async {
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
      final response = await _dio.post(url, data: formData);

      print('status code ${response.statusCode}');
      print('response data ${response.data}');
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
}
