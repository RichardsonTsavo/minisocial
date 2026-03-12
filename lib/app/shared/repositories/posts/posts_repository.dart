import 'package:dio/dio.dart';
import 'dart:math';
import '../../models/posts/comment_model.dart';
import '../../models/posts/post_model.dart';

class PostsRepository {
  final Dio dio;

  PostsRepository(this.dio);

  Future<List<PostModel>> getFeedPosts({int page = 1, int limit = 10}) async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> data = List.generate(limit, (index) {
      final postNumber = ((page - 1) * limit) + index + 1;
      final random = Random();
      return {
        "id": "$postNumber",
        "userId": postNumber,
        "userName": "user_$postNumber",
        "userAvatar": "https://i.pravatar.cc/150?img=$postNumber",
        "mediaUrl": "https://picsum.photos/600/600?$postNumber",
        "caption": "Post número $postNumber do MiniSocial 🚀",
        "type": "image",
        "likesCount": random.nextInt(50),
        "commentsCount": random.nextInt(50),
        "createdAt": DateTime.now()
            .subtract(Duration(minutes: postNumber * 5))
            .toIso8601String(),
      };
    });

    data.shuffle();
    return data.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<PostModel>> getMyPosts({
    required int userId,
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final random = Random();

    final List<Map<String, dynamic>> data = List.generate(limit, (index) {
      final postNumber = ((page - 1) * limit) + index + 1;

      return {
        "id": "post_$postNumber",
        "userId": userId,
        "userName": "meu_usuario",
        "userAvatar": "https://i.pravatar.cc/150?img=1",
        "mediaUrl": "https://picsum.photos/600/600?random=$postNumber",
        "caption": "Meu post número $postNumber 🚀",
        "type": "image",
        "likesCount": random.nextInt(200),
        "commentsCount": random.nextInt(50),
        "createdAt": DateTime.now()
            .subtract(Duration(minutes: random.nextInt(500)))
            .toIso8601String(),
      };
    });

    return data.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<List<CommentModel>> getComments({
    required String postId,
    required int amountComments,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> data = List.generate(amountComments, (index) {
      return {
        "id": "$index",
        "userName": "user_$index",
        "userAvatar": "https://i.pravatar.cc/150?img=${index + 10}",
        "comment": "Comentário $index no post $postId",
        "createdAt": DateTime.now()
            .subtract(Duration(minutes: index * 5))
            .toIso8601String(),
      };
    });

    return data.map((e) => CommentModel.fromMap(e)).toList();
  }
}
