import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/pages/home_page.dart';
import 'package:utspam_c3_5a_0007/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [   
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
              final inputUsername = _usernameController.text;
              final inputPassword = _passwordController.text;

              if (inputUsername.isEmpty || inputPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Username dan Password tidak boleh kosong')),
                );
                return;
              } 

              final prefs = await SharedPreferences.getInstance();
              final savedUsername = prefs.getString('saved_username');
              final savedPassword = prefs.getString('saved_password');
              
              //validasi login
              if (savedUsername == null || savedPassword == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User tidak ditemukan, silakan register terlebih dahulu')),
                );
                return;
              }

              if (inputUsername == savedUsername && inputPassword == savedPassword) {
                prefs.setBool('isLoggedIn', true);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login berhasil')),
                );
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Username atau Password salah')),
                );
              }
            },
             child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}