import 'package:minisocial/app/modules/post_detail/post_detail_page.dart';
import 'package:minisocial/app/modules/post_detail/post_detail_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostDetailModule extends Module {
  @override
  void binds(Injector i) {
    i.add<PostDetailStore>(PostDetailStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const PostDetailPage());
  }
}
