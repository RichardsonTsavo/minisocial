enum PostType { image, video }

extension PostTypeLabel on PostType {
  String get label {
    switch (this) {
      case PostType.image:
        return 'Imagem';
      case PostType.video:
        return 'Video';
    }
  }
}
