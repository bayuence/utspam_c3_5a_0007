import 'package:flutter/material.dart';

class EditSewaPage extends StatefulWidget {
  const EditSewaPage({super.key});

  @override
  State<EditSewaPage> createState() => _EditSewaPageState();
}

class _EditSewaPageState extends State<EditSewaPage> {
  Map<String, dynamic>? data;

  DateTime? tglMulai;
  int lama = 1;
  int harga = 0;
  int total = 0;

  var namaPenyewa = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Map<String, dynamic>) {
      Navigator.pop(context);
      return;
    }

    data = args["data"];

    if (data == null) {
      Navigator.pop(context);
      return;
    }

    namaPenyewa.text = data!["namaPenyewa"] ?? "-";
    lama = data!["lama"] ?? 1;
    harga = data!["harga"] ?? 0;

    try {
      final parts = data!["tanggal"].split("-");
      tglMulai = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (e) {
      tglMulai = DateTime.now();
    }

    hitungTotal();
  }

  void hitungTotal() {
    setState(() {
      total = lama * harga;
    });
  }

  void simpanPerubahan() {
    if (tglMulai == null) return;

    var tglString = "${tglMulai!.day}-${tglMulai!.month}-${tglMulai!.year}";

    var newData = {
      "namaMobil": data!["namaMobil"],
      "jenis": data!["jenis"],
      "harga": harga,
      "tanggal": tglString,
      "lama": lama,
      "total": total,
      "namaPenyewa": namaPenyewa.text,
      "status": data!["status"] ?? "aktif",
    };

    Navigator.pop(context, newData);
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || tglMulai == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text("Memuat data...", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Penyewaan"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: namaPenyewa,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Nama Penyewa",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Tanggal Mulai", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),

            InkWell(
              onTap: () async {
                var pilih = await showDatePicker(
                  context: context,
                  initialDate: tglMulai!,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );

                if (pilih != null) {
                  setState(() {
                    tglMulai = pilih;
                    hitungTotal();
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
                  "${tglMulai!.day}-${tglMulai!.month}-${tglMulai!.year}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Lama Sewa (hari)",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (lama > 1) {
                      setState(() {
                        lama--;
                        hitungTotal();
                      });
                    }
                  },
                  icon: const Icon(Icons.remove, color: Colors.white),
                ),
                Text(
                  lama.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      lama++;
                      hitungTotal();
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Total Harga: Rp $total",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: simpanPerubahan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}
