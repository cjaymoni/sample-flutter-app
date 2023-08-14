import 'package:flutter/material.dart';
import 'package:sample_report_app/app_screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: LoginScreen(), // Use the LoginScreen widget
    );
  }
}
