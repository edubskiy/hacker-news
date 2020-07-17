import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';

class Repository {
  NewsDBProvder dbProvider = NewsDBProvder();
  NewsAPIProvider apiProvider = NewsAPIProvider();

  Future<List<int>> fetchTopIDs() {
    return apiProvider.fetchTopIDs();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);

    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);

    dbProvider.addItem(item);

    return item;
  }
}
