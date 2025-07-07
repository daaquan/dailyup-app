import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:dailyup_app/providers/topics_provider.dart';
import 'package:dailyup_app/services/api_client.dart';

class FakeApiClient extends ApiClient {
  FakeApiClient();
  final Dio dioInstance = Dio();
  @override
  Dio get dio => dioInstance;
}

void main() {
  test('fetchFirstPage updates items', () async {
    final client = FakeApiClient();
    client.dio.httpClientAdapter = FakeAdapter();

    final provider = TopicsProvider(client: client);
    await provider.fetchFirstPage();

    expect(provider.items.length, 1);
    expect(provider.hasMore, true);
  });
}

class FakeAdapter extends HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<List<int>>? stream, Future<void>? cancelFuture) async {
    final data = {
      'topics': [
        {
          'id': 1,
          'title': 'hello',
          'url': 'https://example.com',
          'published_at': DateTime.now().toIso8601String(),
        }
      ]
    };
    final body = ResponseBody.fromString(
      DioMixin.jsonEncode(data),
      200,
      headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
    );
    return body;
  }
}
