import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggerInterceptor extends Interceptor {
  void logDebug(Object? message) {
    if (kDebugMode) {
      if (message is Map) {
        log(json.encode(message));
      } else {
        log(message.toString());
      }
    }
  }

  /// Width size per logPrint
  final int maxWidth = 90;

  final bool responseBody;

  /// to detect print function
  void logPrint(Object? object) {
    if (kDebugMode) {
      if (object is Map) {
        log(json.encode(object));
      } else {
        log(object.toString());
      }
    }
  }

  LoggerInterceptor({
    this.responseBody = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printLine('╔', '╗');
    logPrint(_cURLRepresentation(options));
    logPrint('Request Body');
    logPrint(options.data);
    _printLine('╚');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _printLine('╔', '╗');
    if (err.type == DioExceptionType.connectionError) {
      logPrint(_cURLRepresentation(err.requestOptions));
      final uri = err.response?.requestOptions.uri;
      logPrint(
          'DioError ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}');
      logPrint(uri.toString());
      if (err.response != null && err.response?.data != null) {
        logPrint(err.type.toString());
        logPrint(err.response!);
      }
    } else {
      logPrint('DioError ║ ${err.type}');
      logPrint(err.message);
    }
    _printLine('╚');
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printLine('╔', '╗');
    logPrint(_cURLRepresentation(response.requestOptions));
    logPrint(
        'Response ║ ${response.requestOptions.method} ║ Status: ${response.statusCode} ${response.statusMessage}');
    logPrint(response.requestOptions.uri.toString());
    final responseHeaders = <String, String>{};
    response.headers.forEach((k, list) => responseHeaders[k] = list.toString());
    logPrint(responseHeaders);
    if (responseBody) {
      logPrint(response);
    }
    _printLine('╚');
    handler.next(response);
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ["\$ curl -i"];
    components.add("-X ${options.method}");

    options.headers.forEach((k, v) {
      if (k != "Cookie") {
        components.add("-H \"$k: $v\"");
      }
    });

    if (options.method.toUpperCase() != "GET") {
      try {
        var data = json.encode(options.data);
        data = data.replaceAll('"', '\\"');
        components.add("-d \"$data\"");
      } catch (e, s) {}
    }

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }

  void _printLine([String pre = '', String suf = '╝']) {
    logPrint('$pre${'═' * (maxWidth ~/ 2.0)}${'═' * (maxWidth ~/ 2.0)}$suf');
  }
}
