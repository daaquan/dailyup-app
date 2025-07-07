import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

import 'package:dailyup_app/services/api_client.dart';

class FakeStorage extends Fake implements FlutterSecureStorage {
  String? value;
  @override
  Future<String?> read({required String key, IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async => value;
  @override
  Future<void> write({required String key, required String? value, IOSOptions? iOptions, AndroidOptions? aOptions, LinuxOptions? lOptions, WebOptions? webOptions, MacOsOptions? mOptions, WindowsOptions? wOptions}) async { this.value = value; }
}

void main() {
  test('Interceptor adds token header', () async {
    final storage = FakeStorage()..value = 'abc';
    final client = ApiClient(storage: storage);
    final options = RequestOptions(path: '/');
    client.dio.interceptors.first.onRequest(options, RequestInterceptorHandler());
    expect(options.headers['Authorization'], 'Bearer abc');
  });
}
