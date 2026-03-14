import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/shared/models/posts/comment_model.dart';
import 'package:minisocial/app/shared/models/posts/post_model.dart';
import 'package:minisocial/app/shared/repositories/posts/posts_repository.dart';
import 'package:mobx/mobx.dart';

import '../../shared/controllers/auth_controller.dart';

part 'post_detail_store.g.dart';

class PostDetailStore = _PostDetailStoreBase with _$PostDetailStore;

abstract class _PostDetailStoreBase with Store {
  final AuthController authController;
  final PostsRepository postsRepository;

  @observable
  late PostModel postModel;

  @observable
  bool isLoading = false;

  _PostDetailStoreBase({required this.authController, required this.postsRepository});

  int getUserId() => authController.getUserId();

  Future<List<CommentModel>> getComments() {
    return postsRepository.getComments(postId: postModel.id!);
  }

  @action
  Future deletePost({required int postId}) async {
    isLoading = true;
    await postsRepository.deletePost(postId: postId);
    isLoading = false;
  }

  @action
  Future updatePost({required int postId, required String caption}) async {
    isLoading = true;
    bool canUpdate = await postsRepository.updatePost(postId: postId, caption: caption);
    isLoading = false;
    if (canUpdate) {
      postModel = postModel.copyWith(caption: caption);
    }
  }
}
