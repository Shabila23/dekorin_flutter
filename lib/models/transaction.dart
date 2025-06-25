// lib/models/transaction.dart
class Transaction {
  final int id;
  final int userId;
  final int? dekorasiId; // Nullable karena bisa jadi top-up
  final String type; // 'top-up' atau 'purchase'
  final double amount;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime createdAt;
  final String? dekorasiName; // Nama dekorasi jika transaksi purchase

  Transaction({
    required this.id,
    required this.userId,
    this.dekorasiId,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.dekorasiName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      dekorasiId: json['dekorasi_id'], // Sesuaikan nama field dari API
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      dekorasiName: json['dekorasi_name'], // Asumsi API mengembalikan ini untuk transaksi purchase
    );
  }
}