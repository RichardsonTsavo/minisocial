import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/shared/models/user/user_model.dart';

import '../services/auth/auth_service.dart';
import '../services/biometric/biometric_service.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final BiometricService _biometricService = BiometricService();
  UserModel? _userModels;
  String? _userToken;

  Future login({required String email, required String password}) async {
    String? token = await _authService.login(email: email, password: password);
    if (token != null) {
      _userModels = await _authService.getUserData(token: token);
      Modular.to.navigate("/home/");
    }
  }

  Future register({required UserModel user}) async {
    String? token = await _authService.register(user: user);
    if (token != null) {
      _userModels = await _authService.getUserData(token: token);
      Modular.to.navigate("/home/");
    }
  }

  Future loginWithLocalData() async {
    _userToken = await _authService.getLocalUserToken();
    if (_userToken == null) {
      Modular.to.navigate("/login/");
      return;
    }
    _userModels = await _authService.getLocalUserData();
    if (_userToken != null && _userModels != null) {
      bool authenticate = await _biometricService.authenticate();
      if (authenticate) {
        Modular.to.navigate("/home/");
      } else {
        Modular.to.navigate("/login/");
      }
      return;
    }
    Modular.to.navigate("/login/");
  }

  Future logout() async {
    return await _authService.logout();
  }
}
