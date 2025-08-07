import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../function/function.dart';

class SelectImageDeviceWidget extends StatefulWidget {
  const SelectImageDeviceWidget({super.key});

  @override
  State<SelectImageDeviceWidget> createState() =>
      _SelectImageDeviceWidgetState();
}

class _SelectImageDeviceWidgetState extends State<SelectImageDeviceWidget> {
  XFile? fileImage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        XFile? result = await FunctionExp().selectImageFromDevice();
        setState(() {
          fileImage = result;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Text(
              "+ Ảnh nguyên nhân",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          if (fileImage != null)
            Container(
              height: 400.h,
              margin: EdgeInsets.only(top: 16.h),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Image.file(File(fileImage!.path)),
            ),
        ],
      ),
    );
  }
}
