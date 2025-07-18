import 'package:flutter/material.dart';

import '../../main.dart';

showDialogMessage({message = "", title = "Thông báo", onOk}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý khi xác nhận
              Navigator.pop(navigatorKey.currentContext!);
              if (onOk != null) onOk();
            },
            child: const Text("Đóng"),
          ),
        ],
      );
    },
  );
}

Future<List<String?>?> showTextInputDialog() async {
  TextEditingController controllerNN = TextEditingController();
  TextEditingController controllerGP = TextEditingController();

  return showDialog<List<String?>>(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: const Text('Nhập nguyên nhân/giải pháp mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerNN,
              decoration: const InputDecoration(
                hintText: 'Nhập nguyên nhân...',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controllerGP,
              decoration: const InputDecoration(
                hintText: 'Nhập giải pháp...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // đóng dialog
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              String nn = controllerNN.text.trim();
              String gp = controllerGP.text.trim();
              if (nn.isEmpty) {
                showDialogMessage(message: "Vui lòng nhập nguyên nhân");
                return;
              } else if (gp.isEmpty) {
                showDialogMessage(message: "Vui lòng nhập giải pháp");
                return;
              }
              Navigator.pop(context, [
                controllerNN.text,
                controllerGP.text,
              ]); // đóng dialog
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
