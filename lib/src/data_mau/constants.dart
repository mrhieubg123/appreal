import 'package:flutter/material.dart';

class Constants {
  static const Map<String, dynamic> statusMachine = {
    "RUN": {"name": "Đang hoạt động", "color": Colors.green},
    "ERROR": {"name": "Đang lỗi", "color": Colors.red},
    "NA": {"name": "Không xác định", "color": Colors.grey},
  };
}
