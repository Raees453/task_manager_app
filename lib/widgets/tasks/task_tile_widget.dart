import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/models/data_models/task.dart';
import 'package:task_manager_app/screens/tasks/add_task_screen.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/view_models/tasks_provider.dart';
import 'package:task_manager_app/widgets/custom/app_widgets.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task});

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool _isCompleted;

  @override
  void initState() {
    _isCompleted = widget.task.completed;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: _onTap,
    //   child: Container(
    //     margin: EdgeInsets.symmetric(vertical: 4.h),
    //     decoration: BoxDecoration(
    //       borderRadius: AppWidgets.borderRadius,
    //     ),
    //     child: CheckboxListTile(
    //       tileColor: context.theme.primaryColor.withOpacity(0.2),
    //       value: _isCompleted,
    //       title: Text(widget.task.todo),
    //       tristate: true,
    //       onChanged: _onToggleTaskPressed,
    //     ),
    //   ),
    // );

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: AppWidgets.halfBorderRadius,
          color: context.theme.primaryColor.withOpacity(0.2),
        ),
        child: Row(
          children: [
            Checkbox(value: _isCompleted, onChanged: _onToggleTaskPressed),
            Expanded(
              child: Text(
                widget.task.todo,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyLarge?.copyWith(
                  decoration: _isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            IconButton(
              onPressed: _onEditPressed,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: _onDeletePressed,
              icon: const Icon(Icons.delete_outline_outlined),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() =>
      context.navigator.push(AddTaskScreen.routeName, extra: widget.task);

  void _onToggleTaskPressed(bool? value) {
    value ??= false;

    setState(() => _isCompleted = value!);
  }

  void _onEditPressed() =>
      context.navigator.push(AddTaskScreen.routeName, extra: widget.task);

  void _onDeletePressed() async {
    final provider = Provider.of<TasksProvider>(context, listen: false);

    final shouldDelete = await showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Task'),
            content:
                Text('Are you sure you want to delete ${widget.task.todo}'),
            actions: [
              TextButton(
                onPressed: () => context.navigator.pop(true),
                child: const Text('Delete'),
              ),
              TextButton(
                onPressed: () => context.navigator.pop(false),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ) ??
        false;

    if (!shouldDelete) return;

    await provider.deleteTask(widget.task.id);
  }
}
