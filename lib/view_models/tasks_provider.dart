import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/locator.dart';
import 'package:task_manager_app/models/data_models/api_error.dart';
import 'package:task_manager_app/models/data_models/task.dart';
import 'package:task_manager_app/models/params/task_params.dart';
import 'package:task_manager_app/models/typedefs.dart';
import 'package:task_manager_app/utils/constants/app_keys.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/utils/widget_utils.dart';

class TasksProvider with ChangeNotifier {
  List<Task>? _tasks;

  List<Task>? get tasks => _tasks;

  bool isLoadingAllTasks = false;
  bool isLoadingErrorOccurred = false;

  bool addTaskLoading = false;
  bool addTaskLoadingError = false;

  bool deleteTaskLoading = false;
  bool deleteTaskLoadingError = false;

  TasksProvider() {
    _loadTasks();
  }

  Future<void> fetchAllTasks() async {
    isLoadingAllTasks = true;
    notifyListeners();

    String? message;

    try {
      final response = await tasksRepository.fetchAllTasks();

      _tasks = response.body as List<Task>;
      isLoadingErrorOccurred = false;
    } on ApiError catch (e) {
      isLoadingErrorOccurred = true;
      message = e.message;
    }

    WidgetUtils.displayToast(message);

    isLoadingAllTasks = false;
    notifyListeners();

    _persistTasks();
  }

  Future<void> toggleTask(Task task) async {}

  Future<void> addTask(AddTaskParams params) async {
    String? message;
    Task? task;
    addTaskLoading = true;
    notifyListeners();

    try {
      final response = await tasksRepository.addTask(params);

      task = response.body as Task;
      addTaskLoadingError = false;
    } on ApiError catch (e) {
      message = e.message;
      addTaskLoadingError = true;
    }

    _tasks ??= [];

    if (task.isNotNull) _tasks!.add(task!);

    WidgetUtils.displayToast(message);

    addTaskLoading = false;
    notifyListeners();

    _persistTasks();
  }

  void updateTask(int id, Task newTask) {
    final index = _tasks!.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks![index] = newTask;
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    String? message;

    deleteTaskLoading = true;
    notifyListeners();

    try {
      final response = await tasksRepository.deleteTask(id);

      _tasks?.removeWhere((e) => e.id == id);
      deleteTaskLoadingError = false;
    } on ApiError catch (e) {
      message = e.message;
      deleteTaskLoadingError = true;
    }

    WidgetUtils.displayToast(message);

    deleteTaskLoading = false;
    notifyListeners();

    _persistTasks();
  }

  Task? getTaskById(int id) {
    return _tasks!.firstWhereOrNull((task) => task.id == id);
  }

  bool get isLoading =>
      isLoadingAllTasks || addTaskLoading || deleteTaskLoading;

  void _persistTasks() {
    if (_tasks == null) return;

    localStorage.write(AppKeys.tasks, jsonEncode(_tasks));
  }

  void _loadTasks() {
    final json = localStorage.read(AppKeys.tasks);

    if (json == null) return;

    _tasks = (jsonDecode(json) as List<dynamic>?)
            ?.cast<JsonMap>()
            .map(Task.fromJson)
            .toList() ??
        <Task>[];
  }
}
