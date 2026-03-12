// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_card_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostCardStore on PostCardStoreBase, Store {
  late final _$postAtom = Atom(
    name: 'PostCardStoreBase.post',
    context: context,
  );

  @override
  PostModel get post {
    _$postAtom.reportRead();
    return super.post;
  }

  bool _postIsInitialized = false;

  @override
  set post(PostModel value) {
    _$postAtom.reportWrite(value, _postIsInitialized ? super.post : null, () {
      super.post = value;
      _postIsInitialized = true;
    });
  }

  late final _$PostCardStoreBaseActionController = ActionController(
    name: 'PostCardStoreBase',
    context: context,
  );

  @override
  void like() {
    final _$actionInfo = _$PostCardStoreBaseActionController.startAction(
      name: 'PostCardStoreBase.like',
    );
    try {
      return super.like();
    } finally {
      _$PostCardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void salve() {
    final _$actionInfo = _$PostCardStoreBaseActionController.startAction(
      name: 'PostCardStoreBase.salve',
    );
    try {
      return super.salve();
    } finally {
      _$PostCardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
post: ${post}
    ''';
  }
}
