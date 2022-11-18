import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/Auth/auth_cubit.dart';
import '../Pages/home_page.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final BuildContext context;
  const LoginButton(
      {super.key,
      required this.usernameController,
      required this.passwordController,
      required this.context});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      width: double.maxFinite,
      child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            context.read<AuthCubit>().signIn(
                widget.usernameController.text.trim().toString(),
                widget.passwordController.text.trim().toString());
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                widget.usernameController.clear();
                widget.passwordController.clear();
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
    );
  }
}
