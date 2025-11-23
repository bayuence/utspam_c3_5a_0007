import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/services/local_storage.dart';

class DetailSewaPage extends StatefulWidget {
  const DetailSewaPage({super.key});

  @override
  State<DetailSewaPage> createState() => _DetailSewaPageState();
}

class _DetailSewaPageState extends State<DetailSewaPage> {
  Map<String, dynamic>? data;
  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  void loadData() {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Map) {
      Navigator.pop(context);
      return;
    }

    data = args["data"];
    index = args["index"] ?? 0;

    if (data == null) {
      Navigator.pop(context);
    }
  }


  void loadDataFromStorage() async {
    var all = await LocalStorage().getRiwayat();
    if (index < all.length) {
      setState(() {
        data = all[index];
      });
    }
  }

  void updateData(newData) async {
    var all = await LocalStorage().getRiwayat();
    all[index] = newData;
    await LocalStorage().saveRiwayatList(all);

    setState(() => data = newData);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Data berhasil diupdate")));
  }

  void cancelSewa() async {
    var all = await LocalStorage().getRiwayat();
    all[index]["status"] = "dibatalkan";
    await LocalStorage().saveRiwayatList(all);

    loadDataFromStorage();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Sewa dibatalkan")));
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Detail Penyewaan"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              data!["namaMobil"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Nama Penyewa : ${data!["namaPenyewa"] ?? '-'}",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "Jenis Mobil : ${data!["jenis"]}",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "Lama Sewa : ${data!["lama"]} hari",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "Tanggal Mulai : ${data!["tanggal"]}",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "Harga per Hari : Rp ${data!["harga"]}",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "Total : Rp ${data!["total"]}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Status : ${data!["status"] ?? "aktif"}",
              style: TextStyle(
                fontSize: 16,
                color: data!["status"] == "dibatalkan"
                    ? Colors.red
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            if (data!["status"] != "dibatalkan")
              ElevatedButton(
                onPressed: cancelSewa,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Batalkan Sewa"),
              ),

            const SizedBox(height: 10),

            if (data!["status"] != "dibatalkan")
              ElevatedButton(
                onPressed: () async {
                  final editedData = await Navigator.pushNamed(
                    context,
                    '/editsewa',
                    arguments: {"data": data, "index": index},
                  );

                  if (editedData != null) {
              
                    updateData(editedData);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Edit Sewa"),
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}
