import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Utils {
  static String formatTime(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return "há ${diff.inMinutes} min";
    }

    if (diff.inHours < 24) {
      return "há ${diff.inHours} h";
    }

    return "há ${diff.inDays} dias";
  }

  static Future<void> showError(dynamic errorData) async {
    String message = "Ocorreu um erro inesperado";
    String status = "500";

    if (errorData is Map && errorData.containsKey('message')) {
      message = errorData['message'];
      status = '${errorData['status']}';
    }

    await showDialog(
      context: Modular.routerDelegate.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text("Erro $status"),
          content: Text(message),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
          ],
        );
      },
    );
  }

  static Future<String> getAddressFromLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {'format': 'json', 'lat': lat, 'lon': lng, 'addressdetails': 1},
        options: Options(headers: {'User-Agent': 'MinisocialApp/1.0'}),
      );

      if (response.data != null && response.data['display_name'] != null) {
        return response.data['display_name'];
      } else {
        return 'Endereço não encontrado';
      }
    } catch (e) {
      return 'Erro ao buscar endereço';
    }
  }
}
