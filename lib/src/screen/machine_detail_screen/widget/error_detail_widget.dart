import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/model/machine_status_model.dart';
import '../../machine_detail_screen/machine_detsail_screen.dart';
import 'drop_down_button_cause.dart';

class ErrorDetailWidget extends StatelessWidget {
  ErrorDetailWidget({super.key, required this.machines});

  List<MachineStatusModel> machines = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(color: Color(0xff1b1c54)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
            child: Divider(color: Colors.grey),
          ),
          Text(
            "Danh sách nguyên nhân",
            style: TextStyle(
              fontSize: 40.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
              SizedBox(width: 24.w),
              Text("Tần suất",style: TextStyle(fontSize: 32.sp)),
            ],
          ),
          SizedBox(height: 32.h),
          DropDownButtonCause(),
          DropDownButtonCause(),
          DropDownButtonCause(),
          DropDownButtonCause(),
        ],
      ),
    );
  }
}
