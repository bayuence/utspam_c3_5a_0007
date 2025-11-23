import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/services/local_storage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> riwayat = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var data = await LocalStorage().getRiwayat();
    setState(() {
      riwayat = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Riwayat Sewa"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: riwayat.isEmpty
          ? const Center(
              child: Text(
                "Belum ada riwayat sewa",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                var item = riwayat[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  elevation: 3,
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["namaMobil"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Jenis: ${item["jenis"]}",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        Text(
                          "Tanggal: ${item["tanggal"]}",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        Text(
                          "Lama: ${item["lama"]} hari",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        Text(
                          "Harga per hari: Rp ${item["harga"]}",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Total: Rp ${item["total"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 10),

                      
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/detailsewa',
                              arguments: {"data": item, "index": index},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Detail"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: BottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/carlist');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/profil');
            }
          },
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Sewa Mobil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
