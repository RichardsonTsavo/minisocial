// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedStore on _FeedStoreBase, Store {
  late final _$postsAtom = Atom(name: '_FeedStoreBase.posts', context: context);

  @override
  List<PostModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(List<PostModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$loadingMoreAtom = Atom(
    name: '_FeedStoreBase.loadingMore',
    context: context,
  );

  @override
  bool get loadingMore {
    _$loadingMoreAtom.reportRead();
    return super.loadingMore;
  }

  @override
  set loadingMore(bool value) {
    _$loadingMoreAtom.reportWrite(value, super.loadingMore, () {
      super.loadingMore = value;
    });
  }

  late final _$loadMoreAsyncAction = AsyncAction(
    '_FeedStoreBase.loadMore',
    context: context,
  );

  @override
  Future<dynamic> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  @override
  String toString() {
    return '''
posts: ${posts},
loadingMore: ${loadingMore}
    ''';
  }
}
