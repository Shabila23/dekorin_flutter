// lib/screens/home/main_wrapper.dart
import 'package:dekorin_flutter/screens/account/account_screen.dart';
import 'package:dekorin_flutter/screens/categories/categories_screen.dart/categories_screen.dart';
import 'package:dekorin_flutter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0; // Indeks halaman yang sedang aktif

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex, // Indeks yang sedang aktif
        selectedItemColor: const Color(0xFF4A686A), // Warna ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
        onTap: _onItemTapped, // Callback saat item ditekan
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed, // Pastikan semua label terlihat
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}