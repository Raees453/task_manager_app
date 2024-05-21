import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/utils/extensions.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.showAppBar = true,
    this.showBottomNavBar = true,
    this.showDrawer = false,
    this.ignoreSelection = false,
    this.title,
    required this.child,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.bottomSheet,
  });

  final bool showAppBar;
  final bool showDrawer;
  final bool showBottomNavBar;
  final bool ignoreSelection;

  final String? title;
  final Widget? drawer;
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? TaskManagerAppBar(title: title) : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: child,
        ),
      ),
      bottomSheet: bottomSheet,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? 'Task Manger App'),
      backgroundColor: context.theme.primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
