import 'package:minisocial/app/shared/controllers/auth_controller.dart';
import 'package:minisocial/app/shared/models/file/file_data_model.dart';
import 'package:minisocial/app/shared/models/posts/post_model.dart';
import 'package:minisocial/app/shared/repositories/posts/posts_repository.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final AuthController authController;
  final PostsRepository postsRepository;
  _ProfileStoreBase({required this.authController, required this.postsRepository});

  String getUsername() => authController.getUserName();
  String getName() => authController.getName();
  String getBio() => authController.getBio();
  FileDataModel? getAvatar() => authController.getAvatar();
  int getPostsCount() => authController.getPostCounts();
  int getFollowersCount() => authController.getFollowersCount();
  int getFollowingCount() => authController.getFollowingCount();

  Future<List<PostModel>> getMyPosts() async {
    return postsRepository.getMyPosts(
      userId: authController.getUserId(),
      limit: getPostsCount(),
    );
  }
}
