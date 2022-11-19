import 'package:flutter/material.dart';
import 'package:student_grade_manager/Pages/login_page.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: const [MaterialPage(child: LoginPage())],
      onPopPage: (route, result) {
        return route.didPop(result);
      },
    );
  }
}
