import 'package:minisocial/app/modules/splash/splash_page.dart';
import 'package:minisocial/app/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  void binds(Injector i) {
    i.add<SplashStore>(SplashStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
  }
}
