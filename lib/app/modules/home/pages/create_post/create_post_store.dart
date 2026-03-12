import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

part 'create_post_store.g.dart';

class CreatePostStore = _CreatePostStoreBase with _$CreatePostStore;

abstract class _CreatePostStoreBase with Store {
  @observable
  bool isLoading = false;
  @observable
  ObservableList<AssetEntity> gallery = ObservableList<AssetEntity>();

  @observable
  int page = 0;

  @action
  void changePage({required int value}) {
    page = value;
  }

  @observable
  AssetEntity? selected;

  @action
  Future loadGallery() async {
    isLoading = true;
    final permission = await PhotoManager.requestPermissionExtend();

    if (!permission.hasAccess) {
      isLoading = false;
      return;
    }

    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    if (albums.isEmpty) {
      isLoading = false;
      return;
    }

    final recent = albums.first;

    final photos = await recent.getAssetListPaged(page: 0, size: 100);
    gallery.clear();
    gallery.addAll(photos);

    if (gallery.isNotEmpty) {
      selected = gallery.first;
    }
    isLoading = false;
  }

  @action
  void selectImage(AssetEntity asset) {
    selected = asset;
  }

  @action
  Future takePhoto() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(source: ImageSource.camera);

    if (file == null) return;

    final asset = await PhotoManager.editor.saveImageWithPath(file.path);

    selected = asset;
    gallery.insert(0, asset);
  }
}
