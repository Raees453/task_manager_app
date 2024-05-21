import 'package:task_manager_app/models/data_models/api_response.dart';
import 'package:task_manager_app/models/typedefs.dart';

import '../data_models/task.dart';

class FetchTasksResponse extends ApiResponse {
  const FetchTasksResponse({required super.body});

  factory FetchTasksResponse.fromJson(JsonMap json) {
    final tasks = (json['todos'] as List<dynamic>?)
            ?.cast<JsonMap>()
            .map(Task.fromJson)
            .toList() ??
        [];

    return FetchTasksResponse(body: tasks);
  }
}

class AddTaskResponse extends ApiResponse {
  const AddTaskResponse({required super.body});

  factory AddTaskResponse.fromJson(JsonMap json) {
    return AddTaskResponse(body: Task.fromJson(json));
  }
}

class DeleteTaskResponse extends ApiResponse {
  const DeleteTaskResponse({required super.body});

  factory DeleteTaskResponse.fromJson(JsonMap json) {
    return DeleteTaskResponse(body: Task.fromJson(json));
  }
}
