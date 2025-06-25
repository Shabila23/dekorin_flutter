// lib/models/user.dart
class User {
  final int id;
  final String name;
  final String email;
  final double saldo; // Asumsi ada saldo

  User({required this.id, required this.name, required this.email, this.saldo = 0.0});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      saldo: (json['saldo'] as num?)?.toDouble() ?? 0.0, // Handle null atau tipe data berbeda
    );
  }
}