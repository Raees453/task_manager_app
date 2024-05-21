import 'package:go_router/go_router.dart';
import 'package:task_manager_app/locator.dart';
import 'package:task_manager_app/models/data_models/task.dart';
import 'package:task_manager_app/screens/auth/login_screen.dart';
import 'package:task_manager_app/screens/home_screen.dart';
import 'package:task_manager_app/screens/tasks/add_task_screen.dart';
import 'package:task_manager_app/utils/constants/app_keys.dart';
import 'package:task_manager_app/utils/extensions.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) {
        return localStorage.read(AppKeys.user).isNotNull &&
                localStorage.read(AppKeys.token).isNotNull
            ? HomeScreen.routeName
            : null;
      },
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: AddTaskScreen.routeName,
      builder: (context, state) {
        final task = state.extra as Task?;

        return AddTaskScreen(task: task);
      },
    ),
  ],
);
