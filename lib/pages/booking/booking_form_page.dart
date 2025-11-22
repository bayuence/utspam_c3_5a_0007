import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/models/car_model.dart';
import 'package:utspam_c3_5a_0007/services/shared_pref_service.dart';

class BookingFormPage extends StatefulWidget {
  final CarModel mobil;

  const BookingFormPage({super.key, required this.mobil});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tglMulaiController = TextEditingController();
  final TextEditingController tglSelesaiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking ${widget.mobil.nama}"),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(widget.mobil.gambarUrl, height: 180, fit: BoxFit.cover),
            ),

            const SizedBox(height: 20),

            Text(
              widget.mobil.nama,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(
              "Rp ${widget.mobil.hargaPerHari} / hari",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _field("Nama Penyewa", namaController),
            const SizedBox(height: 15),

            _field("Tanggal Mulai (contoh: 2025-11-01)", tglMulaiController),
            const SizedBox(height: 15),

            _field("Tanggal Selesai (contoh: 2025-11-03)", tglSelesaiController),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final nama = namaController.text.trim();
                  final mulai = tglMulaiController.text.trim();
                  final selesai = tglSelesaiController.text.trim();

                  if (nama.isEmpty || mulai.isEmpty || selesai.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Isi semua data booking")),
                    );
                    return;
                  }

                  SharedPrefService.saveBooking(
                    nama: nama,
                    mobil: widget.mobil.nama,
                    mulai: mulai,
                    selesai: selesai,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking berhasil disimpan")),
                  );

                  Navigator.pop(context);
                },
                child: const Text("Simpan Booking", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
