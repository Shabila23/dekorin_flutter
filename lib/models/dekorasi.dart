// lib/models/dekorasi.dart
class Dekorasi {
  final int id;
  final String name;
  final String imageUrl;
  final String description; // Contoh deskripsi
  final String category; // Kategori dekorasi
  final double price; // Harga dekorasi

  Dekorasi({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.price,
  });

  factory Dekorasi.fromJson(Map<String, dynamic> json) {
    return Dekorasi(
      id: json['id'],
      name: json['name'] ?? 'Nama Dekorasi',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150', // URL gambar default
      description: json['description'] ?? 'Deskripsi dekorasi.',
      category: json['category'] ?? 'Umum',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}