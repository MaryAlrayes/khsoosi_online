import 'dart:io';

abstract class BaseApiService {
  Future<dynamic> getRequest({required String url});
  Future<dynamic> postRequest(
      {required String url, required Map<String, dynamic> jsonBody});
  Future<dynamic> multipartRequest({
    required String url,
    required Map<String, dynamic> jsonBody,
      String? filesAttributeName,
     List<File>? files,
  });
  Future<dynamic> deleteRequest(
      {required String url, });
}
