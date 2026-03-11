import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<Map<String, dynamic>?> getObject({required String key}) async {
    final prefs = await _prefs;
    final value = prefs.getString(key);
    if (value != null) {
      return json.decode(value);
    } else {
      return null;
    }
  }

  Future<void> setObject({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    final prefs = await _prefs;
    await prefs.setString(key, json.encode(value));
  }

  Future<void> setObjectList({
    required String key,
    required List<Map<String, dynamic>> value,
  }) async {
    final prefs = await _prefs;
    await prefs.setString(key, json.encode(value));
  }

  Future<List<Map<String, dynamic>>?> getObjectList({
    required String key,
  }) async {
    final prefs = await _prefs;
    final value = prefs.getString(key);
    if (value != null) {
      final decoded = json.decode(value);
      if (decoded is List) {
        return decoded
            .map<Map<String, dynamic>>(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();
      }
    }
    return null;
  }

  Future<bool> getBool({required String key}) async {
    final prefs = await _prefs;
    return prefs.getBool(key) ?? false;
  }

  Future<void> setBool({required String key, required bool value}) async {
    final prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  Future<int?> getInt({required String key}) async {
    final prefs = await _prefs;
    return prefs.getInt(key);
  }

  Future<void> setInt({required String key, required int value}) async {
    final prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  Future<double?> getDouble({required String key}) async {
    final prefs = await _prefs;
    return prefs.getDouble(key);
  }

  Future<void> setDouble({required String key, required double value}) async {
    final prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  Future<String?> getString({required String key}) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<void> setString({required String key, required String value}) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<void> remove({required String key}) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
