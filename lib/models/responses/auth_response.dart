import 'package:task_manager_app/models/data_models/api_response.dart';
import 'package:task_manager_app/models/typedefs.dart';

import '../data_models/user.dart';

class LoginResponse extends ApiResponse {
  const LoginResponse({required super.body});

  factory LoginResponse.fromJson(JsonMap json) {
    return LoginResponse(body: User.fromJson(json));
  }
}
