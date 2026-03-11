import 'package:minisocial/app/modules/register/register_page.dart';
import 'package:minisocial/app/modules/register/register_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  void binds(Injector i) {
    i.add<RegisterStore>(RegisterStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const RegisterPage());
  }
}
