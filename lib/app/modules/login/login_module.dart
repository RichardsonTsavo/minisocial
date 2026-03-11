import 'package:minisocial/app/modules/login/login_page.dart';
import 'package:minisocial/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add<LoginStore>(LoginStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
  }
}
