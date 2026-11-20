import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth/auth_service.dart';

class AuthNotifier with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorCode;
  bool get isLoading => _isLoading;
  String? get errorCode => _errorCode;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    _errorCode = null;
    try {
      User? user = await _authService.signUp(email, password);
      return user != null;
    } on FirebaseAuthException catch (error) {
      _errorCode = error.code;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _errorCode = null;
    try {
      User? user = await _authService.signIn(email, password);
      return user != null;
    } on FirebaseAuthException catch (error) {
      _errorCode = error.code;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
