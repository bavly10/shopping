import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://kash5tak.com/api',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'api_password': '&-q^Tm9\$!5fY3nXj',
          'lang': 'ar'
        }));
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> postData1(
      {required String url,
      Map<String, dynamic>? query,
      required FormData data}) async {
    return await dio.post(url, queryParameters: query, data: data);
  }
}
