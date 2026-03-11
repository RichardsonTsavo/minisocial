import 'package:minisocial/app/modules/profile/profile_page.dart';
import 'package:minisocial/app/modules/profile/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ProfileStore>(ProfileStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ProfilePage());
  }
}
