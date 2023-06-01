// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRequest {
  ///////////////////////////////////////////
  final _basePathURL = dotenv.get('API_URL');
  ///////////////////////////////////////////

  Future<http.Response> fetchData(String pathName) async {
    //////////////////////////////////////

    var headerStrings = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    //////////////////////////////////////

    try {
      final url = Uri.parse(_basePathURL + pathName);

      final response = await http.get(url, headers: headerStrings);

      return response;
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }

  Future<http.Response> fetchDataByUserID(String pathName) async {
    //////////////////////////////////////

    var headerStrings = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    //////////////////////////////////////

    try {
      final url = Uri.parse(_basePathURL + pathName);
      final response = await http.get(url, headers: headerStrings);

      return response;
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }

  Future<http.Response> postDataByUserID(
    String pathName,
    Map<String, dynamic> data,
  ) async {
    //////////////////////////////////////

    var headerStrings = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    //////////////////////////////////////

    try {
      final url = Uri.parse(_basePathURL + pathName);
      final response =
          await http.post(url, headers: headerStrings, body: jsonEncode(data));

      return response;
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }

  Future<http.Response> patchDataByUserID(
    String pathName,
    Map<String, dynamic> data,
  ) async {
    //////////////////////////////////////

    var headerStrings = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    //////////////////////////////////////

    try {
      final url = Uri.parse(_basePathURL + pathName);
      final response =
          await http.patch(url, headers: headerStrings, body: jsonEncode(data));

      return response;
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }

  Future<http.Response> deleteUserByID(String pathName) async {
    try {
      final url = Uri.parse(_basePathURL + pathName);
      final response = await http.delete(url);

      return response;
    } catch (e) {
      print('API Error: $e');
      throw Exception('400 Bad Request');
    }
  }
}
