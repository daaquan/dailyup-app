import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_client.dart';

class AuthService {
  AuthService({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    final response = await _client.dio.post('/login', data: {
      'email': email,
      'password': password,
    });
    final token = response.data['token'] as String?;
    if (token != null) {
      await _storage.write(key: 'token', value: token);
    }
  }
}
