import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/data/car_data.dart';
import 'package:utspam_c3_5a_0007/models/car.dart';

class CarListPage extends StatelessWidget {
  const CarListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pilih Mobil"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: carList.length,
        itemBuilder: (context, index) {
          Car mobil = carList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            elevation: 3,
            color: Colors.grey[900],
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(mobil.gambar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mobil.nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          mobil.jenis,
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        Text(
                          "Rp ${mobil.harga}/hari",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/formsewa', arguments: mobil);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Pilih"),
                ),

                const SizedBox(width: 10),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/history');
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
