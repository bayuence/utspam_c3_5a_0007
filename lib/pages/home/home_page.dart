import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/pages/booking/booking_page.dart';
import 'package:utspam_c3_5a_0007/pages/booking/history_page.dart';
import 'package:utspam_c3_5a_0007/pages/profile/profile_page.dart';
import 'package:utspam_c3_5a_0007/services/shared_pref_service.dart';
import 'package:utspam_c3_5a_0007/pages/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fullName = "";

  @override
  void initState() {
    super.initState();
    final data = SharedPrefService.getUser();
    fullName = data?['name'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Halo, $fullName ",
          style: const TextStyle(color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Selamat datang di Car Rental Ence",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  menuCard("Booking Mobil", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const BookingPage()));
                  }),

                  menuCard("Riwayat Booking", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HistoryPage()));
                  }),

                  menuCard("Profil Saya", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()));
                  }),

                  menuCard("Logout", () async {
                    await SharedPrefService.logout();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (_) => false,
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuCard(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.08),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }
}
