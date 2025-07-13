import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/src/screen/machine_status_screen/machine_status_getdata.dart';
import 'package:my_app/src/screen/machine_status_screen/widget/machine_status_table_widget.dart';

import '../../../core/model/machine_status_model.dart';
import '../error_table_screen/error_table_screen.dart';

class MachineStatusApp extends StatefulWidget {
  const MachineStatusApp({super.key});

  @override
  State<MachineStatusApp> createState() => _MachineStatusAppState();
}

class _MachineStatusAppState extends State<MachineStatusApp> {
  ListMachineStatusModel? listMachineStatusModel;
  List<String> listLine = [];
  List<String> listLocation = [];
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    listMachineStatusModel = await MachineStatusGetData().getMachineStatus();
    if (listMachineStatusModel?.data != null) {
      listLine = MachineStatusGetData().getUniqueSortedLines(
        listMachineStatusModel!.data!,
      );
      listLocation = MachineStatusGetData().getUniqueSortedLocations(
        listMachineStatusModel!.data!,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b1c54),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent
      ),
      body: Column(
        children: [
          SizedBox(height: kToolbarHeight + 16.h),
          Text(
            "Machine Status",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
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
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 32.r,
                    backgroundColor: Colors.red,
                    child: Text(
                      '1',
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => ErrorStableScreen()),
    );
  }
}
