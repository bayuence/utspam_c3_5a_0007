import 'package:utspam_c3_5a_0007/pages/booking/car_list.dart';
import 'package:utspam_c3_5a_0007/pages/booking/detail_sewa.dart';
//import 'package:utspam_c3_5a_0007/pages/booking/edit_sewa.dart';
import 'package:utspam_c3_5a_0007/pages/booking/from_sewa.dart';
import 'package:utspam_c3_5a_0007/pages/booking/history.dart';
import 'package:utspam_c3_5a_0007/pages/home/home.dart';
import 'package:utspam_c3_5a_0007/pages/auth/login.dart';
import 'package:utspam_c3_5a_0007/pages/profile/profile.dart';
import 'package:utspam_c3_5a_0007/pages/auth/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/carlist': (context) => const CarListPage(),
        '/history': (context) => const HistoryPage(),
        '/profil': (context) => const ProfilPage(),
        '/formsewa': (context) => const FormSewaPage(),
        '/detailsewa': (context) => const DetailSewaPage(),
        //'/editsewa': (context) => const EditSewaPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Halaman tidak ditemukan',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/home'),
                    child: const Text('Kembali ke Home'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
