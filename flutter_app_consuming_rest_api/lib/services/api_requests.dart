import 'package:dio/dio.dart';
//only local host tests on chrome with api localhost don't https ssl
//flutter run -d chrome --web-browser-flag "--disable-web-security"

class ApiRequest {
  final _basePathURL = 'http://192.168.15.71:3000';

  Future<Response<dynamic>> fetchData(String pathName) async {
    try {
      final dio = Dio();
      dio.options.validateStatus = (status) => true;
      print(dio.get(_basePathURL + pathName));
      return await dio.get(_basePathURL + pathName);
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }
}
