import 'package:task_manager_app/models/data_models/api_request.dart';
import 'package:task_manager_app/models/params/login_params.dart';
import 'package:task_manager_app/models/typedefs.dart';

class LoginRequest extends ApiRequest {
  final LoginParams params;

  const LoginRequest({
    super.apiUrl = '/auth/login',
    super.method = 'POST',
    required this.params,
  });

  @override
  JsonMap toJson() => params.toMap();
}
