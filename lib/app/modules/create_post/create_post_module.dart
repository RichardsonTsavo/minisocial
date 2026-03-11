import 'package:minisocial/app/modules/create_post/createPost_page.dart';
import 'package:minisocial/app/modules/create_post/create_post_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreatePostModule extends Module {
  @override
  void binds(Injector i) {
    i.add<CreatePostStore>(CreatePostStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const CreatePostPage());
  }
}
