import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/model/error_detail_model.dart';
import '../../../core/model/error_stats_model.dart';
import '../../../core/model/machine_status_model.dart';
import '../../data_mau/constants.dart';
import '../machine_status_screen/machine_status_getdata.dart';
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
  @override
  void initState() {
    getData();
    super.initState();
  }

  double errorPercent = 25; // 25% lỗi
  double otherPercent = 75; // 75% OK

  getData() async {
    if (widget.machine.error_code != null) {
      errorDetailsModel = await MachineStatusGetData().getListErrorDetail(
        errorCode: widget.machine.error_code!,
      );
      errorStatsModel = await MachineStatusGetData().getErrorStatsModel(
        errorCode: widget.machine.error_code!,
      );
      setState(() {
        errorPercent =
            ((errorStatsModel?.errorCodeErrorsLast7Days ?? 0) /
                    ((errorStatsModel?.totalErrorsLast7Days == null ||
                            errorStatsModel?.totalErrorsLast7Days == 0)
                        ? 1
                        : errorStatsModel!.totalErrorsLast7Days!) *
                    100)
                .round()
                .toDouble();
        otherPercent = 100 - errorPercent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin máy móc"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            thongTinMayWidget(),
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
                  ErrorDetailWidget(
                    machines: [],
                    indexFilter: indexFilter,
                    errorDetailsModel: errorDetailsModel,
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
                PieChartSectionData(
                  color: Colors.redAccent,
                  value: errorPercent,
                  title: "${errorPercent}%",
                  radius: 220.r,
                  titleStyle: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: okPercent,
                  title: "${okPercent}%",
                  radius: 220.r,
                  titleStyle: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16.h),
        IndicatorDot(
          color: Colors.redAccent,
          label: "Lỗi ${widget.machine.error_code}",
        ),
        SizedBox(height: 16.h),
        IndicatorDot(color: Colors.green, label: "Lỗi khác"),
      ],
    );
  }

  onChangeIndexFilter(index) {
    setState(() {
      indexFilter = index;
      if (index == 0) {
        errorPercent =
            ((errorStatsModel?.errorCodeErrorsLast7Days ?? 0) /
                    ((errorStatsModel?.totalErrorsLast7Days == null ||
                            errorStatsModel?.totalErrorsLast7Days == 0)
                        ? 1
                        : errorStatsModel!.totalErrorsLast7Days!) *
                    100)
                .round()
                .toDouble();
      } else {
        errorPercent =
            ((errorStatsModel?.errorCodeErrorsLast30Days ?? 0) /
                    ((errorStatsModel?.totalErrorsLast30Days == null ||
                            errorStatsModel?.totalErrorsLast30Days == 0)
                        ? 1
                        : errorStatsModel!.totalErrorsLast30Days!) *
                    100)
                .round()
                .toDouble();
      }
      otherPercent = 100 - errorPercent;
    });
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
        SizedBox(width: 24.w),
        Text(
          label,
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
