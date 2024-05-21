import 'package:task_manager_app/models/params/login_params.dart';
import 'package:task_manager_app/models/requests/auth_requests.dart';
import 'package:task_manager_app/models/responses/auth_response.dart';

import '../models/data_models/api_response.dart';
import '../models/data_models/repository.dart';

class AuthRepository extends Repository {
  Future<ApiResponse> login(LoginParams params) {
    return super.executeAPI(
      LoginRequest(params: params),
      LoginResponse.fromJson,
    );
  }
}
