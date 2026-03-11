import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/create_post/create_post_module.dart';
import 'package:minisocial/app/modules/feed/feed_module.dart';
import 'package:minisocial/app/modules/home/home_module.dart';
import 'package:minisocial/app/modules/login/login_module.dart';
import 'package:minisocial/app/modules/post_detail/post_detail_module.dart';
import 'package:minisocial/app/modules/profile/profile_module.dart';
import 'package:minisocial/app/modules/register/register_module.dart';
import 'package:minisocial/app/shared/controllers/auth_controller.dart';

import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthController>(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: SplashModule(), transition: TransitionType.fadeIn);
    r.module('/login', module: LoginModule(), transition: TransitionType.fadeIn);
    r.module('/register', module: RegisterModule(), transition: TransitionType.fadeIn);
    r.module('/home', module: HomeModule(), transition: TransitionType.fadeIn);
    r.module('/feed', module: FeedModule(), transition: TransitionType.fadeIn);
    r.module(
      '/post_detail',
      module: PostDetailModule(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      '/create_post',
      module: CreatePostModule(),
      transition: TransitionType.fadeIn,
    );
    r.module('/profile', module: ProfileModule(), transition: TransitionType.fadeIn);
  }
}
