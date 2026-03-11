// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreatePostStore on _CreatePostStoreBase, Store {
  late final _$valueAtom = Atom(
    name: '_CreatePostStoreBase.value',
    context: context,
  );

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$_CreatePostStoreBaseActionController = ActionController(
    name: '_CreatePostStoreBase',
    context: context,
  );

  @override
  void increment() {
    final _$actionInfo = _$_CreatePostStoreBaseActionController.startAction(
      name: '_CreatePostStoreBase.increment',
    );
    try {
      return super.increment();
    } finally {
      _$_CreatePostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
