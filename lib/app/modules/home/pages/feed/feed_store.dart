import 'package:mobx/mobx.dart';

import '../../../../shared/models/posts/post_model.dart';
import '../../../../shared/repositories/posts/posts_repository.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  final PostsRepository repository;

  _FeedStoreBase(this.repository);

  @observable
  List<PostModel> posts = [];

  int page = 1;
  final int limit = 10;

  @observable
  bool loadingMore = false;

  @action
  Future loadMore() async {
    if (loadingMore) return;

    loadingMore = true;

    final newPosts = await repository.getFeedPosts(page: page, limit: limit);

    posts = [...posts, ...newPosts];

    page++;

    loadingMore = false;
  }
}
