import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/pages/home/home_page.dart';
import 'package:utspam_c3_5a_0007/pages/login/register_page.dart';
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
      appBar: AppBar(title: const Text('Login')),
      
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Input Username
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 20),

            // Input Password
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40),

            // Tombol Login
            ElevatedButton(
              onPressed: () async {
                final inputUsername = _usernameController.text.trim();
                final inputPassword = _passwordController.text.trim();

                if (inputUsername.isEmpty || inputPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Semua field wajib diisi")),
                  );
                  return;
                }

                // ambil user tersimpan di SharedPref
                final user = SharedPrefService.getUser();

                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Belum ada user. Silakan register")),
                  );
                  return;
                }

                final savedUsername = user['username'];
                final savedPassword = user['password'];

                if (inputUsername == savedUsername &&
                    inputPassword == savedPassword) {

                  // simpan status login
                  await SharedPrefService.setLoginStatus(true);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login berhasil")),
                  );

                  // pindah ke HomePage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Username atau Password salah")),
                  );
                }
              },
              child: const Text("Login"),
            ),

            const SizedBox(height: 20),

            // Tombol pergi ke Register
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text("Belum punya akun? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
