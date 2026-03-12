import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  int currentIndex = 1;

  final routes = ['/home/create', '/home/feed', '/home/profile'];

  @action
  void changeTab(int index) {
    currentIndex = index;

    Modular.to.navigate(routes[index]);
  }
}
