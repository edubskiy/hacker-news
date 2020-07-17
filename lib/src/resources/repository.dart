import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';

class Repository {
  NewsDBProvder dbProvider = NewsDBProvder();
  NewsAPIProvider apiProvider = NewsAPIProvider();

  fetchTopIDs() {
    return apiProvider.fetchTopIDs();
  }

  fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);

    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);

    dbProvider.addItem(item);

    return item;
  }
}
