import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/drop_down_button.dart';

class ErrorStableScreen extends StatelessWidget {
  const ErrorStableScreen({super.key});

  final List columnNames = const [
    {"name": "Tên máy", "flex": 2},
    {"name": "Thời gian lỗi", "flex": 2},
    {"name": "Mã lỗi", "flex": 2},
    {"name": "Nguyên nhân", "flex": 2},
    {"name": "Biện pháp", "flex": 2},
    {"name": "", "flex": 1},
  ];
  final List columnData = const [
    {"name": "Tên máy", "flex": 2},
    {"name": "Thời gian lỗi", "flex": 2},
    {"name": "Mã lỗi", "flex": 2},
    {"name": "Nguyên nhân", "flex": 2},
    {"name": "Biện pháp", "flex": 2},
    {"name": "", "flex": 1},
  ];

  Widget buildColumnName() {
    return Row(
      children: [
        ...List.generate(columnNames.length, (lineIndex) {
          return Flexible(
            flex: columnNames[lineIndex]['flex'],
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        columnNames[lineIndex]['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 231, 57, 57),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget buildColumnRow() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        columnData[0]['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 231, 57, 57),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        columnData[0]['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 231, 57, 57),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        columnData[0]['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 231, 57, 57),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        columnData[0]['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 231, 57, 57),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        columnData[0]['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 231, 57, 57),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDatatable() {
    return Column(
      children: [buildColumnRow(), buildColumnRow(), buildColumnRow()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
            onTap : ()=> Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: 64.h, color: Colors.white)),
        title: Text(
          "Danh sách lỗi",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight + 120.h),
              Text(
                "Tổng số lỗi: 20",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32.h),
              DropDownButton(),
              DropDownButton(),
              DropDownButton(),
            ],
          ),
        ),
      ),
    );
  }
}
