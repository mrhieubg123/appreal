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

  final dynamic listColor = {
    "RUN": Colors.green,
    "OFF": Colors.yellow,
    "ERROR": Colors.red,
    "NA": Colors.grey,
  };

  final int numberRows = 6;

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

  List<String> columnNames = ["1", "2", "3", "4", "5", "6"];

  Widget buildLight({Color? color, double? radius = 20, onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(radius: radius, backgroundColor: color),
    );
  }

  getMachineFromLineLocation(line, location) {
    return machines.firstWhereOrNull(
      (e) => (e.line == line && e.location == location.toString()),
    );
  }

  getColorFromLineLocation(line, location) {
    MachineStatusModel? result = machines.firstWhereOrNull(
      (e) => (e.line == line && e.location == location.toString()),
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
              fontSize: 40.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(numberRows, (index) {
                return Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 42.sp,
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
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 4.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 32.h),
            buildStatusName(),
            SizedBox(height: 32.h),
            buildColumnName(),
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 16.h),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ...List.generate(3, (indexColumn) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 72.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ...List.generate(
                                          numberRows,
                                          (index) => Flexible(
                                            flex: 1,
                                            child:
                                                getMachineFromLineLocation(
                                                      lineNames[lineIndex],
                                                      index +
                                                          1 +
                                                          indexColumn *
                                                              numberRows,
                                                    ) !=
                                                    null
                                                ? Center(
                                                    child: buildLight(
                                                      radius: 32.r,
                                                      onTap: () =>
                                                          goToMachineDetailScreen(
                                                            getMachineFromLineLocation(
                                                              lineNames[lineIndex],
                                                              index +
                                                                  1 +
                                                                  indexColumn *
                                                                      numberRows,
                                                            ),
                                                          ),
                                                      color:
                                                          getColorFromLineLocation(
                                                            lineNames[lineIndex],
                                                            index +
                                                                1 +
                                                                indexColumn *
                                                                    numberRows,
                                                          ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: double.infinity,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (indexColumn != 2)
                                    Divider(color: Colors.white),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (lineIndex != lineNames.length - 1)
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
            SizedBox(height: 32.h),
          ],
        ),
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
