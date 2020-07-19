import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[newsDBProvder, NewsAPIProvider()];
  List<Cache> caches = <Cache>[newsDBProvder];

  // TODO iterate over sources when NewsDBProvder
  // will have method fetchTopIDs
  Future<List<int>> fetchTopIDs() {
    return sources[1].fetchTopIDs();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);

      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIDs();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
