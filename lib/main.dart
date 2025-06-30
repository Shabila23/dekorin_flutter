import 'package:flutter/material.dart';
import 'package:dekorin_flutter/screens/splash_screen.dart';
import 'package:dekorin_flutter/theme.dart'; // import theme

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dekorin App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // gunakan theme dari file external
      home: SplashScreen(),
    );
  }
}
