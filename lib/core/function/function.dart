import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/widget/dialog.dart';
import 'package:my_app/main.dart';
import 'package:permission_handler/permission_handler.dart';

class FunctionExp {
  Future pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        print("Ảnh đã chọn: ${image.path}");
        return image;
      }
    } else {
      showDialogMessage(message: "Quyền camera bị từ chối.");
    }
    return;
  }

  Future pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return image;
      } else {
        print("❗ Không chọn ảnh nào");
        return null;
      }
    } catch (e) {
      print("❌ Lỗi khi chọn ảnh từ gallery: $e");
      return null;
    }
  }

  Future<XFile?> selectImageFromDevice() async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: navigatorKey.currentContext!,
      elevation: 0,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Đóng",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              InkWell(
                onTap: () async {
                  XFile? result = await pickImageFromCamera();
                  if (result != null) {
                    Navigator.pop(navigatorKey.currentContext!, result);
                  }
                },
                child: Text(
                  "Mở Camera",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  XFile? result = await pickImageFromGallery();
                  if (result != null) {
                    Navigator.pop(navigatorKey.currentContext!, result);
                  }
                },
                child: Text(
                  "Mở thư viện ảnh",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
