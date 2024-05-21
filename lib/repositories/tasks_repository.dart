import 'package:task_manager_app/models/data_models/api_response.dart';
import 'package:task_manager_app/models/data_models/repository.dart';
import 'package:task_manager_app/models/params/task_params.dart';
import 'package:task_manager_app/models/requests/tasks_requests.dart';
import 'package:task_manager_app/models/responses/tasks_response.dart';

class TasksRepository extends Repository {
  Future<ApiResponse> fetchAllTasks() {
    return super.executeAPI(
      const FetchTasksRequest(),
      FetchTasksResponse.fromJson,
    );
  }

  Future<ApiResponse> addTask(AddTaskParams params) {
    return super.executeAPI(
      AddTaskRequest(params: params),
      AddTaskResponse.fromJson,
    );
  }

  Future<ApiResponse> deleteTask(int id) {
    return super.executeAPI(
      DeleteTaskRequest(apiUrl: '/todos/$id'),
      DeleteTaskResponse.fromJson,
    );
  }

  Future<ApiResponse> editTask(EditTaskRequest request) async {
    return super.executeAPI(
      request,
      AddTaskResponse.fromJson,
    );
  }
}
