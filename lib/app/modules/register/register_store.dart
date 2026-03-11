import 'package:minisocial/app/shared/models/user/user_model.dart';
import 'package:mobx/mobx.dart';

import '../../shared/controllers/auth_controller.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final AuthController authController;

  _RegisterStoreBase({required this.authController});

  @observable
  bool isLoading = false;

  @action
  Future<void> submit({required Map<String, dynamic> values}) async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    final user = UserModel.fromMap(values);

    await _register(user: user);
    isLoading = false;
  }

  Future _register({required UserModel user}) async {
    return await authController.register(user: user);
  }
}
