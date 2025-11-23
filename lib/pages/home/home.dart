import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/services/local_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    var data = await LocalStorage().getUser();
    setState(() {
      user = data;
    });
  }

  void logout() async {
    await LocalStorage().removeUser();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Car Rent ENCE App"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo, ${user!["nama"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        menuItem(
                          "Sewa Mobil",
                          Icons.car_rental,
                          () => Navigator.pushNamed(context, '/carlist'),
                        ),
                        menuItem(
                          "Riwayat Sewa",
                          Icons.history,
                          () => Navigator.pushNamed(context, '/history'),
                        ),
                        menuItem(
                          "Profil",
                          Icons.person,
                          () => Navigator.pushNamed(context, '/profil'),
                        ),
                        menuItem("Logout", Icons.logout, logout),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget menuItem(String title, IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
