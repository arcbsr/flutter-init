import 'package:flutter/material.dart';
import 'package:insurance_flutter/Screens/BasicAppBar.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  bool isShowAppBar = false;
  LoginPage({super.key, required this.isShowAppBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isShowAppBar ? null : const BasicAppBar(title: "Login"),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: SizedBox(
            height: 100.h,
            width: 70.w,
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {},
                    child: const Text("Login"),
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
