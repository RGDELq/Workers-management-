import 'package:flutter/material.dart';
// import 'package:workers_managment_app/screens/report_form_screen.dart';
 import 'screens/splash_screen.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workers managment ',
      theme: ThemeData(
                fontFamily: 'Cairo', 
      ),
      home: const SplashScreen(),
    );
 } 
}
