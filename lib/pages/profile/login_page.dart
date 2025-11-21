import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/pages/home/home_page.dart';
import 'package:utspam_c3_5a_0007/pages/profile/register_page.dart';
import 'package:utspam_c3_5a_0007/services/shared_pref_service.dart';

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
              final inputUsername = _usernameController.text.trim();
              final inputPassword = _passwordController.text.trim();

              if (inputUsername.isEmpty || inputPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Username dan Password tidak boleh kosong')),
                );
                return;
              }

              //ambil user yg terdaftar
              final user = SharedPrefService.getUser();

              //kalau belum pernah register
              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User tidak ditemukan, silakan register terlebih dahulu')),
                );
                return;
              }

              final savedUsername = user['username'];
              final savedPassword = user['password'];

              //cocokin login
              if (inputUsername == savedUsername && inputPassword == savedPassword) {
                //set status login
                await SharedPrefService.setLoginStatus(true);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login berhasil')),
                );

                //pindah ke home
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
        )
            ,
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Belum punya akun? Register di sini'),
            ),
          ],
        ),
      ),
    );
  }
}