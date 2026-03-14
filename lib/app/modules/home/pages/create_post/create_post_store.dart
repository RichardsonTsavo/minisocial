import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:minisocial/app/shared/enums/post_type.dart';
import 'package:minisocial/app/shared/models/file/file_data_model.dart';
import 'package:mobx/mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../shared/models/file/file_metadata_model.dart';
import '../../../../shared/repositories/posts/posts_repository.dart';

part 'create_post_store.g.dart';

class CreatePostStore = _CreatePostStoreBase with _$CreatePostStore;

abstract class _CreatePostStoreBase with Store {
  final PostsRepository postsRepository;

  _CreatePostStoreBase(this.postsRepository);

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o GPS/serviço de localização está ativo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // Verifica permissões
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

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

  @action
  Future createPost({required String caption}) async {
    isLoading = true;
    Position? position = await getCurrentLocation();
    if (selected == null) {
      isLoading = false;
      return;
    }
    await postsRepository.createPost(
      image: FileDataModel(
        bytes: await selected!.originBytes,
        fileName: selected!.title,
        metadata: FileMetadataModel(
          contentType: selected!.mimeType,
          createdAt: DateTime.now(),
          type: PostType.image,
          lat: position!.latitude,
          lng: position.longitude,
        ),
      ),
      caption: caption,
    );
    isLoading = false;
  }
}
