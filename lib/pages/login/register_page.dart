import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/services/shared_pref_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Nomor HP'),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final username = _usernameController.text.trim();
                final email = _emailController.text.trim();
                final phone = _phoneController.text.trim();
                final password = _passwordController.text.trim();

                if (name.isEmpty ||
                    username.isEmpty ||
                    email.isEmpty ||
                    phone.isEmpty ||
                    password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semua field wajib diisi')),
                  );
                  return;
                }

                
                await SharedPrefService.saveUser(
                  name: name,
                  username: username,
                  email: email,
                  phone: phone,
                  password: password,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registrasi berhasil')),
                );

                Navigator.pop(context); // kembali ke login
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
