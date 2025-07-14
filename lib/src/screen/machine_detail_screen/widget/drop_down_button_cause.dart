import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/dialog.dart';
import '../../../../main.dart';

class DropDownButtonCause extends StatefulWidget {
  const DropDownButtonCause({super.key});

  @override
  State<DropDownButtonCause> createState() => _DropDownButtonCauseState();
}

class _DropDownButtonCauseState extends State<DropDownButtonCause> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 32.h),
      decoration: BoxDecoration(
        color: Color(0xff9ee2dd),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              isOpen = !isOpen;
            }),
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              // padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.orange, // màu viền
                  width: 4.w, // độ dày viền
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(color: Color(0xff14a551)),
                      padding: EdgeInsets.symmetric(
                        vertical: 32.h,
                        horizontal: 16.w,
                      ),
                      child: Center(
                        child: Text(
                          "100",
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 8.w,
                        ),
                        child: Text(
                          "Nguyeen nhan loi do ad asd asd ad asd asd sa dsa d sad sa d asd as ad ad ad acbac bacbab cbacb asd sad asd as dsa d asd",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      isOpen
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 88.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isOpen)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Danh sách giải pháp",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 20.w),
                      Text("Số lần dùng",style: TextStyle(fontSize: 28.sp)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  giaiPhapWiget(),
                  giaiPhapWiget(),
                  giaiPhapWiget(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  giaiPhapWiget() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 16.w),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amberAccent,
                ),
                child: Center(
                  child: Text(
                    "20",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Giai phap 1 djasdjjsad asdasd asd sad sa d asd as dsa d ",
                  style: TextStyle(
                    fontSize: 36.sp,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(color: Colors.grey),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
