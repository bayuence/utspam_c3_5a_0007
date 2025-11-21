import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utspam_c3_5a_0007/pages/home/home_page.dart';
import 'package:utspam_c3_5a_0007/pages/login/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(CarRentalEnce(isLoggedIn: isLoggedIn));
}

class CarRentalEnce extends StatelessWidget {
  final bool isLoggedIn;

  const CarRentalEnce({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
