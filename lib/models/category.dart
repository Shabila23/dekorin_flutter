// lib/models/category.dart
class Category {
  final int id;
  final String name;
  final String imageUrl; // Jika ada gambar untuk kategori

  Category({required this.id, required this.name, this.imageUrl = ''});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'] ?? '',
    );
  }
}