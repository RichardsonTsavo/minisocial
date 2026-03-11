import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;
abstract class _FeedStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}