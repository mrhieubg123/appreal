import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/core/model/error_stats_model.dart';
import 'package:my_app/core/model/machine_status_model.dart';
import 'package:my_app/main.dart';
import 'package:my_app/src/data_mau/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/interceptor/dio_client.dart';
import '../../../core/model/dashboard_error_model.dart';
import '../../../core/model/error_by_code_model.dart';
import '../../../core/model/error_detail_model.dart';
import '../../../core/model/error_detail_total_model.dart';
import '../../../core/model/error_not_confirm_model.dart';
import '../../../core/widget/dialog.dart';
import '../../data_mau/data_mau.dart';

class MachineStatusGetData {
  static String userId = "";

  Future testPushProxy({dataBody}) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode(
      dataBody ??
          {
            "method": "POST",
            "url": "http://10.225.42.70:5000/api/login",
            "headers": {
              "Accept-Encoding": "gzip, deflate, br",
              "Content-Type": "application/json",
            },
            "data": {"card_code": "V3241419", "password": "123456"},
          },
    );
    var dio = Dio();
    var response = await dio.request(
      'https://10.225.42.71:5000/api/proxy-api',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      return response;
      showDialogMessage(message: json.encode(response.data));
      print(json.encode(response.data));
    } else {
      showDialogMessage(message: response.statusMessage);
      print(response.statusMessage);
    }
  }

  Future<void> testConnectionWithDio({required String url, timeout = 5}) async {
    final dio =
        Dio(
            BaseOptions(
              baseUrl: timeout == 5
                  ? "https://10.255.42.71:5000/api/proxy-api"
                  : url,
              connectTimeout: Duration(seconds: timeout),
              receiveTimeout: Duration(seconds: timeout),
              headers: {
                'Content-Type': 'application/json',
                'Accept-Encoding': 'gzip, deflate, br',
              },
            ),
          )
          ..interceptors.add(
            LogInterceptor(requestBody: true, responseBody: true, error: true),
          );

    // Bypass SSL nếu cần
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) {
              print('Bypassing SSL for $host');
              return true;
            };
      return client;
    };
    final datatest = {
      'url': 'http://10.225.42.70:5000/api/login',
      'method': 'POST',
      'data': {'card_code': 'V3241419', 'password': '123456'},
      'headers': {
        'Content-Type': 'application/json',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    };

    try {
      Response response;
      if (timeout == 5) {
        response = await dio.post('', data: datatest);
        // response = await dio.post('/');
      }
      if (timeout == 6) {
        response = await dio.post('/');
      }
      if (timeout == 7) {
        await testPushProxy();
        return;
      } else {
        response = await dio.get('/');
      }
      showDialogMessage(
        message:
            '✅ Kết nối $url thành công: ${response.statusCode} ${response.data}',
      );
    } on DioException catch (e) {
      showDialogMessage(message: '❌ Lỗi $url : $e');
    } catch (e) {
      showDialogMessage(message: '❌ Kết nối $url thất bại: $e');
    }
  }

  Future callApiThroughProxy({url, method, header, data}) async {
    final dioPost = DioClient.instance;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, dynamic> headers = {
      "Accept-Encoding": "gzip, deflate, br",
      "Content-Type": "application/json",
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final proxyRequestBody = {
      "url": dioPost.options.baseUrl + url, // URL thật bạn muốn gọi
      "method": method ?? "GET",
      "data": data ?? {}, // Có thể là {} hoặc dữ liệu cho POST
      "headers": headers,
    };

    try {
      final Response response = await testPushProxy(dataBody: proxyRequestBody);
      return response;
    } on DioException catch (e) {
      showDialogMessage(message: '❌ Lỗi proxy: $e');
    } catch (e) {
      showDialogMessage(message: "❌ Lỗi khi gọi proxy: $e");
    }
    return;
  }

  Future getMachineStatus() async {
    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.get(Constants.urlMachineStatus);
      final response = await callApiThroughProxy(
        url: Constants.urlMachineStatus,
      );
      debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ListMachineStatusModel.fromJson(response.data);
      } else {
        throw Exception('Lỗi server: ${response.statusCode}');
      }
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return false;
    } catch (e) {
      throw Exception('Lỗi khi gọi API: $e');
    }
  }

  getUniqueSortedLines(List<MachineStatusModel> machines) {
    final lines = machines.map((m) => m.line!).toSet().toList();
    lines.sort(); // sắp xếp theo alphabet
    return lines;
  }

  getUniqueSortedLocations(List<MachineStatusModel> machines) {
    final locations = machines.map((m) => m.location!).toSet().toList();

    // Chuyển về số để sort theo giá trị (không phải chuỗi)
    locations.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    return locations;
  }

  Future getListConfirm() async {
    // return ListErrorNotConfirmModel.fromJson(getListConfirm_example);
    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.get(Constants.urlGetListConfirm);
      final response = await callApiThroughProxy(
        url: Constants.urlGetListConfirm,
      );
      debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ListErrorNotConfirmModel.fromJson(response.data);
      } else {
        showDialogMessage(message: 'Lỗi server: ${response.statusCode}');
      }
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future getListErrorDetail({required String errorCode}) async {
    final dioPost = DioClient.instance;

    try {
      final response = await dioPost.get(
        "errors_details",
        queryParameters: {'error_code': errorCode},
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ErrorDetailsModel.fromJson(response.data);
      } else {
        showDialogMessage(message: 'Lỗi server: ${response.statusCode}');
      }
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future getDashboardError({required body}) async {
    // return DashboardErrorModel.fromJson(api_dashboard_error_example);

    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.post(
      //   Constants.urlDashboardError,
      //   data: body,
      // );
      final response = await callApiThroughProxy(
        url: Constants.urlDashboardError,
        method: "POST",
        data: body,
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return DashboardErrorModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return false;
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future getErrorByCode({required body}) async {
    // return ErrorDetailByCodeModel.fromJson(getErrorByCode_example);

    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.post(
      //   Constants.urlErrorsByCode,
      //   data: body,
      // );
      final response = await callApiThroughProxy(
        url: Constants.urlErrorsByCode,
        method: "POST",
        data: body,
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ErrorDetailByCodeModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return false;
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future getErrorDetail({required body}) async {
    // return ErrorDetailTotalModel.fromJson(getErrorDetail_example);

    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.post(
      //   Constants.urlGetErrorDetail,
      //   data: body,
      // );
      final response = await callApiThroughProxy(
        url: Constants.urlGetErrorDetail,
        method: "POST",
        data: body,
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ErrorDetailTotalModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return;
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future createConfirmError({required body}) async {
    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.post(
      //   Constants.urlConfirmErrorDetail,
      //   data: body,
      // );
      final response = await callApiThroughProxy(
        url: Constants.urlConfirmErrorDetail,
        method: "POST",
        data: body,
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        showDialogMessage(message: response.data["message"]);
        return true;
      }
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return;
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future createCauseSolution({required body}) async {
    final dioPost = DioClient.instance;

    try {
      // final response = await dioPost.post(Constants.urlAddError, data: body);
      final response = await callApiThroughProxy(
        url: Constants.urlAddError,
        method: "POST",
        data: body,
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return true;
      }
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return;
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future getErrorStatsModel({required String errorCode}) async {
    final dioPost = DioClient.instance;

    try {
      final response = await dioPost.get(
        "error_stats",
        queryParameters: {'error_code': errorCode},
      );
      // debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ErrorStatsModel.fromJson(response.data);
      } else {
        showDialogMessage(message: 'Lỗi server: ${response.statusCode}');
      }
    } catch (e) {
      showDialogMessage(message: 'Lỗi khi gọi API: $e');
    }
  }

  Future createConfirmData({
    required String errorCode,
    required int idCause,
    int? idSolution,
    String? textSolution,
    required String userId,
    required int idErrorConfirm,
  }) async {
    final dioPost = DioClient.instance;

    try {
      final Map<String, dynamic> body = {
        "error_code": errorCode,
        "id_cause": idCause,
        "id_solution": idSolution,
        "user_id": userId,
        "id_error_confirm": idErrorConfirm,
        if (idSolution == null && textSolution != null)
          "text_solution": textSolution,
      };

      final response = await dioPost.post('createConfirm', data: body);

      if (response.statusCode == 201) {
        final data = response.data;
        showDialogMessage(
          message:
              '✅ Success: id_confirm = ${data['id_confirm']}, id_solution = ${data['id_solution']}',
        );
        return data;
      } else {
        showDialogMessage(
          message: '❌ Error: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        showDialogMessage(message: '❗ Timeout while connecting to API');
      } else if (e.response != null) {
        showDialogMessage(
          message:
              '❗ Server error: ${e.response?.statusCode} - ${e.response?.data}',
        );
      } else {
        showDialogMessage(message: '❗ Dio error: ${e.message}');
      }
    } catch (e) {
      showDialogMessage(message: '❗ Unknown error: $e');
    }
    return;
  }

  Future<bool> registerUser({
    required String name,
    required String cardId,
    required String password,
  }) async {
    try {
      // final response = await dioPost.post(
      //   Constants.urlRegister,
      //   data: {"name": name, "password": password, "card_code": cardId},
      // );
      final response = await callApiThroughProxy(
        url: Constants.urlRegister,
        method: "POST",
        data: {"name": name, "password": password, "card_code": cardId},
      );

      if (response != null) {
        showDialogMessage(
          message: '✅ Tạo tài khoản thành công',
          onOk: () {
            Navigator.pop(navigatorKey.currentContext!);
          },
        );
        return true;
      }
      return false;
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return false;
    } catch (e) {
      showDialogMessage(message: '❌ Dio Exception: $e');
      return false;
    }
  }

  Future<bool> loginUser(String cardId, String password) async {
    try {
      // final response = await dioPost.post(
      //   Constants.urlLogin,
      //   data: {'card_code': cardId, 'password': password},
      // );
      final response = await callApiThroughProxy(
        url: Constants.urlLogin,
        method: "POST",
        data: {'card_code': cardId, 'password': password},
      );

      if (response != null) {
        userId = cardId;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
        print('✅ Đăng nhập thành công: $cardId');
        return true;
      }
      return false;
    } on DioException catch (e) {
      showDialogMessage(message: e.response?.data['error']);
      return false;
    } catch (e) {
      showDialogMessage(message: '❌ Lỗi không xác định: $e');
      return false;
    }
  }
}
