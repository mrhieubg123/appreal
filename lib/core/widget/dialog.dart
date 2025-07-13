import 'package:flutter/material.dart';

import '../../main.dart';

showDialogMessage({message = "", title = "Thông báo"}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý khi xác nhận
              Navigator.pop(context);
            },
            child: const Text("Đóng"),
          ),
        ],
      );
    },
  );
}

Future<String?> showTextInputDialog() async {
  TextEditingController controller = TextEditingController();

  return showDialog<String?>(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: const Text('Nhập giải pháp mới'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Nhập vào đây...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // đóng dialog
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, controller.text); // đóng dialog
              // Hoặc gọi callback / xử lý dữ liệu ở đây
            },
            child: const Text('Xác nhận'),
          ),
        ],
      );
    },
  );
}

showDialogLoading() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return Center(child: CircularProgressIndicator());
    },
  );
}

closeDialogLoading() {
  Navigator.pop(navigatorKey.currentContext!);
}
