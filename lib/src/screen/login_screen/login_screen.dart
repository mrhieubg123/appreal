import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/main.dart';
import 'package:my_app/src/screen/machine_status_screen/machine_status_getdata.dart';

import '../machine_status_screen/machine_status_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    print('Email: $email');
    print('Mật khẩu: $password');
    dynamic result = await MachineStatusGetData().loginUser(email, password);
    if (result == true) {
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) => MachineStatusApp(),
        ),
      );
    }
  }

  goToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 64.h),
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
                    labelText: 'Mật khẩu',
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
                  child: Text('Đăng nhập'),
                ),
                SizedBox(height: 48.h),
                InkWell(
                  onTap: goToRegisterScreen,
                  child: Text(
                    "Đăng ký tài khoản",
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: Colors.blueAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
