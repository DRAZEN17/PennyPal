import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
void main() {
  runApp(const PennyPalApp());
}

class PennyPalApp extends StatelessWidget {
  const PennyPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PennyPal',
      home: const SplashScreen(),
    );
  }
}
