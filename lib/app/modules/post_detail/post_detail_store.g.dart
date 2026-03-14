// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostDetailStore on _PostDetailStoreBase, Store {
  late final _$postModelAtom = Atom(
    name: '_PostDetailStoreBase.postModel',
    context: context,
  );

  @override
  PostModel get postModel {
    _$postModelAtom.reportRead();
    return super.postModel;
  }

  bool _postModelIsInitialized = false;

  @override
  set postModel(PostModel value) {
    _$postModelAtom.reportWrite(
      value,
      _postModelIsInitialized ? super.postModel : null,
      () {
        super.postModel = value;
        _postModelIsInitialized = true;
      },
    );
  }

  late final _$isLoadingAtom = Atom(
    name: '_PostDetailStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$deletePostAsyncAction = AsyncAction(
    '_PostDetailStoreBase.deletePost',
    context: context,
  );

  @override
  Future<dynamic> deletePost({required int postId}) {
    return _$deletePostAsyncAction.run(() => super.deletePost(postId: postId));
  }

  late final _$updatePostAsyncAction = AsyncAction(
    '_PostDetailStoreBase.updatePost',
    context: context,
  );

  @override
  Future<dynamic> updatePost({required int postId, required String caption}) {
    return _$updatePostAsyncAction.run(
      () => super.updatePost(postId: postId, caption: caption),
    );
  }

  @override
  String toString() {
    return '''
postModel: ${postModel},
isLoading: ${isLoading}
    ''';
  }
}
