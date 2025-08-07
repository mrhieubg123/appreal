import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/function/function.dart';
import 'package:my_app/core/widget/select_image_device.dart';

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
        title: Text(
          'Nhập nguyên nhân/giải pháp mới',
          style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
        ),
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
            SelectImageDeviceWidget(),
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

Future<Map<String,dynamic>?> showConfirmMaintenanceDialog({type = 0}) async {
  TextEditingController controllerSpec = TextEditingController();
  TextEditingController controllerAction = TextEditingController();
  TextEditingController controllerContent = TextEditingController();

  return showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Confirm Maintenance ${type == 0 ? "Weekly" : "Monthly"}',
          style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 1.sw - 48.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerSpec,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Nhập đặc điểm kỹ thuật...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.h),
              TextField(
                controller: controllerAction,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Nhập hành động...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.h),
              TextField(
                controller: controllerContent,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Nhập nội dung...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // đóng dialog
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              String spec = controllerSpec.text.trim();
              String action = controllerAction.text.trim();
              String content = controllerContent.text.trim();
              if (spec.isEmpty) {
                showDialogMessage(message: "Vui lòng nhập đặc điểm kỹ thuật");
                return;
              } else if (action.isEmpty) {
                showDialogMessage(message: "Vui lòng nhập hành động");
                return;
              } else if (content.isEmpty) {
                showDialogMessage(message: "Vui lòng nhập nội dung");
                return;
              }
              Navigator.pop(context, {
                "maintenance_type": type == 0 ? "WEEKLY" : "MONTHLY",
                "tech_spec": spec,
                "action_taken": action,
                "content": content,
              }); // đóng dialog
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
