// lib/api/dekorasi_service.dart (Tambahkan atau buat file TransactionService)
// ... kode yang sudah ada ...
import 'dart:convert';

import 'package:dekorin_flutter/models/category.dart';
import 'package:dekorin_flutter/models/dekorasi.dart';
import 'package:dekorin_flutter/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DekorasiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  // ... (Metode getDekorasi, getDekorasiById, getCategories, getDekorasiByCategory) ...
  Future<List<Dekorasi>> getDekorasi() async {
    final response = await http.get(Uri.parse('$baseUrl/books')); // Asumsi 'books' di API Laravel adalah 'dekorasi'
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Dekorasi.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load dekorasi');
    }
  }

  Future<Dekorasi> getDekorasiById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/book/$id'));
    if (response.statusCode == 200) {
      return Dekorasi.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dekorasi');
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Dekorasi>> getDekorasiByCategory(String categoryName) async {
    final response = await http.get(Uri.parse('$baseUrl/books/category/$categoryName'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Dekorasi.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load dekorasi by category');
    }
  }

  Future<Map<String, dynamic>> topUpSaldo(double amount) async {
    final token = await _getToken();
    if (token == null) {
      return {'success': false, 'message': 'Token tidak tersedia. Silakan login kembali.'};
    }

    final response = await http.post(
      Uri.parse('$baseUrl/top-up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return {'success': true, 'message': responseData['message']};
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'message': errorData['message'] ?? 'Top up gagal'};
    }
  }

  Future<Map<String, dynamic>> purchaseDekorasi(int dekorasiId, double amount) async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      return {'success': false, 'message': 'Autentikasi diperlukan. Silakan login kembali.'};
    }

    final response = await http.post(
      Uri.parse('$baseUrl/transactions/payment'), // Route untuk pembelian
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'book_id': dekorasiId, // Ganti ke 'dekorasi_id' jika itu nama field di Laravel
        'amount': amount,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return {'success': true, 'message': responseData['message']};
    } else {
      final errorData = jsonDecode(response.body);
      return {'success': false, 'message': errorData['message'] ?? 'Pembelian gagal'};
    }
  }

  Future<List<Transaction>> getTransactionsByUser() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Autentikasi diperlukan untuk melihat riwayat transaksi.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/transactions/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Transaction.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load transaction history');
    }
  }
}