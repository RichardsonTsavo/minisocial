import 'package:minisocial/app/shared/controllers/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  final AuthController authController;

  _SplashStoreBase({required this.authController});

  Future loginWithLocalData() async {
    authController.loginWithLocalData();
  }
}
