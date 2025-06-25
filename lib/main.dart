// lib/main.dart
import 'package:dekorin_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dekorin App',
      theme: ThemeData(
        primarySwatch: Colors.green, // Contoh warna primary
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFFBFBF4), // Warna latar belakang umum aplikasi
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFBFBF4), // Warna app bar
          foregroundColor: Colors.black, // Warna ikon dan teks di app bar
          elevation: 0, // Tanpa shadow
        ),
      ),
      home: SplashScreen(), // Aplikasi dimulai dari SplashScreen
    );
  }
}