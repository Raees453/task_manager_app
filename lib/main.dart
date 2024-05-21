import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/locator.dart';
import 'package:task_manager_app/utils/app_router.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/view_models/tasks_provider.dart';
import 'package:task_manager_app/widgets/custom/app_widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjectionEnvironment.setup();
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
      ],
      child: ScreenUtilInit(
        builder: (_, __) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: context.theme.copyWith(
            // TODO work on it if needed
            listTileTheme: ListTileThemeData(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              titleTextStyle: context.textTheme.bodyLarge,
              subtitleTextStyle: context.textTheme.bodySmall,
              minVerticalPadding: 12,
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: AppWidgets.halfBorderRadius,
              ),
              selectedTileColor: const Color(0xffEDECFC),
              selectedColor: const Color(0xffEDECFC),
              enableFeedback: true,
            ),
          ),
        ),
      ),
    );
  }
}
