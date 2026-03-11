import 'package:minisocial/app/modules/splash/splash_page.dart';
import 'package:minisocial/app/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

// import '../../shared/controllers/auth_controller.dart';

class SplashModule extends Module {
  @override
  void binds(Injector i) {
    i.add<SplashStore>(() => SplashStore(authController: Modular.get()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
  }
}
