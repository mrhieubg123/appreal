import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/model/error_detail_model.dart';
import '../../../../core/model/error_not_confirm_model.dart';
import '../../../../core/widget/dialog.dart';
import '../../../../main.dart';
import '../../machine_status_screen/machine_status_getdata.dart';

class DropDownButton extends StatefulWidget {
  final ErrorNotConfirmModel errorNotConfirmModel;
  Function? onConfirmSuccess;
  DropDownButton({
    super.key,
    required this.errorNotConfirmModel,
    this.onConfirmSuccess,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  bool isOpen = false;
  ErrorDetailsModel? errorDetailsModel;
  ListCause? nguyenNhan;
  ListSolution? giaiPhap;

  onOpenDropDown() async {
    errorDetailsModel ??= await MachineStatusGetData().getListErrorDetail(
      errorCode: widget.errorNotConfirmModel.eRRORCODE!,
    );
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 32.h),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onOpenDropDown,
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
                          title: "Machine name",
                          text: widget.errorNotConfirmModel.mACHINENAME,
                        ),
                        infoRow(
                          title: "Line",
                          text: widget.errorNotConfirmModel.lINE,
                        ),
                        infoRow(
                          title: "Location",
                          text: widget.errorNotConfirmModel.lOCATION,
                        ),
                        infoRow(
                          title: "Error code",
                          text: widget.errorNotConfirmModel.eRRORCODE,
                          color: Colors.redAccent,
                        ),
                        infoRow(
                          title: "Error name",
                          text: widget.errorNotConfirmModel.eRRORTYPE,
                          color: Colors.redAccent,
                        ),
                        infoRow(
                          title: "Start time",
                          text: widget.errorNotConfirmModel.sTARTTIME,
                        ),
                        infoRow(
                          title: "End time",
                          text: widget.errorNotConfirmModel.eNDTIME,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 4.w),
                    ),
                    child: Icon(
                      isOpen
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 64.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOpen)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // InkWell(
                  //   onTap: onTapAddGiaiPhap,
                  //   child: Container(
                  //     margin: EdgeInsets.fromLTRB(0, 32.h, 0, 0),
                  //     padding: EdgeInsets.symmetric(
                  //       vertical: 12.h,
                  //       horizontal: 16.w,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(color: Colors.blueAccent),
                  //       borderRadius: BorderRadius.circular(18.r),
                  //     ),
                  //     child: Text(
                  //       "Thêm nguyên nhân, giải pháp +",
                  //       style: TextStyle(
                  //         fontSize: 30.sp,
                  //         color: Colors.blueAccent,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 16.h),
                  Text(
                    "Chọn nguyên nhân",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => onTapNguyenNhan(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              nguyenNhan?.cause ?? "--Chọn nguyên nhân--",
                              style: TextStyle(
                                fontSize: 36.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            isOpen
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            size: 32.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Chọn giải pháp",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => onTapGiaiPhap(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              giaiPhap?.solution ?? "--Chọn giải pháp--",
                              style: TextStyle(
                                fontSize: 36.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            isOpen
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            size: 32.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onTapConfirm,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 32.h, 0, 0),
                      padding: EdgeInsets.symmetric(
                        vertical: 24.h,
                        horizontal: 32.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  List dsNguyenNhan = [
    "nguyen nhan 1",
    "nguyen nhan 2",
    "nguyen nhan 3",
    "nguyen nhan 4",
  ];
  List dsGiaiPhap = [
    "Giai phap 1",
    "Giai phap 2",
    "Giai phap 3",
    "Giai phap 4",
  ];

  infoRow({title, text, color}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title:  ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 36.sp,
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
              color: color ?? Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
            ),
          ),
        ],
      ),
    );
  }

  onTapNguyenNhan(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      elevation: 0,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chọn nguyên nhân",
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Đóng",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                ...List.generate(
                  errorDetailsModel?.listCause?.length ?? 0,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        nguyenNhan = errorDetailsModel!.listCause![index];
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          errorDetailsModel!.listCause![index].cause!,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onTapGiaiPhap(context) {
    if (nguyenNhan == null) {
      showDialogMessage(message: "Vui lòng chọn nguyên nhân");
      return;
    }
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      elevation: 0,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chọn giải pháp",
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Đóng",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: onTapAddGiaiPhap,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 32.h, 0, 0),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Text(
                      "Thêm giải pháp +",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                ...List.generate(
                  nguyenNhan?.listSolution?.length ?? 0,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        giaiPhap = nguyenNhan?.listSolution?[index];
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          nguyenNhan?.listSolution?[index].solution ?? "",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onTapConfirm() async {
    if (nguyenNhan == null) {
      showDialogMessage(message: "Vui lòng chọn nguyên nhân");
      return;
    }
    if (giaiPhap == null) {
      showDialogMessage(message: "Vui lòng chọn giải pháp");
      return;
    }
    dynamic result = await MachineStatusGetData().createConfirmData(
      errorCode: widget.errorNotConfirmModel.eRRORCODE!,
      idCause: nguyenNhan!.idCause!,
      idSolution: giaiPhap?.idSolution,
      textSolution: giaiPhap?.solution,
      userId: MachineStatusGetData.userId,
      idErrorConfirm: widget.errorNotConfirmModel.iD!,
    );
    if (result != null) {
      isOpen = false;
      errorDetailsModel = null;
      giaiPhap = null;
      nguyenNhan = null;
      widget.onConfirmSuccess!();
    }
  }

  onTapAddGiaiPhap() async {
    Navigator.pop(navigatorKey.currentContext!);
    final result = await showTextInputDialog();
    if (result != null && result != "") {
      setState(() {
        giaiPhap = ListSolution(solution: result);
        nguyenNhan?.listSolution?.add(giaiPhap!);
      });
      showDialogMessage(message: "Thêm giải pháp thành công");
    }
  }
}
