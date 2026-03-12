import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

import 'home_page.dart';
import 'pages/create_post/create_post_page.dart';
import 'pages/create_post/create_post_store.dart';
import 'pages/feed/feed_page.dart';
import 'pages/feed/feed_store.dart';
import 'pages/profile/profile_page.dart';
import 'pages/profile/profile_store.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<HomeStore>(HomeStore.new);
    i.add<CreatePostStore>(CreatePostStore.new);
    i.add<ProfileStore>(
      () => ProfileStore(authController: Modular.get(), postsRepository: Modular.get()),
    );
    i.add<FeedStore>(() => FeedStore(Modular.get()));
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const HomePage(),
      children: [
        ChildRoute('/feed', child: (context) => const FeedPage()),

        ChildRoute('/create', child: (context) => const CreatePostPage()),

        ChildRoute('/profile', child: (context) => const ProfilePage()),
      ],
    );
  }
}
