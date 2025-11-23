import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/services/local_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool loading = false;

  void login() async {
    setState(() => loading = true);

    var data = await LocalStorage().getUser();
    await Future.delayed(const Duration(milliseconds: 600));

    setState(() => loading = false);

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Belum ada akun, silahkan daftar")),
      );
      return;
    }

    if (username.text == data["username"] &&
        password.text == data["password"]) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username atau password salah")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/ence_dev.png", width: 300, height: 300),
              const SizedBox(height: 0),
              const Text(
                "Car Rent ence App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: username,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: password,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                  ),
                  child: loading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: const Text(
                  "Belum punya akun? Daftar",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
