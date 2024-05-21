import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_app/repositories/auth_repository.dart';
import 'package:task_manager_app/repositories/tasks_repository.dart';
import 'package:task_manager_app/utils/local_storage.dart';

import 'utils/constants/app_keys.dart';

final _locator = GetIt.instance;

Dio dio = _locator<Dio>();
LocalStorage localStorage = _locator<LocalStorage>();
AuthRepository authRepository = _locator<AuthRepository>();
TasksRepository tasksRepository = _locator<TasksRepository>();

abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator.registerLazySingleton(() => LocalStorage());
    _locator.registerLazySingleton(() => Dio());
    _locator.registerLazySingleton(() => AuthRepository());
    _locator.registerLazySingleton(() => TasksRepository());

    await localStorage.initialise();

    dio.options = BaseOptions(
      sendTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
      // contentType: 'application/json',
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = localStorage.read(AppKeys.token).toString();

        options.headers['Authorization'] = 'Bearer $token';
        options.headers['Content-Type'] = 'application/json';

        if (kDebugMode) log(token, name: 'Token');

        return handler.next(options);
      },
    ));
  }
}
