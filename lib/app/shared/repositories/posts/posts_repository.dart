import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/home/home_store.dart';
import 'package:minisocial/app/shared/models/file/file_data_model.dart';
import 'package:minisocial/app/shared/utils/utils.dart';

import '../../models/posts/comment_model.dart';
import '../../models/posts/post_model.dart';
import '../../services/http/http_service.dart';

class PostsRepository {
  final HttpService httpService;

  PostsRepository(this.httpService);

  Future<List<PostModel>> getFeedPosts({int page = 1, int limit = 10}) async {
    try {
      final response = await httpService.dio.get(
        '/posts/feed',
        queryParameters: {'page': page, 'limit': limit},
      );

      List data = response.data["content"];

      return data.map((json) {
        return PostModel.fromMap(json);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> deletePost({required int postId}) async {
    try {
      await httpService.dio.delete('/posts/$postId');
      Modular.to.pop();
      Modular.to.pop(true);
      return true;
    } on DioException catch (e) {
      Utils.showError(e.response?.data);
      return false;
    }
  }

  Future<bool> updatePost({required int postId, required String caption}) async {
    try {
      await httpService.dio.put('/posts/$postId', data: {"caption": caption});
      Modular.to.pop(true);
      return true;
    } on DioException catch (e) {
      Utils.showError(e.response?.data);
      return false;
    }
  }

  Future createPost({required FileDataModel image, required String caption}) async {
    try {
      await httpService.dio.post(
        '/posts',
        data: {"caption": caption, "fileData": image.toMap()},
      );
      HomeStore store = Modular.get();
      store.changeTab(1);
    } on DioException catch (e) {
      Utils.showError(e.response?.data);
    }
  }

  Future<List<PostModel>> getMyPosts({required int userId}) async {
    try {
      final response = await httpService.dio.get('/posts/user/$userId');

      List data = response.data;
      return data.map((json) {
        return PostModel.fromMap(json);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<CommentModel>> getComments({required int postId}) async {
    try {
      final response = await httpService.dio.get('/comments/post/${postId}');
      List data = response.data;

      return data.map((json) {
        return CommentModel.fromMap(json);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
