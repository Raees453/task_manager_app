import 'package:dio/dio.dart';
import 'package:task_manager_app/models/typedefs.dart';

import '../../locator.dart';
import '../../utils/constants/api.dart';

abstract class ApiRequest {
  final String apiUrl;
  final String method;
  final Map<String, dynamic>? queryParams;

  const ApiRequest({
    required this.apiUrl,
    required this.method,
    this.queryParams,
  });

  Future<Response> toCallback() {
    final data = toJson();

    return switch (method.toUpperCase()) {
      'POST' => dio.post(url, data: data),
      'GET' => dio.get(url, data: toJson()),
      'PATCH' => dio.patch(url, data: toJson()),
      'PUT' => dio.put(url, data: toJson()),
      'DELETE' => dio.delete(url, data: toJson()),
      _ => dio.get(apiUrl),
    };
  }

  JsonMap toJson();

  get url => '$serverUrl$apiUrl';
}
