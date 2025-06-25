// lib/api/auth_service.dart
import 'dart:convert';
import 'package:dekorin_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Ganti dengan base URL API Laravel Anda
  static const String baseUrl = "http://127.0.0.1:8000/api"; // Ganti XX dengan IP Anda atau domain

  Future<Map<String, dynamic>> registerUser(String name, String email, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Asumsi API mengembalikan token dan data user setelah registrasi berhasil
      await _saveToken(responseData['token']);
      return {'success': true, 'user': User.fromJson(responseData['user'])};
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'message': errorData['message'] ?? 'Registrasi gagal'};
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Asumsi API mengembalikan token dan data user setelah login berhasil
      await _saveToken(responseData['token']);
      // Simpan juga user ID untuk kebutuhan transaksi
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', responseData['user']['id']);
      return {'success': true, 'user': User.fromJson(responseData['user'])};
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'message': errorData['message'] ?? 'Login gagal'};
    }
  }

  Future<void> logout() async {
    final token = await getToken();
    if (token == null) return; // Tidak ada token, tidak perlu logout

    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    await _clearToken();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('userId'); // Hapus juga user ID saat logout
  }

  Future<User?> getProfile() async {
    final token = await getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return User.fromJson(responseData);
    } else {
      return null;
    }
  }
}