// lib/screens/home/home_screen.dart
import 'package:dekorin_flutter/api/dekorasi_service.dart';
import 'package:dekorin_flutter/models/dekorasi.dart';
import 'package:dekorin_flutter/screens/detail_dekorasi_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Dekorasi>> _dekorasiList; // List dekorasi
  List<Dekorasi> _filteredDekorasi = []; // List dekorasi yang difilter

  @override
  void initState() {
    super.initState();
    _dekorasiList = DekorasiService().getDekorasi(); // Ambil semua dekorasi
  }

  void _filterDekorasi(String query) async {
    final allDekorasi = await _dekorasiList;
    setState(() {
      _filteredDekorasi = allDekorasi
          .where((dekorasi) =>
              dekorasi.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        automaticallyImplyLeading: false, // Sembunyikan tombol back di beranda utama
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterDekorasi, // Panggil filter saat teks berubah
              decoration: InputDecoration(
                hintText: 'Cari disini',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Implementasi pencarian suara jika diperlukan
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Dekorasi>>(
              future: _dekorasiList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada dekorasi ditemukan.'));
                } else {
                  // Tampilkan hasil filter jika ada query, jika tidak, tampilkan semua
                  final displayList = _searchController.text.isEmpty
                      ? snapshot.data!
                      : _filteredDekorasi;

                  if (displayList.isEmpty) {
                    return const Center(child: Text('Tidak ada hasil untuk pencarian Anda.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.8, // Sesuaikan aspek rasio card
                    ),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final dekorasi = displayList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailDekorasiScreen(dekorasi: dekorasi),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  child: Image.network(
                                    dekorasi.imageUrl, // URL gambar dekorasi
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(child: Icon(Icons.broken_image, size: 50));
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  dekorasi.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Anda bisa menambahkan harga atau info lain di sini
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}