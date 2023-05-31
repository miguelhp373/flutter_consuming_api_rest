import 'package:flutter_app_consuming_rest_api/services/api_requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Users {
  Future<String> getTotalUserFromDataBase() async {
    http.Response resultData = await ApiRequest().fetchData('/users/all');

    if (resultData.statusCode == 200) {
      String jsonData = resultData.body;
      List<dynamic> data = jsonDecode(jsonData);

      return data.length.toString();
    }

    throw Exception('Failed to fetch total users');
  }
}
