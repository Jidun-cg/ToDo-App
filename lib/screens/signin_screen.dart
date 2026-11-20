import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_notifier.dart';
import '../utils/snackbar_helper.dart';
import 'signup_screen.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              controller: emailController,

              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              controller: passwordController,

              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: screenWidth * 0.05),
            ElevatedButton(
              onPressed: authNotifier.isLoading
                  ? null
                  : () async {
                      bool success = await authNotifier.signIn(
                        emailController.text,
                        passwordController.text,
                      );
                      // hapus kode ini
                      // if (!success) print("Gagal Sign In");
                      if (!success) {
                        if (context.mounted) {
                          SnackBarHelper.show(
                            context,
                            _authErrorMessage(authNotifier.errorCode),
                          );
                        }
                      }
                    },
              child: authNotifier.isLoading
                  ? CircularProgressIndicator()
                  : Text('Login'),
            ),

            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignUpScreen()),
              ),
              child: Text('Belum punya akun? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  String _authErrorMessage(String? code) {
    switch (code) {
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return 'Email atau password salah';
      case 'invalid-email':
        return 'Format email tidak valid';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti';
      case 'network-request-failed':
        return 'Periksa koneksi internet';
      case 'operation-not-allowed':
        return 'Provider Email/Password belum diaktifkan di Firebase Console';
      default:
        return 'Login gagal${code == null ? '' : ' ($code)'}';
    }
  }
}
