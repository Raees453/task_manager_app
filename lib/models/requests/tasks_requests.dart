import 'package:task_manager_app/models/data_models/api_request.dart';
import 'package:task_manager_app/models/data_models/task.dart';

import '../params/task_params.dart';
import '../typedefs.dart';

class FetchTasksRequest extends ApiRequest {
  const FetchTasksRequest({super.apiUrl = '/todos', super.method = 'GET'});

  @override
  JsonMap toJson() => {};
}

class AddTaskRequest extends ApiRequest {
  const AddTaskRequest({
    super.apiUrl = '/todos/add',
    super.method = 'POST',
    required this.params,
  });

  final AddTaskParams params;

  @override
  JsonMap toJson() => params.toJson();
}

class DeleteTaskRequest extends ApiRequest {
  const DeleteTaskRequest({
    super.method = 'DELETE',
    required super.apiUrl,
  });

  @override
  JsonMap toJson() => {};
}

class EditTaskRequest extends ApiRequest {
  const EditTaskRequest({
    super.method = 'PUT',
    required super.apiUrl,
    required this.task,
  });

  final Task task;

  @override
  JsonMap toJson() => task.toJson();
}
