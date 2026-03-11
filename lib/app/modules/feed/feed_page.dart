import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/feed/feed_store.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key? key, this.title = 'FeedPage'}) : super(key: key);
  @override
  FeedPageState createState() => FeedPageState();
}
class FeedPageState extends State<FeedPage> {
  final FeedStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}