import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/model/error_not_confirm_model.dart';
import 'widget/drop_down_button.dart';

class ErrorStableScreen extends StatefulWidget {
  final ListErrorNotConfirmModel listErrorNotConfirmModel;
  final List<String> listLine;
  const ErrorStableScreen({
    super.key,
    required this.listErrorNotConfirmModel,
    required this.listLine,
  });

  @override
  State<ErrorStableScreen> createState() => _ErrorStableScreenState();
}

class _ErrorStableScreenState extends State<ErrorStableScreen> {
  // ListErrorNotConfirmModel? listErrorNotConfirmModelState;
  List<ErrorNotConfirmModel> listErrorNotConfirmFilter = [];
  String selectedValue = "All";

  @override
  void initState() {
    // listErrorNotConfirmModelState = widget.listErrorNotConfirmModel;
    listErrorNotConfirmFilter = widget.listErrorNotConfirmModel.data ?? [];
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

  Widget selectLineWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1), // Viền đen
        borderRadius: BorderRadius.circular(24.r), // Bo góc (tuỳ chọn)
      ),
      child: DropdownButton<String>(
        iconEnabledColor: Colors.white,
        dropdownColor: Colors.blueAccent,
        borderRadius: BorderRadius.circular(24.r),
        style: TextStyle(color: Colors.white, fontSize: 48.sp),
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            if (newValue == "All") {
              listErrorNotConfirmFilter =
                  widget.listErrorNotConfirmModel.data ?? [];
            } else {
              listErrorNotConfirmFilter =
                  (widget.listErrorNotConfirmModel.data ?? [])
                      .where(
                        (e) => (e.lINE ?? "").contains(
                          newValue.replaceAll("_1", ""),
                        ),
                      )
                      .toList();
            }
          });
        },
        items: ["All", ...widget.listLine].map<DropdownMenuItem<String>>((
          String value,
        ) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
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
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: 64.h, color: Colors.white),
        ),
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
        width: double.infinity,
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
              Row(
                children: [
                  Text(
                    "Tổng số lỗi: ${listErrorNotConfirmFilter.length}",
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 32.w),
                  selectLineWidget(),
                ],
              ),
              SizedBox(height: 32.h),
              ...List.generate(listErrorNotConfirmFilter.length, (index) {
                return DropDownButton(
                  errorNotConfirmModel: listErrorNotConfirmFilter[index],
                  onConfirmSuccess: () {
                    setState(() {
                      widget.listErrorNotConfirmModel.data?.removeWhere(
                        (e) => e.iD == listErrorNotConfirmFilter[index].iD,
                      );
                      listErrorNotConfirmFilter.removeAt(index);
                    });
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
