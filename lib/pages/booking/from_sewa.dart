import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/models/car.dart';
import 'package:utspam_c3_5a_0007/services/local_storage.dart';

class FormSewaPage extends StatefulWidget {
  const FormSewaPage({super.key});

  @override
  State<FormSewaPage> createState() => _FormSewaPageState();
}

class _FormSewaPageState extends State<FormSewaPage> {
  DateTime? tglMulai;
  int lamaSewa = 1;
  int totalHarga = 0;
  var namaPenyewa = TextEditingController();
  Car? mobil; 

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Car) {
      mobil = arguments;
      totalHarga = mobil!.harga * lamaSewa;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mobil == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                "Memuat data mobil...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Form Sewa Mobil"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(mobil!.gambar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Text(
              mobil!.nama,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(mobil!.jenis, style: TextStyle(color: Colors.grey[300])),
            Text(
              "Harga: Rp ${mobil!.harga}/hari",
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 20),


            TextFormField(
              controller: namaPenyewa,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Nama Penyewa *",
                labelStyle: const TextStyle(color: Colors.white70),
                hintText: "Masukkan nama lengkap penyewa",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama penyewa harus diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text(
              "Tanggal Mulai Sewa *",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),

            InkWell(
              onTap: () async {
                var pilih = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );
                if (pilih != null) {
                  setState(() {
                    tglMulai = pilih;
                    hitungTotal(mobil!.harga);
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[900],
                ),
                child: Text(
                  tglMulai == null
                      ? "Pilih tanggal"
                      : "${tglMulai!.day}-${tglMulai!.month}-${tglMulai!.year}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Lama Sewa (hari) *",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (lamaSewa > 1) {
                      setState(() {
                        lamaSewa--;
                        hitungTotal(mobil!.harga);
                      });
                    }
                  },
                  icon: const Icon(Icons.remove, color: Colors.white),
                ),
                Text(
                  lamaSewa.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      lamaSewa++;
                      hitungTotal(mobil!.harga);
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Total Harga: Rp $totalHarga",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

       
            ElevatedButton(
              onPressed: () {
                if (namaPenyewa.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Harap isi nama penyewa")),
                  );
                  return;
                }

                if (tglMulai == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Harap pilih tanggal mulai sewa"),
                    ),
                  );
                  return;
                }

                simpanSewa();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("Simpan Sewa"),
            ),
          ],
        ),
      ),
    );
  }

  void hitungTotal(int harga) {
    setState(() {
      totalHarga = harga * lamaSewa;
    });
  }

  void simpanSewa() async {

    var dataBaru = {
      "namaMobil": mobil!.nama,
      "jenis": mobil!.jenis,
      "harga": mobil!.harga,
      "tanggal": "${tglMulai!.day}-${tglMulai!.month}-${tglMulai!.year}",
      "lama": lamaSewa,
      "total": totalHarga,
      "namaPenyewa": namaPenyewa.text, 
      "status": "aktif",
    };

    List<Map<String, dynamic>> riwayatLama =
        await LocalStorage().getRiwayat() ?? [];

    riwayatLama.add(dataBaru);

    await LocalStorage().saveRiwayat(riwayatLama);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sewa berhasil disimpan")));

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    namaPenyewa.dispose();
    super.dispose();
  }
}
