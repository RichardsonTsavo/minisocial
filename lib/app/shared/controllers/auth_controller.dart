import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/shared/models/user/user_model.dart';

import '../models/file/file_data_model.dart';
import '../services/auth/auth_service.dart';
import '../services/biometric/biometric_service.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final BiometricService _biometricService = BiometricService();
  UserModel? _userModels;
  String? _userToken;

  int getUserId() => _userModels!.id!;

  String getUserName() => _userModels!.username!;
  String getName() => _userModels!.name!;
  String getBio() => _userModels!.bio ?? "";
  FileDataModel? getAvatar() => _userModels!.avatar;
  int getPostCounts() => _userModels!.postsCount ?? 0;
  int getFollowersCount() => _userModels!.followersCount ?? 0;
  int getFollowingCount() => _userModels!.followingCount ?? 0;

  Future login({required String email, required String password}) async {
    String? token = await _authService.login(email: email, password: password);
    if (token != null) {
      _userModels = await _authService.fetchUserData();
      Modular.to.navigate("/home/feed");
    }
  }

  Future register({required UserModel user, required String password}) async {
    String? token = await _authService.register(user: user, password: password);
    if (token != null) {
      _userModels = await _authService.fetchUserData();
      Modular.to.navigate("/home/feed");
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
        Modular.to.navigate("/home/feed");
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
