import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/locator.dart';
import 'package:task_manager_app/models/data_models/api_error.dart';
import 'package:task_manager_app/models/data_models/task.dart';
import 'package:task_manager_app/models/data_models/user.dart';
import 'package:task_manager_app/models/params/task_params.dart';
import 'package:task_manager_app/models/requests/tasks_requests.dart';
import 'package:task_manager_app/utils/constants/app_keys.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/utils/widget_utils.dart';
import 'package:task_manager_app/view_models/tasks_provider.dart';
import 'package:task_manager_app/widgets/custom/app_widgets.dart';
import 'package:task_manager_app/widgets/custom/base_scaffold.dart';
import 'package:task_manager_app/widgets/custom/base_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  static const String routeName = '/add-task';

  const AddTaskScreen({super.key, this.task});

  final Task? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _toDoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late Task? _task;

  @override
  void initState() {
    if (widget.task.isNotNull) _toDoController.text = widget.task!.todo;

    _task = widget.task;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = ['Completed', 'Pending'];

    return BaseScaffold(
      title: widget.task.isNotNull ? 'Edit Task' : 'Add Task',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppWidgets.halfVerticalGap,
            AppWidgets.verticalGap,
            CustomTextField(
              maxLines: 5,
              title: 'Task Description',
              hintText: 'Enter Task Description',
              controller: _toDoController,
            ),
            AppWidgets.halfVerticalGap,
            const CustomFieldTitleWidget(title: 'Task Status'),
            DropdownButtonFormField(
              value: _task == null
                  ? null
                  : _task!.completed
                      ? items.first
                      : items.last,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: AppWidgets.halfBorderRadius,
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.7)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppWidgets.halfBorderRadius,
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.7)),
                ),
              ),
              hint: Text(
                'Select a status',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: _onTaskStatusPressed,
            ),
            AppWidgets.verticalGap,
            OutlinedButton(
              onPressed:
                  widget.task == null ? _onAddTaskPressed : _onEditTaskPressed,
              child: Text('${widget.task == null ? 'Add' : 'Edit'} Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _onTaskStatusPressed(String? value) {
    if (value == null) return;

    _task = _task?.copyWith(completed: value.toLowerCase() == 'completed');
  }

  void _onAddTaskPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final toDo = _toDoController.text.trim();
    final user = User.fromJson(
      jsonDecode(localStorage.read(AppKeys.user).toString()),
    );

    final params = AddTaskParams(todo: toDo, userId: user.id, completed: false);

    final navigator = context.navigator;

    String? message;

    try {
      await (Provider.of<TasksProvider>(context, listen: false))
          .addTask(params);
      message = 'Task Added Successfully';
      navigator.pop();
    } on ApiError catch (e) {
      message = e.message;
    }

    WidgetUtils.displayToast(message);
  }

  void _onEditTaskPressed() async {
    if (!_formKey.currentState!.validate() || _task == null) return;

    final toDo = _toDoController.text.trim();

    _task = _task!.copyWith(todo: toDo);

    final request =
        EditTaskRequest(apiUrl: '/todos/${_task!.id}', task: _task!);

    final navigator = context.navigator;

    String? message;
    try {
      await tasksRepository.editTask(request);

      message = 'Task Edited Successfully';
    } on ApiError catch (e) {
      message = e.message;
    }

    WidgetUtils.displayToast(message);
    navigator.pop();
  }

  @override
  void dispose() {
    _toDoController.dispose();
    super.dispose();
  }
}
