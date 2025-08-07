import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/src/screen/machine_status_screen/machine_status_getdata.dart';

import '../../../core/model/machine_status_model.dart';
import '../../../core/model/view_maintennance_model.dart';
import '../../../core/widget/dialog.dart';
import '../../data_mau/constants.dart';

class MaintenanceInformationScreen extends StatefulWidget {
  final MachineStatusModel machine;
  const MaintenanceInformationScreen({super.key, required this.machine});

  @override
  State<MaintenanceInformationScreen> createState() =>
      _MaintenanceInformationScreenState();
}

class _MaintenanceInformationScreenState
    extends State<MaintenanceInformationScreen> {
  int indexFilter = 0;
  ViewMaintenanceModel? viewMaintenanceWeeklyModel;
  ViewMaintenanceModel? viewMaintenanceMonthlyModel;
  ViewMaintenanceModel? viewMaintenanceModel;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    indexFilter = 0;
    viewMaintenanceWeeklyModel = await MachineStatusGetData()
        .getViewMaintenance(
          body: {
            "location": widget.machine.location,
            "line": widget.machine.line,
            "maintenance_type": "WEEKLY",
          },
        );
    viewMaintenanceModel = viewMaintenanceWeeklyModel;
    viewMaintenanceMonthlyModel = await MachineStatusGetData()
        .getViewMaintenance(
          body: {
            "location": widget.machine.location,
            "line": widget.machine.line,
            "maintenance_type": "MONTHLY",
          },
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance Information"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              thongTinMayWidget(),
              SizedBox(height: 32.h),
              selectFilter(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 16.h,
                    ),
                    child: Divider(color: Colors.grey),
                  ),
                  Text(
                    "Maintenance history",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ...List.generate(
                    viewMaintenanceModel?.history?.length ?? 0,
                    (index) =>
                        maintenanceItem(viewMaintenanceModel!.history![index]),
                  ),
                ],
              ),
            ],
          ),
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
          style: TextStyle(
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        itemInfoWidget(
          title: "Weekly maintenance day",
          text: viewMaintenanceWeeklyModel?.history?.firstOrNull?.createdAt
              ?.split(" ")[0],
        ),
        InkWell(
          onTap: () => goToConfirmMaintenance(1),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 12.h, 12.w, 0),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "Confirm Maintenance Weekly",
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),
              ),
              Icon(Icons.info_outline, color: Colors.redAccent),
              Text(
                " Weekly maintenance required",
                style: TextStyle(color: Colors.redAccent, fontSize: 24.sp),
              ),
            ],
          ),
        ),
        itemInfoWidget(
          title: "Monthly maintenance day",
          text: viewMaintenanceMonthlyModel?.history?.firstOrNull?.createdAt
              ?.split(" ")[0],
        ),
        InkWell(
          onTap: () => goToConfirmMaintenance(1),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 12.h, 12.w, 0),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  "Confirm Maintenance Monthly",
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
          Text(
            "$title: ",
            style: TextStyle(fontSize: 40.sp, color: Colors.white),
          ),
          Text(
            "$text",
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  onChangeIndexFilter(index) {
    setState(() {
      indexFilter = index;
      if (index == 0) {
        viewMaintenanceModel = viewMaintenanceWeeklyModel;
      } else {
        viewMaintenanceModel = viewMaintenanceMonthlyModel;
      }
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
              color: indexFilter == 0 ? Colors.blueAccent : Colors.grey,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Text(
              "Weekly",
              style: TextStyle(fontSize: 40.sp, color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        InkWell(
          onTap: () => onChangeIndexFilter(1),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: indexFilter == 1 ? Colors.blueAccent : Colors.grey,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Text(
              "Monthly",
              style: TextStyle(fontSize: 40.sp, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  maintenanceItem(History item) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 32.h),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.orange, // màu viền
            width: 4.w, // độ dày viền
          ),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow(
                    title: "Maintenance day",
                    text: item.createdAt?.split(" ")[0],
                  ),
                  infoRow(
                    title: "Maintenance type",
                    text: item.maintenanceType,
                  ),
                  infoRow(title: "Maintenance content", text: item.content),
                  infoRow(title: "Maintenance spec", text: item.techSpec),
                  infoRow(title: "Maintenance action", text: item.actionTaken),
                  infoRow(title: "Maintenance person", text: item.maintainer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  infoRow({title, text, color}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title:  ',
            style: TextStyle(color: Colors.black, fontSize: 30.sp),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
              color: color ?? Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
            ),
          ),
        ],
      ),
    );
  }

  goToConfirmMaintenance(type) async {
    //   {
    //     "location": "11",
    //   "maintenance_type": "WEEKLY",
    //   "content": "Kiểm tra PLC",
    //   "tech_spec": "Dây mạng oke, đầu mạng sắp hỏng ",
    //   "action_taken": "Thay đầu mạng"
    // }
    Map? bodyData = await showConfirmMaintenanceDialog(type: type);
    if (bodyData == null) return;
    bodyData['location'] = widget.machine.location;
    bodyData['line'] = widget.machine.line;
    final result = await MachineStatusGetData().getAddMaintenance(
      body: bodyData,
    );
    if (result == true) {
      showDialogMessage(message: 'Confirm Maintenance Success');
      initData();
    }
  }
}
