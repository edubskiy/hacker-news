import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIDs returns a list of IDs', () async {
    final newsAPI = NewsAPIProvider();

    newsAPI.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3]), 200);
    });

    final ids = await newsAPI.fetchTopIDs();

    expect(ids, [1, 2, 3]);
  });
}
