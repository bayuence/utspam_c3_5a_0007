import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/pages/login_page.dart';

void main() {
  runApp(const CarRentalEnce());
}

class CarRentalEnce extends StatelessWidget {
  const CarRentalEnce({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}
