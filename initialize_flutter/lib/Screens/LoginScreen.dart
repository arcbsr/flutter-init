import 'package:flutter/material.dart';
import 'package:insurance_flutter/Screens/BasicAppBar.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  bool isShowAppBar= false;
  LoginPage({required this.isShowAppBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isShowAppBar?null:BasicAppBar(title: "Login"),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: SizedBox(
            height: 50.h,
            width: 80.w,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50.w, 12.w),
                    ),
                    onPressed: () {},
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
