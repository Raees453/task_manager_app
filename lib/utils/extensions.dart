import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

extension NullExtension on Object? {
  get isNotNull => this != null;
}

extension BuildContextExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.of(this).size;

  Brightness get brightness => Theme.of(this).brightness;

  GoRouter get navigator => GoRouter.of(this);

  void unFocus() => FocusScope.of(this).unfocus();
}

extension DateTimeExtension on DateTime {
  int toTimeStamp() => (millisecondsSinceEpoch / 1000).round();

  String toSimpleString() => DateFormat('yyyy-MM-dd').format(this);

  DateTime get absolute => DateTime(year, month, day);

  String toSimpleDate() {
    try {
      final dateFormat = DateFormat('MMM d, yyyy');
      return dateFormat.format(this);
    } catch (e) {
      // TODO inform the backend about the invalid date using crashlytics
      final dateFormat = DateFormat('MMM d, yyyy');
      return dateFormat.format(DateTime.now());
    }
  }
}

extension StringExtension on String {
  double toDouble() => double.parse(this);

  int toInt() => int.parse(this);

  String toFormattedPhone() =>
      '+${substring(0, 2)} ${substring(2, 5)} ${substring(5)}';

  String toFormattedCNIC() =>
      '${substring(0, 5)} ${substring(5, length - 2)} ${substring(length - 1)}';

  String extension() => substring(lastIndexOf('.') + 1, length);

  // TODO Change different date formate
  DateTime toDate() {
    try {
      final dateFormat = DateFormat("MMM dd yyyy HH:mm:ss 'GMT'ZZZZ");

      return dateFormat.parse(split(' ').sublist(1, 6).join(' '), true);
    } catch (e) {
      // TODO let crashlytics know about the crash
      return DateTime.now();
    }
  }
}
