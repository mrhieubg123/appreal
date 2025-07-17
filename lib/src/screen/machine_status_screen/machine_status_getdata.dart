import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/core/model/error_stats_model.dart';
import 'package:my_app/core/model/machine_status_model.dart';
import 'package:my_app/main.dart';
import '../../../core/model/error_detail_model.dart';
import '../../../core/model/error_not_confirm_model.dart';
import '../../../core/widget/dialog.dart';
import '../../data_mau/data_mau.dart';

class MachineStatusGetData {
  static String userId = "";
  Dio dioPost = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL_RMS']!, // ⚠️ Đổi nếu cần
      connectTimeout: Duration(seconds: 200),
      receiveTimeout: Duration(seconds: 200),
      headers: {
        'Content-Type': 'application/json',
        'Connection': 'close',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    ),
  );
  Future getMachineStatus() async {
    dynamic result;
    final dio = Dio();

    try {
      final response = await dioPost.get("machines_status");
      debugPrint(response.toString());
      if (response.statusCode == 200 && response.data != null) {
        return ListMachineStatusModel.fromJson(response.data);
      } else {
        throw Exception('Lỗi server: ${response.statusCode}');
      }
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
    try {
      final response = await dioPost.get("data_confirm");
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
    dioPost.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

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

  Future getErrorStatsModel({required String errorCode}) async {
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

  Future<bool> registerUser(String cardId, String password) async {
    final dio = Dio();

    try {
      final response = await dioPost.post(
        'register_user',
        data: {'card_id': cardId, 'password': password},
      );

      if (response.statusCode == 201) {
        showDialogMessage(
          message: '✅ Đăng ký thành công',
          onOk: () {
            Navigator.pop(navigatorKey.currentContext!);
          },
        );
        return true;
      }
      return false;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 409) {
        showDialogMessage(message: '⚠️ Người dùng đã tồn tại');
      } else {
        showDialogMessage(message: '❌ Lỗi không xác định: $status');
      }
      return false;
    } catch (e) {
      showDialogMessage(message: '❌ Dio Exception: $e');
      return false;
    }
  }

  Future<bool> loginUser(String cardId, String password) async {
    // Đổi theo môi trường chạy

    try {
      final response = await dioPost.post(
        'login_user',
        data: {'card_id': cardId, 'password': password},
      );

      if (response.statusCode == 200) {
        userId = cardId;

        print('✅ Đăng nhập thành công: $cardId');
        return true;
      }
      return false;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 401) {
        showDialogMessage(message: '❌ Mật khẩu sai');
      } else if (status == 404) {
        showDialogMessage(message: '❌ Không tìm thấy người dùng');
      } else {
        showDialogMessage(message: '❌ Lỗi Dio khác: $status - ${e.message}');
      }
      return false;
    } catch (e) {
      showDialogMessage(message: '❌ Lỗi không xác định: $e');
      return false;
    }
  }
}
