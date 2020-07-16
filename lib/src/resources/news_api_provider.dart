import 'dart:convert';

import 'package:hacker_news/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewAPIProvider {
  Client client = Client();

  fetchTopIDs() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/v0/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
