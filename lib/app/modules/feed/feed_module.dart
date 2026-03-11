import 'package:minisocial/app/modules/feed/feed_page.dart';
import 'package:minisocial/app/modules/feed/feed_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedModule extends Module {
  @override
  void binds(Injector i) {
    i.add<FeedStore>(FeedStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const FeedPage());
  }
}
