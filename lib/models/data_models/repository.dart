import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../enums.dart';
import 'api_error.dart';
import 'api_request.dart';
import 'api_response.dart';

abstract class Repository {
  Future<ApiResponse> executeAPI(
    ApiRequest request,
    Function jsonParser,
  ) async {
    String message, name;
    StackTrace? apiStackTrace;
    ErrorType errorType = ErrorType.known;

    if (kDebugMode) {
      log(
        request.toJson().toString(),
        name: '${request.runtimeType} Request, URL[${request.url}]',
      );
    }

    try {
      final response = await request.toCallback();

      final data = response.data;

      if (kDebugMode) {
        log(
          data.toString(),
          name: 'Execute API (${data.runtimeType} Response)',
        );
      }

      if (data['status'] == false) {
        log(
          data['message'],
          name: 'API ERROR (KNOWN) ${request.runtimeType}: ',
          time: DateTime.now(),
        );

        throw ApiError(
          message: data?['message'] ?? 'Something went wrong',
          errorType: ErrorType.known,
        );
      }

      return jsonParser(response.data);
    } on SocketException catch (e, stackTrace) {
      name = 'Execute API (Socket Exception)';
      message = 'Socket Exception';
      apiStackTrace = stackTrace;
      errorType = ErrorType.internet;
    } on FormatException catch (e, stackTrace) {
      name = 'Execute API (Format Exception) ${request.runtimeType.toString()}';
      message = 'Format Error';
      apiStackTrace = stackTrace;
      errorType = ErrorType.format;
    } on TimeoutException catch (e, stackTrace) {
      name = 'Execute API (Timeout Exception)';
      message = 'Timeout';
      apiStackTrace = stackTrace;
      errorType = ErrorType.timeout;
    } on DioException catch (e, stackTrace) {
      print(e.response?.data.toString());

      print(e.toString());

      // TODO Fix the 'Dio Error' fallback text
      name = 'Execute API (Dio Exception)';
      message = e.response?.data['message'].toString() ?? 'Dio Error';
      apiStackTrace = stackTrace;
      errorType = ErrorType.dio;
    } catch (e, stackTrace) {
      // TODO work on this message fetching strategy
      message = e.toString();
      name = 'Execute API (General Exception) ${request.runtimeType}';
      apiStackTrace = stackTrace;
      errorType = ErrorType.unknown;
    }

    // TODO Work on this printing strategy
    if (kDebugMode && errorType == ErrorType.format ||
        errorType == ErrorType.unknown) {
      log(
        message,
        name: name,
        time: DateTime.now(),
        stackTrace: apiStackTrace,
      );
    }

    throw ApiError(
      title: name,
      errorType: errorType,
      stackTrace: apiStackTrace,
      message: message,
    );
  }
}
