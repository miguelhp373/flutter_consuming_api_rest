import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/app_start.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const AppStart());
}
