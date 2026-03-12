import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/home/pages/feed/feed_store.dart';
import 'package:flutter/material.dart';

import '../../widgets/post_card/post_card_widget.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key? key, this.title = 'Feed'}) : super(key: key);
  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  final FeedStore store = Modular.get();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 600) {
        store.loadMore();
      }
    });

    store.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (_) {
          if (store.posts.isEmpty && store.loadingMore) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            );
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: store.posts.length + 1,
            itemBuilder: (context, index) {
              if (index < store.posts.length) {
                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("/post_detail", arguments: store.posts[index]);
                  },
                  child: PostCard(
                    post: store.posts[index],
                    onLike: () {},
                    onSave: () {},
                    onShare: () {},
                  ),
                );
              }

              if (store.loadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
