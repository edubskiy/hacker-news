import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIDs = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Stream<List<int>> get topIDs => _topIDs.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIDs() async {
    final ids = await _repository.fetchTopIDs();

    _topIDs.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCache();
  }

  dispose() {
    _topIDs.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);

        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }
}
