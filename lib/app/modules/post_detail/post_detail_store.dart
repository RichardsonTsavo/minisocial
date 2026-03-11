import 'package:mobx/mobx.dart';

part 'post_detail_store.g.dart';

class PostDetailStore = _PostDetailStoreBase with _$PostDetailStore;

abstract class _PostDetailStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
