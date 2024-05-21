import 'package:task_manager_app/models/typedefs.dart';

class AddTaskParams {
  final String todo;
  final int userId;
  final bool completed;

  const AddTaskParams({
    required this.todo,
    required this.userId,
    required this.completed,
  });

  JsonMap toJson() {
    return {
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }
}
