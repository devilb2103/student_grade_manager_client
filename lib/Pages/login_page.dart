import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grade_manager/Cubit/Auth/auth_cubit.dart';
import 'package:student_grade_manager/Pages/home_page.dart';
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
                    onPressed: () {
                      context.read<AuthCubit>().signIn(
                          usernameController.text.trim().toString(),
                          passwordController.text.trim().toString());
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is SignedInState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          usernameController.clear();
                          passwordController.clear();
                        } else if (state is SignInErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red[300],
                              content: Text(state.message)));
                        }
                      },
                      builder: (context, state) {
                        if (state is ProcessingState) {
                          return CircularProgressIndicator();
                        } else {
                          return const Text("Sign In");
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
