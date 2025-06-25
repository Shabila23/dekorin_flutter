// lib/screens/splash_screen.dart
import 'package:dekorin_flutter/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Untuk Timer

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Setelah 3 detik, navigasi ke OnboardingScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF4), // Warna latar belakang sesuai gambar referensi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar logo Dekorasi (sesuaikan path jika berbeda)
            Image.asset(
              'assets/images/dekorin_logo.png', // Ganti dengan path logo Anda
              width: 150, // Sesuaikan ukuran logo
              height: 150,
            ),
            const SizedBox(height: 20), // Spasi antara logo dan teks
            const Text(
              'DEKORIN',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333), // Warna teks gelap
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Dekorasi Impian Anda', // Slogan atau tagline
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF666666), // Warna teks abu-abu
              ),
            ),
          ],
        ),
      ),
    );
  }
}