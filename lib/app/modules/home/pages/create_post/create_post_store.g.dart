// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreatePostStore on _CreatePostStoreBase, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CreatePostStoreBase.isLoading',
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

  late final _$galleryAtom = Atom(
    name: '_CreatePostStoreBase.gallery',
    context: context,
  );

  @override
  ObservableList<AssetEntity> get gallery {
    _$galleryAtom.reportRead();
    return super.gallery;
  }

  @override
  set gallery(ObservableList<AssetEntity> value) {
    _$galleryAtom.reportWrite(value, super.gallery, () {
      super.gallery = value;
    });
  }

  late final _$pageAtom = Atom(
    name: '_CreatePostStoreBase.page',
    context: context,
  );

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$selectedAtom = Atom(
    name: '_CreatePostStoreBase.selected',
    context: context,
  );

  @override
  AssetEntity? get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(AssetEntity? value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  late final _$loadGalleryAsyncAction = AsyncAction(
    '_CreatePostStoreBase.loadGallery',
    context: context,
  );

  @override
  Future<dynamic> loadGallery() {
    return _$loadGalleryAsyncAction.run(() => super.loadGallery());
  }

  late final _$takePhotoAsyncAction = AsyncAction(
    '_CreatePostStoreBase.takePhoto',
    context: context,
  );

  @override
  Future<dynamic> takePhoto() {
    return _$takePhotoAsyncAction.run(() => super.takePhoto());
  }

  late final _$_CreatePostStoreBaseActionController = ActionController(
    name: '_CreatePostStoreBase',
    context: context,
  );

  @override
  void changePage({required int value}) {
    final _$actionInfo = _$_CreatePostStoreBaseActionController.startAction(
      name: '_CreatePostStoreBase.changePage',
    );
    try {
      return super.changePage(value: value);
    } finally {
      _$_CreatePostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectImage(AssetEntity asset) {
    final _$actionInfo = _$_CreatePostStoreBaseActionController.startAction(
      name: '_CreatePostStoreBase.selectImage',
    );
    try {
      return super.selectImage(asset);
    } finally {
      _$_CreatePostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
gallery: ${gallery},
page: ${page},
selected: ${selected}
    ''';
  }
}
