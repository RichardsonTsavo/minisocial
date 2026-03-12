import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/home/home_module.dart';
import 'package:minisocial/app/modules/login/login_module.dart';
import 'package:minisocial/app/modules/post_detail/post_detail_module.dart';
import 'package:minisocial/app/modules/register/register_module.dart';
import 'package:minisocial/app/shared/controllers/auth_controller.dart';

import 'modules/splash/splash_module.dart';
import 'shared/repositories/posts/posts_repository.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthController>(AuthController.new);
    i.add<PostsRepository>(() => PostsRepository(Dio()));
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: SplashModule(), transition: TransitionType.fadeIn);
    r.module('/login', module: LoginModule(), transition: TransitionType.fadeIn);
    r.module('/register', module: RegisterModule(), transition: TransitionType.fadeIn);
    r.module('/home', module: HomeModule(), transition: TransitionType.fadeIn);
    r.module(
      '/post_detail',
      module: PostDetailModule(),
      transition: TransitionType.fadeIn,
    );
  }
}
