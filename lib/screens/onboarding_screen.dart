// lib/screens/onboarding_screen.dart
import 'package:dekorin_flutter/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF4),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar onboarding (sesuai gambar referensi)
            Image.asset('assets/images/DekorinLogo.png', height: MediaQuery.of(context).size.height * 0.4, // Sesuaikan ukuran gambar
              fit: BoxFit.contain,), // Perhatikan kapitalisasi 'DekorinLogo.png'
            const SizedBox(height: 40),
            const Text(
              'WELCOME TO DEKORIN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Dekorasi untuk Segala Momen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman login setelah menekan tombol "Mulai"
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A686A), // Warna tombol
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Mulai',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}