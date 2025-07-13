import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../widget/dialog.dart';
import 'api.dio.dart';
import 'dio.exceptions.dart';

class BaseServices<T> {
  Future<dynamic> uploadFile(
    String subUri, {
    String? urlRoot,
    bool? showLoading,
    dynamic body,
    dynamic queryParameters,
    BuildContext? context,
  }) async {
    // convert  body
    if (body.runtimeType == String) {
      body = body;
    }

    if (showLoading == null) {
      showDialogLoading();
    }

    String fileName = body.split('/').last;
    var formData = FormData.fromMap({
      "Content-Disposition": "form-data",
      "name": "file",
      "Content-Type": "image/png",
      "file": await MultipartFile.fromFile(body, filename: fileName)
    });

    try {
      final Response<dynamic> response =
          await ApiDio.dioApi(url: urlRoot).post<dynamic>(subUri,
              options: Options(
                contentType: "image/png",
              ),
              data: formData,
              queryParameters: queryParameters);
      if (showLoading == null) {
        closeDialogLoading();
      }

      if (response.statusCode == 200) {
        return responseData(response.data);
      }
    } on DioException catch (onError) {
      if (showLoading == null) {
        closeDialogLoading();
      }
      DioExceptions.fromDioError(onError);
    }
    return null;
  }

  Future<dynamic> post(
    String subUri, {
    String? urlRoot,
    bool? showLoading,
    dynamic body,
    dynamic queryParameters,
    BuildContext? context,
  }) async {
    // convert  body
    if (body.runtimeType == String) {
      body = body;
    }

    if (showLoading == null) {
      showDialogLoading();
    }
    try {
      final Response<dynamic> response = await ApiDio.dioApi(url: urlRoot)
          .post<dynamic>(subUri,
              data: body ?? {}, queryParameters: queryParameters);
      if (showLoading == null) {
        closeDialogLoading();
      }

      if (response.statusCode == 200) {
        return responseData(response.data);
      }
    } on DioException catch (onError) {
      if (showLoading == null) {
        closeDialogLoading();
      }
      DioExceptions.fromDioError(onError);
    }
    return null;
  }

  Future<dynamic> get(
    String subUri, {
    String? urlRoot,
    bool? showLoading,
    dynamic body,
    dynamic queryParameters,
    BuildContext? context,
  }) async {
    // convert  body
    if (body.runtimeType == String) {
      body = body;
    }

    if (showLoading == null) {
      showDialogLoading();
    }
    try {
      final Response<dynamic> response = await ApiDio.dioApi(url: urlRoot)
          .get<dynamic>(subUri,
              data: body ?? {}, queryParameters: queryParameters);
      if (showLoading == null) {
        closeDialogLoading();
      }
      if (response.statusCode == 200) {
        return responseData(response.data);
      }
    } on DioException catch (onError) {
      if (showLoading == null) {
        closeDialogLoading();
      }
      DioExceptions.fromDioError(onError);
    }
    return null;
  }

  Future<dynamic> put(
    String subUri, {
    String? urlRoot,
    bool? showLoading,
    dynamic body,
    BuildContext? context,
    dynamic queryParameters,
  }) async {
    // convert  body
    if (body.runtimeType == String) {
      body = body;
    }
    if (showLoading == null) {
      showDialogLoading();
    }
    try {
      final Response<dynamic> response = await ApiDio.dioApi(url: urlRoot)
          .put<dynamic>(subUri,
              data: body ?? {}, queryParameters: queryParameters);
      if (showLoading == null) {
        closeDialogLoading();
      }
      if (response.statusCode == 200) {
        return responseData(response.data);
      }
    } on DioException catch (onError) {
      if (showLoading == null) {
        closeDialogLoading();
      }
      DioExceptions.fromDioError(onError);
    }
    return null;
  }

  responseData(response) {
    if (response.runtimeType == String) {
      final data = jsonDecode(response);

      return data;
    }
    return;
  }
}
