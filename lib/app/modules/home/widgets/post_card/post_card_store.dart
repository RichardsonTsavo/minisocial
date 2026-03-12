import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/shared/controllers/auth_controller.dart';
import 'package:minisocial/app/shared/models/posts/comment_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/models/posts/post_model.dart';
import '../../../../shared/repositories/posts/posts_repository.dart';

part 'post_card_store.g.dart';

class PostCardStore = PostCardStoreBase with _$PostCardStore;

abstract class PostCardStoreBase with Store {
  final AuthController authController = Modular.get();
  final PostsRepository repository = Modular.get();

  @observable
  late PostModel post;

  bool postedByMe() => (authController.getUserId() == post.userId);

  @action
  void like() {
    post = post.copyWith(likedByMe: !post.likedByMe!);
  }

  @action
  void salve() {
    post = post.copyWith(savedByMe: !post.savedByMe!);
  }

  Future<List<CommentModel>> getComments() async {
    return repository.getComments(postId: post.id!, amountComments: post.commentsCount!);
  }
}
