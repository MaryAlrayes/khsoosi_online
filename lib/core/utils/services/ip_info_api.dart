
import 'package:dio/dio.dart';

class IpInfoApi {

  static Future<String?> getPublicIp() async {
    final url = ('https://api.ipify.org');
    Dio _dio = await Dio();
    try {
      var response = await _dio.get(
        url,
      );
      return response.statusCode == 200 ? response.data : null;
    } catch (error) {
      return null;
    }
  }



}
