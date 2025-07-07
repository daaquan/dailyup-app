import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/topic.dart';

class TopicsProvider extends ChangeNotifier {
  TopicsProvider({http.Client? client}) : _client = client ?? http.Client();

  static const String baseUrl = 'https://example.com';

  final http.Client _client;

  final List<Topic> _topics = [];
  List<Topic> get topics => List.unmodifiable(_topics);

  bool isLoading = false;
  bool hasError = false;
  int _page = 1;
  bool _hasMore = true;

  Future<void> fetch({required String category}) async {
    _page = 1;
    _topics.clear();
    _hasMore = true;
    await _load(category: category);
  }

  Future<void> loadMore({required String category}) async {
    if (!_hasMore || isLoading) return;
    _page++;
    await _load(category: category);
  }

  Future<void> _load({required String category}) async {
    isLoading = true;
    hasError = false;
    notifyListeners();
    try {
      final uri = Uri.parse(
          '$baseUrl/api/v1/topics?category=$category&page=$_page');
      final response = await _client.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final items = data['topics'] as List<dynamic>? ?? [];
        for (final item in items) {
          _topics.add(Topic.fromJson(item as Map<String, dynamic>));
        }
        _hasMore = items.isNotEmpty;
      } else {
        hasError = true;
      }
    } catch (_) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
