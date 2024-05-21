import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/models/data_models/task.dart';
import 'package:task_manager_app/screens/tasks/add_task_screen.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/view_models/tasks_provider.dart';
import 'package:task_manager_app/widgets/custom/app_widgets.dart';
import 'package:task_manager_app/widgets/custom/base_scaffold.dart';
import 'package:task_manager_app/widgets/custom/list_view.dart';

import '../widgets/tasks/task_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TasksProvider? _provider;

  @override
  void initState() {
    final provider = Provider.of<TasksProvider>(context, listen: false);

    if (provider.tasks == null) {
      Future.delayed(Duration.zero, provider.fetchAllTasks);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _provider = Provider.of<TasksProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // it should get all the tasks for the user
    // list them all
    // have edit/delete options for the product

    return BaseScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTaskPressed,
        child: const Icon(Icons.add),
      ),
      child: Consumer<TasksProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (provider.isLoadingErrorOccurred) {
            return const Center(child: Text('Some Error Occurred'));
          }

          final list =
              Provider.of<TasksProvider>(context, listen: false).tasks ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppWidgets.halfVerticalGap,
              Text(
                'Tasks',
                style: context.textTheme.titleMedium,
              ),
              CustomListView<Task>(
                items: list,
                bottomSpacing: 64,
                listBuilder: (task) => TaskWidget(task: task),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onAddTaskPressed() => context.navigator.push(AddTaskScreen.routeName);
}
