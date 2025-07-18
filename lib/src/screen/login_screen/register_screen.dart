import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/src/screen/machine_status_screen/machine_status_getdata.dart';

import '../../../core/widget/dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  Future _handleLogin() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String rePassword = _rePasswordController.text.trim();
    if (name.isEmpty) {
      showDialogMessage(message: "Vui lòng nhập tên");
      return;
    } else if (email.isEmpty) {
      showDialogMessage(message: "Vui lòng nhập mã nhân viên");
      return;
    } else if (password.isEmpty) {
      showDialogMessage(message: "Vui lòng nhập mật khẩu");
      return;
    } else if (rePassword.isEmpty) {
      showDialogMessage(message: "Vui lòng nhập lại mật khẩu");
      return;
    } else if (rePassword != password) {
      showDialogMessage(message: "Mật khẩu nhập lại không đúng");
      return;
    }

    print('Email: $email');
    print('Mật khẩu: $password');
    dynamic result = await MachineStatusGetData().registerUser(
      name: name,
      cardId: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 160.h, color: Colors.blue),
                SizedBox(height: 32.h),
                Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 64.h),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tên nhân viên',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Mã nhân viên',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Nhập mật khẩu',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: _rePasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 48.h),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: Size(double.infinity, 96.h),
                  ),
                  child: Text('Đăng ký'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
