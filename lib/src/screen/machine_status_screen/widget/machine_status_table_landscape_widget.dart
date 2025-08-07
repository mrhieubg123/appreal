import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/main.dart';
import '../../../../core/model/machine_status_model.dart';
import '../../machine_detail_screen/machine_detsail_screen.dart';

class MachineStatusTableLandscapeWidget extends StatelessWidget {
  MachineStatusTableLandscapeWidget({
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

  final int numberColumns = 10;
  final int numberRowsPerLine = 2;

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

  Widget buildLight({Color? color, double? radius, onTap}) {
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

  double widthNameLine = 48.w;

  Widget buildColumnName() {
    return Row(
      children: [
        SizedBox(
          width: widthNameLine,
          child: Text(
            "Line",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(numberColumns, (index) {
                return Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.sp,
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


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Color(0xff1b1c54),
        border: Border.all(color: Colors.white, width: 4.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 32.h),
            buildColumnName(),
            Padding(
              padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 16.h),
              child: Divider(color: Colors.grey),
            ),
            ...List.generate(lineNames.length, (lineIndex) {
              return Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: widthNameLine,
                        child: Text(
                          lineNames[lineIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ...List.generate(numberRowsPerLine, (indexColumn) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 100.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ...List.generate(
                                          numberColumns,
                                          (index) => Flexible(
                                            flex: 1,
                                            child:
                                                getMachineFromLineLocation(
                                                      lineNames[lineIndex],
                                                      index +
                                                          1 +
                                                          indexColumn *
                                                              numberColumns,
                                                    ) !=
                                                    null
                                                ? Center(
                                                    child: buildLight(
                                                      radius: 72.r,
                                                      onTap: () =>
                                                          goToMachineDetailScreen(
                                                            getMachineFromLineLocation(
                                                              lineNames[lineIndex],
                                                              index +
                                                                  1 +
                                                                  indexColumn *
                                                                      numberColumns,
                                                            ),
                                                          ),
                                                      color:
                                                          getColorFromLineLocation(
                                                            lineNames[lineIndex],
                                                            index +
                                                                1 +
                                                                indexColumn *
                                                                    numberColumns,
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
                                  if (indexColumn != numberRowsPerLine-1)
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
