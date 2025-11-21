import 'package:flutter/material.dart';
import 'package:utspam_c3_5a_0007/services/shared_pref_service.dart';

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
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
              final username = _usernameController.text.trim();
              final password = _passwordController.text.trim();
              if (username.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Input tidak boleh kosong')),
                );
                return;
              } 

              await SharedPrefService.saveUser(username, password);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Register berhasil, silakan login')),
              );
              Navigator.pop(context);
            },
              child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}         
        