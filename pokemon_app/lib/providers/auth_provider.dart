import 'package:flutter/foundation.dart';
import 'package:pokemon_app/api/api_service.dart';
import 'package:pokemon_app/models/user.dart';
import 'package:pokemon_app/utils/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isAuthenticated = false;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  final ApiService _apiService = ApiService(baseUrl: Constants.backendBaseUrl);

  Future<void> login(String email, String password) async {
    try {
      final response = await _apiService.post('login', {'email': email, 'password': password});
      _user = User.fromJson(response['user']);
      _isAuthenticated = true;
      await _saveToken(response['token']);
      notifyListeners();
    } catch (e) {
      throw Exception('Falló el ingreso: $e');
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      final response = await _apiService.post('register', {
        'username': username,
        'email': email,
        'password': password,
      });
      _user = User.fromJson(response['user']);
      _isAuthenticated = true;
      await _saveToken(response['token']);
      notifyListeners();
    } catch (e) {
      throw Exception('Falló el registro: $e');
    }
  }

  Future<void> logout() async {
    _user = null;
    _isAuthenticated = false;
    await _removeToken();
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final token = await _getToken();
    if (token != null) {
      try {
        final response = await _apiService.get('user');
        _user = User.fromJson(response);
        _isAuthenticated = true;
      } catch (e) {
        await _removeToken();
      }
    }
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}