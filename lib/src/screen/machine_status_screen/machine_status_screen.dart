import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/widget/dialog.dart';
import 'package:my_app/src/screen/machine_status_screen/machine_status_getdata.dart';
import 'package:my_app/src/screen/machine_status_screen/widget/machine_status_table_widget.dart';
import '../../../core/model/error_not_confirm_model.dart';
import '../../../core/model/machine_status_model.dart';
import '../error_table_screen/error_table_screen.dart';

class MachineStatusApp extends StatefulWidget {
  const MachineStatusApp({super.key});

  @override
  State<MachineStatusApp> createState() => _MachineStatusAppState();
}

class _MachineStatusAppState extends State<MachineStatusApp> {
  ListMachineStatusModel? listMachineStatusModel;
  ListErrorNotConfirmModel? listErrorNotConfirmModel;
  List<String> listLine = [];
  List<String> listLocation = [];
  Timer? _timer;
  @override
  void initState() {
    startPollingData();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future initData() async {
    listMachineStatusModel = await MachineStatusGetData().getMachineStatus();
    if (listMachineStatusModel?.data != null) {
      listLine = MachineStatusGetData().getUniqueSortedLines(
        listMachineStatusModel!.data!,
      );
      listLocation = MachineStatusGetData().getUniqueSortedLocations(
        listMachineStatusModel!.data!,
      );
    }
    listErrorNotConfirmModel = await MachineStatusGetData().getListConfirm();
    setState(() {});
  }

  startPollingData() async {
    await initData();
    debugPrint("🕒 Gọi data lần đầu:");
    // Đặt hẹn giờ gọi lại mỗi 5 phút
    _timer = Timer.periodic(Duration(seconds: 20), (Timer t) async {
      await initData();
      debugPrint("🕒 Cập nhật mỗi 5 phút:");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b1c54),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: 64.h, color: Colors.white),
        ),
        title: Text(
          "Machine Status",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: kToolbarHeight + 100.h),
          Expanded(
            child: MachineStatusTable(
              lineNames: listLine,
              columnNames: listLocation,
              machines: listMachineStatusModel?.data ?? [],
            ),
          ),
          InkWell(
            onTap: () => goToErrorTableScreen(context),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 32.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white, fontSize: 48.sp),
                  ),
                ),
                if (listErrorNotConfirmModel?.count != null &&
                    listErrorNotConfirmModel?.count != 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 32.r,
                      backgroundColor: Colors.red,
                      child: Text(
                        (listErrorNotConfirmModel?.count ?? 0).toString(),
                        style: TextStyle(fontSize: 32.sp, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  goToErrorTableScreen(context) {
    if (listErrorNotConfirmModel?.count == null ||
        listErrorNotConfirmModel?.count == 0) {
      showDialogMessage(message: "Không có lỗi nào cần xác nhận");
    }
    if (listErrorNotConfirmModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ErrorStableScreen(
            listErrorNotConfirmModel: listErrorNotConfirmModel!,
          ),
        ),
      );
    }
  }
}
