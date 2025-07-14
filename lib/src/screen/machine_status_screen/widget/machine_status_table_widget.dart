import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/main.dart';

import '../../../../core/model/machine_status_model.dart';
import '../../machine_detail_screen/machine_detsail_screen.dart';

class MachineStatusTable extends StatelessWidget {
  MachineStatusTable({
    super.key,
    required this.lineNames,
    required this.machines,
    required this.columnNames,
  });

  // Mock data: trạng thái mỗi line (xanh: chạy, đỏ: lỗi, vàng: dừng, xám: tắt)
  // final List<List<Color>> statusData = const [
  //   [
  //     Colors.yellow,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //     Colors.green,
  //   ],
  // ];

  dynamic listColor = {
    "RUN": Colors.green,
    "WARNING": Colors.yellow,
    "ERROR": Colors.red,
    "NA": Colors.grey,
  };

  List<MachineStatusModel> machines = [];

  List<String> lineNames = [
    "Line_1F",
    "Line_1R",
    "Line_2F",
    "Line_2R",
    "Line_4F",
    "Line_4R",
    "Line_5F",
    "Line_5R",
  ];

  List<String> columnNames = [
    "Prt",
    "H1",
    "H2",
    "H3",
    "H4",
    "H5",
    "H6",
    "G1",
    "G2",
    "Reflow",
  ];

  Widget buildLight({Color? color, double? radius = 10, onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(radius: radius, backgroundColor: color),
    );
  }

  getMachineFromLineLocation(line, location) {
    return machines.firstWhereOrNull(
      (e) => (e.line == line && e.location == location),
    );
  }

  getColorFromLineLocation(line, location) {
    MachineStatusModel? result = machines.firstWhereOrNull(
      (e) => (e.line == line && e.location == location),
    );
    if (result != null) return listColor[result.status];
    return Colors.grey;
  }

  Widget buildColumnName() {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
          child: Text(
            "Line",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(columnNames.length, (lineIndex) {
                return Flexible(
                  flex: lineIndex == columnNames.length - 1 ? 2 : 1,
                  child: Center(
                    child: Text(
                      columnNames[lineIndex],
                      style: TextStyle(
                        color: const Color.fromARGB(255, 231, 57, 57),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  buildStatusName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "",
          style: TextStyle(color: Colors.white, fontSize: 40.sp),
        ),
        Row(
          children: [
            buildLight(color: Colors.green, radius: 16.r),
            Text(
              " Run   ",
              style: TextStyle(color: Colors.white, fontSize: 32.sp),
            ),
            buildLight(color: Colors.yellow, radius: 16.r),
            Text(
              " Stop   ",
              style: TextStyle(color: Colors.white, fontSize: 32.sp),
            ),
            buildLight(color: Colors.red, radius: 16.r),
            Text(
              " Error   ",
              style: TextStyle(color: Colors.white, fontSize: 32.sp),
            ),
            buildLight(color: Colors.grey, radius: 16.r),
            Text(
              " N/A   ",
              style: TextStyle(color: Colors.white, fontSize: 32.sp),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xff1b1c54)),
      child: Column(
        children: [
          SizedBox(height: 32.h),
          buildStatusName(),
          SizedBox(height: 32.h),
          buildColumnName(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
            child: Divider(color: Colors.grey),
          ),
          ...List.generate(lineNames.length, (lineIndex) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Text(
                        lineNames[lineIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24.sp),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            columnNames.length,
                            (index) => Flexible(
                              flex: index == columnNames.length - 1 ? 2 : 1,
                              child:
                                  getMachineFromLineLocation(
                                        lineNames[lineIndex],
                                        columnNames[index],
                                      ) !=
                                      null
                                  ? Center(
                                      child: buildLight(
                                        radius: 16.r,
                                        onTap: () => goToMachineDetailScreen(
                                          getMachineFromLineLocation(
                                            lineNames[lineIndex],
                                            columnNames[index],
                                          ),
                                        ),
                                        color: getColorFromLineLocation(
                                          lineNames[lineIndex],
                                          columnNames[index],
                                        ),
                                      ),
                                    )
                                  : SizedBox(width: double.infinity),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 16.h,
                  ),
                  child: Divider(color: Colors.grey),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  goToMachineDetailScreen(machine) {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            MachineDetailScreen(machine: machine),
      ),
    );
  }
}
