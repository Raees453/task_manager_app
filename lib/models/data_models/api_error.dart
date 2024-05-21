import '../enums.dart';

class ApiError implements Exception {
  final String? title;
  final StackTrace? stackTrace;
  final ErrorType errorType;
  final String message;

  const ApiError({
    this.title,
    this.stackTrace,
    required this.errorType,
    required this.message,
  });
}
