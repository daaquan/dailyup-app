import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../models/topic.dart';
import '../services/api_client.dart';

class TopicsProvider extends ChangeNotifier {
  TopicsProvider({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  final List<Topic> items = [];

  bool loading = false;
  bool hasError = false;
  int page = 1;
  bool hasMore = true;

  Future<void> fetchFirstPage() async {
    page = 1;
    items.clear();
    hasMore = true;
    await _load();
  }

  Future<void> fetchMore() async {
    if (!hasMore || loading) return;
    page++;
    await _load();
  }

  Future<void> _load() async {
    loading = true;
    hasError = false;
    notifyListeners();
    try {
      final response = await _client.dio.get(
        '/api/v1/topics',
        queryParameters: {'page': page, 'per_page': 20},
      );
      final data = response.data as Map<String, dynamic>;
      final list = data['topics'] as List<dynamic>? ?? [];
      items.addAll(list.map((e) => Topic.fromJson(e as Map<String, dynamic>)));
      hasMore = list.isNotEmpty;
    } on DioError catch (_) {
      hasError = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
