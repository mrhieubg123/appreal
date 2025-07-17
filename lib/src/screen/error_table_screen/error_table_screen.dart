import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/error_detail_model.dart';
import '../../../core/model/error_not_confirm_model.dart';
import 'widget/drop_down_button.dart';

class ErrorStableScreen extends StatefulWidget {
  final ListErrorNotConfirmModel listErrorNotConfirmModel;
  const ErrorStableScreen({super.key, required this.listErrorNotConfirmModel});

  @override
  State<ErrorStableScreen> createState() => _ErrorStableScreenState();
}

class _ErrorStableScreenState extends State<ErrorStableScreen> {
  ListErrorNotConfirmModel? listErrorNotConfirmModelState;

  @override
  void initState() {
    listErrorNotConfirmModelState = widget.listErrorNotConfirmModel;
    super.initState();
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
              Text(
                "Tổng số lỗi: ${listErrorNotConfirmModelState?.data?.length ?? 0}",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32.h),
              ...List.generate(
                listErrorNotConfirmModelState?.data?.length ?? 0,
                (index) {
                  return DropDownButton(
                    errorNotConfirmModel:
                        listErrorNotConfirmModelState!.data![index],
                    onConfirmSuccess: () {
                      setState(() {
                        widget.listErrorNotConfirmModel.data?.removeAt(index);
                        listErrorNotConfirmModelState =
                            widget.listErrorNotConfirmModel;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
