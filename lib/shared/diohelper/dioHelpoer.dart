import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio;
  static init(){
    dio=Dio(BaseOptions(baseUrl: '',receiveDataWhenStatusError: true,
        headers: {
      'Content-Type':'application/json',
      'api_password':'q^Tm9\$!5fY3nXj-&',
    }));
  }
 static Future<Response> getData({required String url,required Map<String,dynamic> query}) async{
  return await dio.get(url,queryParameters:query);
  }
}