import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/shared/models/user/user_model.dart';
import 'package:minisocial/app/shared/services/prefs/prefs_service.dart';

class AuthService {
  final Dio _dio = Dio();
  final PrefsService _prefs = PrefsService();
  String tokenTeste =
      "eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTc3MzI0NTgxOCwiaWF0IjoxNzczMjQ1ODE4fQ.T1BWbki4R4A_Phf-64TpBY5dg1TvM5jdduC3nzTz4HI";

  /// TODO implementar login na api
  Future login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == "admin@minisocial.com" && password == "123456") {
      await _prefs.setString(key: "userToken", value: tokenTeste);
      return tokenTeste;
    }

    return null;
  }

  /// TODO implementar registro na api
  Future register({required UserModel user}) async {
    await Future.delayed(const Duration(seconds: 1));
    await _prefs.setString(key: "userToken", value: tokenTeste);
    return tokenTeste;
  }

  Future<String?> getLocalUserToken() async {
    return await _prefs.getString(key: "userToken");
  }

  Future<UserModel?> getLocalUserData() async {
    Map<String, dynamic>? data = await _prefs.getObject(key: "userData");
    if (data != null) {
      return UserModel.fromMap(data);
    }
    return null;
  }

  /// TODO Implementar get na api
  Future<UserModel?> getUserData({required String token}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Map<String, dynamic>? data;

      if (token == tokenTeste) {
        data = {
          "name": "Admin admin",
          "email": "admin@minisocial.com",
          "nickName": "admin",
          "userImage": null,
          "faviorites": [],
          "bio": "",
        };
      }

      if (data != null) {
        await _prefs.setObject(key: "userData", value: data);
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
    Modular.to.navigate("/");
  }
}
