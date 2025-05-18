import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA59152),
              Color(0xFFA59152), // You can change this to add a two-tone gradient
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
