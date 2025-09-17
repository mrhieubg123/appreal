import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/model/dashboard_error_model.dart';
import '../../../core/model/error_detail_model.dart';
import '../../../core/model/error_detail_total_model.dart';
import '../../../core/model/error_stats_model.dart';
import '../../../core/model/machine_status_model.dart';
import '../../data_mau/constants.dart';
import '../machine_status_screen/machine_status_getdata.dart';
import '../maintenance_information_screen/maintenance_information_screen.dart';
import 'widget/error_detail_widget.dart';

class MachineDetailScreen extends StatefulWidget {
  final MachineStatusModel machine;
  const MachineDetailScreen({super.key, required this.machine});

  @override
  State<MachineDetailScreen> createState() => _MachineDetailScreenState();
}

class _MachineDetailScreenState extends State<MachineDetailScreen> {
  int indexFilter = 0;
  ErrorDetailsModel? errorDetailsModel;
  ErrorStatsModel? errorStatsModel;
  DashboardErrorModel? dashboardErrorModel;
  ErrorDetailTotalModel? errorDetailTotalModel;
  @override
  void initState() {
    getData();
    super.initState();
    // 🔒 Khoá hướng dọc
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // 🔓 Reset lại cho phép xoay mọi hướng (hoặc hướng bạn muốn)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  List listStringRange = ["7day", "month"];
  List listColorError = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.yellow,
    Colors.blueGrey,
    Colors.black,
  ];
  List? listPercentError = [];

  double errorPercent = 25; // 25% lỗi
  double otherPercent = 75; // 75% OK

  getData() async {
    dashboardErrorModel = await MachineStatusGetData().getDashboardError(
      body: {
        "line": widget.machine.line,
        "location": widget.machine.location,
        "machine_type": widget.machine.machineType,
        "machine_name": widget.machine.machineName,
        "range": listStringRange[indexFilter],
      },
    );
    dashboardErrorModel?.data?.sort(
      (a, b) => (b.count ?? 0).compareTo(a.count ?? 0),
    );
    listPercentError = dashboardErrorModel?.data
        ?.map((e) => (e.percentage ?? 0).round())
        .toList();
    if (widget.machine.status == "ERROR") {
      errorDetailTotalModel = await MachineStatusGetData().getErrorDetail(
        body: {
          "line": widget.machine.line,
          "location": widget.machine.location,
          "machine_type": widget.machine.machineType,
          "machine_name": widget.machine.machineName,
          "error_code": widget.machine.error_code,
        },
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Machine Information"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            thongTinMayWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.machine.status == "ERROR")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Mã lỗi : ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: widget.machine.error_code,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Tên lỗi : ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: errorDetailsModel?.error,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 32.h),
                selectFilter(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 16.h,
                  ),
                  child: Divider(color: Colors.grey),
                ),
                Text(
                  "Thống kê lỗi:",
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 24.h),
                bieuDoWidget(errorPercent, otherPercent),
                if (widget.machine.status == "ERROR")
                  ErrorDetailWidget(
                    machines: [],
                    indexFilter: indexFilter,
                    errorDetailsModel: errorDetailTotalModel,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  thongTinMayWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Thông tin máy
        Text(
          widget.machine.machineName ?? "",
          style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Constants
                  .statusMachine[widget.machine.status ?? "NA"]["color"],
              size: 32.sp,
            ),
            SizedBox(width: 8.w),
            Text("Trạng thái: ", style: TextStyle(fontSize: 40.sp)),
            Text(
              Constants.statusMachine[widget.machine.status ?? "NA"]["name"] ??
                  "",
              style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        itemInfoWidget(title: "LINE", text: widget.machine.line ?? ""),
        itemInfoWidget(title: "LOCATION", text: widget.machine.location ?? ""),
        InkWell(
          onTap: () => goToInfoMaintenanceScreen(),
          child: Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 12.h, 12.w, 0),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "Maintenance information",
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          height: 400.h,
          width: double.infinity,
          child: Image.asset(
            'assets/images/machine_image.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  itemInfoWidget({String? title, String? text}) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          Text("$title: ", style: TextStyle(fontSize: 40.sp)),
          Text(
            "$text",
            style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  bieuDoWidget(errorPercent, okPercent) {
    return Column(
      children: [
        // ✅ Biểu đồ tròn
        SizedBox(
          height: 600.h,
          child: PieChart(
            PieChartData(
              sectionsSpace: 8.h,
              centerSpaceRadius: 60.r,
              sections: [
                ...List.generate(
                  listPercentError?.length ?? 0,
                  (index) => PieChartSectionData(
                    color: listColorError[index % listColorError.length],
                    value: listPercentError![index].toDouble(),
                    title: listPercentError![index].toDouble() > 7
                        ? "${listPercentError![index]}%\n(${dashboardErrorModel?.data![index].count}m)"
                        : "",
                    radius: 220.r,
                    titleStyle: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Wrap(
          children: [
            ...List.generate(
              listPercentError?.length ?? 0,
              (index) => SizedBox(
                width: 1.sw / 3 - 40.w,
                child: IndicatorDot(
                  color: listColorError[index % listColorError.length],
                  label: "Lỗi ${dashboardErrorModel?.data?[index].errorCode}",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  onChangeIndexFilter(index) {
    setState(() {
      indexFilter = index;
    });
    getData();
  }

  selectFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => onChangeIndexFilter(0),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: indexFilter == 0 ? Colors.blueAccent : Colors.grey,
                width: indexFilter == 0 ? 8.w : 4.w,
              ),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Text("7 ngày", style: TextStyle(fontSize: 40.sp)),
          ),
        ),
        SizedBox(width: 16.w),
        InkWell(
          onTap: () => onChangeIndexFilter(1),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: indexFilter == 1 ? Colors.blueAccent : Colors.grey,
                width: indexFilter == 1 ? 8.w : 4.w,
              ),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Text("30 ngày", style: TextStyle(fontSize: 40.sp)),
          ),
        ),
      ],
    );
  }

  goToInfoMaintenanceScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            MaintenanceInformationScreen(machine: widget.machine),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final Color color;
  final String label;

  const IndicatorDot({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
