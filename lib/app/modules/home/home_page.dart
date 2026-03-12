import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: Observer(
        builder: (context) {
          return BottomNavigationBar(
            currentIndex: store.currentIndex,
            onTap: store.changeTab,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "Criar Post"),

              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Feed"),

              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
            ],
          );
        },
      ),
    );
  }
}
