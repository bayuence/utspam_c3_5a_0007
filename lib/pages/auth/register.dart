import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/models/user.dart';
import 'package:utspam_c3_5a_0007/services/local_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaC = TextEditingController();
  final nikC = TextEditingController();
  final emailC = TextEditingController();
  final teleponC = TextEditingController();
  final alamatC = TextEditingController();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool loading = false;

  void register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    User user = User(
      nama: namaC.text,
      nik: nikC.text,
      email: emailC.text,
      telepon: teleponC.text,
      alamat: alamatC.text,
      username: usernameC.text,
      password: passwordC.text,
    );

    await LocalStorage().saveUser(user.toMap());

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => loading = false);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pendaftaran berhasil!")));

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              inputField(controller: namaC, label: "Nama Lengkap"),
              const SizedBox(height: 15),
              inputField(
                controller: nikC,
                label: "NIK",
                keyboard: TextInputType.number,
              ),
              const SizedBox(height: 15),
              inputField(
                controller: emailC,
                label: "Email",
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              inputField(
                controller: teleponC,
                label: "No Telepon",
                keyboard: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              inputField(controller: alamatC, label: "Alamat"),
              const SizedBox(height: 15),
              inputField(controller: usernameC, label: "Username"),
              const SizedBox(height: 15),
              inputField(
                controller: passwordC,
                label: "Password",
                isPassword: true,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
                          "Daftar",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text(
                  "Sudah punya akun? Login",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboard,
      obscureText: isPassword,
      validator: (v) => (v == null || v.isEmpty) ? "Wajib diisi" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
