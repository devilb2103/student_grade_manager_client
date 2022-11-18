import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_grade_manager/Widgets/username_text_input.dart';
import 'package:student_grade_manager/Widgets/password_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
          child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: Container(
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UsernameTextInput(
                  controller: usernameController, hintText: "Enter username"),
              SizedBox(height: 15),
              PasswordTextInput(
                  controller: passwordController, hintText: "Enter password"),
              SizedBox(height: 15),
              SizedBox(
                height: 51,
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: Container()),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
