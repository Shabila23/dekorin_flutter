// lib/screens/checkout_screen.dart
import 'package:dekorin_flutter/api/dekorasi_service.dart';
import 'package:dekorin_flutter/models/dekorasi.dart';
import 'package:dekorin_flutter/screens/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  final Dekorasi dekorasi;

  const CheckoutScreen({Key? key, required this.dekorasi}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final DekorasiService _dekorasiService = DekorasiService();
  bool _isLoading = false;

  void _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    final result = await _dekorasiService.purchaseDekorasi(
      widget.dekorasi.id,
      widget.dekorasi.price,
    );

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PaymentSuccessScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Pembelian gagal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF4),
      appBar: AppBar(
        title: const Text('Konfirmasi Pemesanan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.dekorasi.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              widget.dekorasi.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Harga: Rp ${widget.dekorasi.price.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, color: Color(0xFF4A686A)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Informasi Pemesanan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Informasi pemesanan bisa diambil dari user yang login dan tanggal
            // Untuk sementara kita gunakan placeholder
            Text('Pemesanan: Bunga Cinta Lestari'), // Nama user yang login
            Text('Tanggal pemesanan: ${DateFormat('dd MMMM yyyy').format(DateTime.now())}'),
            Text('Dekorasi: ${widget.dekorasi.name}'),
            Text('Tema: ${widget.dekorasi.category}'), // Menggunakan kategori sebagai tema

            const Expanded(child: SizedBox()), // Ambil sisa ruang
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: ElevatedButton(
                      onPressed: _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A686A),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Pesan Sekarang', // Atau 'Lanjutkan Pembayaran'
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}