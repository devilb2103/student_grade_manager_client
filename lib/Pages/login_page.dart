import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grade_manager/Cubit/Auth/auth_cubit.dart';
import 'package:student_grade_manager/Pages/home_page.dart';
import 'package:student_grade_manager/Widgets/login_button.dart';
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
      backgroundColor: Colors.blueGrey[100],
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
              LoginButton(
                  context: context,
                  usernameController: usernameController,
                  passwordController: passwordController),
            ],
          ),
        ),
      )),
    );
  }
}
