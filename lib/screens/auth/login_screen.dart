import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/models/data_models/api_error.dart';
import 'package:task_manager_app/models/data_models/user.dart';
import 'package:task_manager_app/models/params/login_params.dart';
import 'package:task_manager_app/utils/constants/app_keys.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/utils/validators.dart';
import 'package:task_manager_app/utils/widget_utils.dart';
import 'package:task_manager_app/widgets/custom/app_widgets.dart';
import 'package:task_manager_app/widgets/custom/base_scaffold.dart';
import 'package:task_manager_app/widgets/custom/base_text_field.dart';
import 'package:task_manager_app/widgets/theme/app_colors.dart';

import '../../locator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      _userNameController.text = 'kminchelle';
      _passwordController.text = '0lelplR';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back!',
              style: context.textTheme.titleLarge,
            ),
            // AppWidgets.halfVerticalGap,
            Text(
              'Please provide all the details to login',
              style: context.textTheme.titleSmall?.copyWith(
                color: AppColors.textSubTitleColorLight,
              ),
            ),
            AppWidgets.verticalGap,
            AppWidgets.verticalGap,
            CustomTextField(
              title: 'Username',
              hintText: 'Enter Username',
              controller: _userNameController,
              validator: Validators.validateNonEmptyString,
            ),
            AppWidgets.verticalGap,
            CustomTextField(
              obscureText: true,
              title: 'Password',
              hintText: 'Enter Password',
              controller: _passwordController,
              validator: Validators.validateNonEmptyString,
            ),
            AppWidgets.halfVerticalGap,
            AppWidgets.verticalGap,
            OutlinedButton(
              onPressed: _onLoginPressed,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final userName = _userNameController.text.trim();
    final password = _passwordController.text;

    final params = LoginParams(userName: userName, password: password);

    final navigator = context.navigator;

    String? message;
    try {
      final response = await authRepository.login(params);

      final user = response.body as User;

      await localStorage.write(AppKeys.user, jsonEncode(user));
      await localStorage.write(AppKeys.token, user.token);

      message = 'Logged in Successfully';
      navigator.go('/');
    } on ApiError catch (e) {
      message = e.message;
    }

    WidgetUtils.displayToast(message);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
