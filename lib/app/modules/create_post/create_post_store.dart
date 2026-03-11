import 'package:mobx/mobx.dart';

part 'create_post_store.g.dart';

class CreatePostStore = _CreatePostStoreBase with _$CreatePostStore;

abstract class _CreatePostStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
