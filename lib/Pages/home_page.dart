import 'package:flutter/material.dart';
import 'package:student_grade_manager/Widgets/side_bar.dart';
import 'package:student_grade_manager/Widgets/students_table.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.blueGrey[600],
            height: double.maxFinite,
            width: 60,
            child: const SideBar(),
          ),
          Expanded(
              child: Container(
            color: Colors.blueGrey[50],
            child: const StudentTable(),
          )),
        ],
      )),
    );
  }
}
