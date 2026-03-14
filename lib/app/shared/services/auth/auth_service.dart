import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/shared/models/user/user_model.dart';
import 'package:minisocial/app/shared/services/http/http_service.dart';
import 'package:minisocial/app/shared/services/prefs/prefs_service.dart';

import '../../utils/utils.dart';

class AuthService {
  HttpService httpService = Modular.get();
  final PrefsService _prefs = PrefsService();

  Future login({required String email, required String password}) async {
    try {
      final response = await httpService.dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );
      String token = response.data;
      await _prefs.setString(key: "userToken", value: token);
      httpService.setToken(token);
      return token;
    } on DioException catch (e) {
      Utils.showError(e.response?.data);
      return null;
    }
  }

  Future register({required UserModel user, required String password}) async {
    try {
      var response = await httpService.dio.post(
        "/auth/register",
        data: {
          "name": user.name,
          "email": user.email,
          "username": user.username!.replaceAll(" ", "_"),
          "password": password,
        },
      );
      String token = response.data;

      await _prefs.setString(key: "userToken", value: token);
      httpService.setToken(token);
      return token;
    } on DioException catch (e) {
      Utils.showError(e.response?.data);
      return null;
    }
  }

  Future<String?> getLocalUserToken() async {
    String? token = await _prefs.getString(key: "userToken");
    if (token != null) {
      httpService.setToken(token);
    }
    return token;
  }

  Future<UserModel?> getLocalUserData() async {
    Map<String, dynamic>? data = await _prefs.getObject(key: "userData");
    if (data != null) {
      return UserModel.fromMap(data);
    }
    return null;
  }

  Future<UserModel?> fetchUserData() async {
    try {
      final response = await httpService.dio.get("/auth/me");

      final data = response.data;
      if (data != null) {
        await _prefs.setObject(key: "userData", value: response.data);
        UserModel user = UserModel.fromMap(data);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future logout() async {
    await _prefs.remove(key: "userToken");
    await _prefs.remove(key: "userData");
    httpService.clearToken();
    Modular.to.navigate("/");
  }
}
