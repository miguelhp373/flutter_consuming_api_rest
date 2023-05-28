import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/utils/custom_theme.dart';
import 'package:flutter_app_consuming_rest_api/views/home_page.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DashBoard Users App',
      theme: CustomTheme.themeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
