import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/create_post/create_post_store.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  final String title;
  const CreatePostPage({Key? key, this.title = 'CreatePostPage'}) : super(key: key);
  @override
  CreatePostPageState createState() => CreatePostPageState();
}

class CreatePostPageState extends State<CreatePostPage> {
  final CreatePostStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(children: <Widget>[]),
    );
  }
}
