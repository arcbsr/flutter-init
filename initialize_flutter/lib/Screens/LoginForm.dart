import 'package:flutter/material.dart';
import 'package:insurance_flutter/services/AuthService.dart';

import '../Utils/Validator.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _isLoading = false;

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    // Perform login logic here

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailTextController,
            // focusNode: _focusEmail,
            //validator: (value) => Validator.validateEmail(email: value),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: _passwordTextController,
            // focusNode: _focusPassword,
            obscureText: true,
            //validator: (value) => Validator.validatePassword(password: value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user = await AuthService().login(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );
                      if (user != null) {
                        // Navigator.of(context)
                        //     .pushReplacement(
                        //   MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                        // );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(user),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => RegisterPage()),
                    // );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}