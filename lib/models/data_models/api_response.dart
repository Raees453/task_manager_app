import 'package:task_manager_app/models/typedefs.dart';

abstract class ApiResponse {
  final dynamic body;

  const ApiResponse({
    required this.body,
  });

  JsonMap toJson() {
    return {'data': body};
  }
}
