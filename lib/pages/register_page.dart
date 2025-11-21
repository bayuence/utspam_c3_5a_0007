import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              final username = _usernameController.text;
              final password = _passwordController.text;
              if (username.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Input tidak boleh kosong')),
                );
                return;
              } 
              //simpan data register
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('saved_username', username);
              await prefs.setString('saved_password', password);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Register berhasil, silakan login')),
              );
              Navigator.pop(context);
            }, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}