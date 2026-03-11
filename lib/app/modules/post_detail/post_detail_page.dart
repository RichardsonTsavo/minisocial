import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/post_detail/post_detail_store.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final String title;
  const PostDetailPage({Key? key, this.title = 'PostDetailPage'}) : super(key: key);
  @override
  PostDetailPageState createState() => PostDetailPageState();
}

class PostDetailPageState extends State<PostDetailPage> {
  final PostDetailStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(children: <Widget>[]),
    );
  }
}
