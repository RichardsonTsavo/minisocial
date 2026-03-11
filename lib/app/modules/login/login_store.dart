import 'package:minisocial/app/shared/controllers/auth_controller.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthController authController;

  _LoginStoreBase({required this.authController});

  @observable
  bool isLoading = false;

  @action
  Future<void> submit({required Map<String, dynamic> values}) async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    final email = values["email"];
    final password = values["password"];

    await _login(email: email, password: password);
    isLoading = false;
  }

  Future _login({required String email, required String password}) async {
    return await authController.login(email: email, password: password);
  }
}
