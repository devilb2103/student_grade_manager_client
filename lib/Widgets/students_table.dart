import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grade_manager/Cubit/StudentData/student_data_cubit.dart';
import 'package:student_grade_manager/network_vars.dart';

class StudentTable extends StatefulWidget {
  const StudentTable({super.key});

  @override
  State<StudentTable> createState() => _StudentTableState();
}

class _StudentTableState extends State<StudentTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Container(
          color: Colors.blueGrey[200],
          child: Column(children: [
            //header
            TableHeader(),
            ScrollableDataContainer(),
          ]),
        ),
      ),
    );
  }
}

class ScrollableDataContainer extends StatelessWidget {
  const ScrollableDataContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocConsumer<StudentDataCubit, StudentDataState>(
      listener: (context, state) {
        if (state is StudentDataErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red[300], content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is StudentDataProcessingState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 9),
            child: Container(
              child: ListView.builder(
                itemCount: Data.length,
                itemBuilder: (context, index) {
                  return TableItem(
                    index: int.parse(Data.keys.elementAt(index)),
                    name: Data[Data.keys.elementAt(index)]["name"],
                    marks1: Data[Data.keys.elementAt(index)]["grades"][0],
                    marks2: Data[Data.keys.elementAt(index)]["grades"][1],
                    marks3: Data[Data.keys.elementAt(index)]["grades"][2],
                    average:
                        Data[Data.keys.elementAt(index)]["average"].toString(),
                  );
                },
              ),
              color: Colors.transparent,
            ),
          );
        }
      },
    ));
  }
}

class TableItem extends StatelessWidget {
  final int index;
  final String name;
  final int marks1;
  final int marks2;
  final int marks3;
  final String average;
  const TableItem({
    super.key,
    required this.index,
    required this.name,
    required this.marks1,
    required this.marks2,
    required this.marks3,
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Container(
          height: 39,
          color: Colors.transparent,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    color: Colors.blueGrey[300],
                    child: Center(
                        child: Text(
                      index.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: Center(
                          child: Text(
                        name.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: Center(
                          child: Text(
                        marks1.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: Center(
                          child: Text(
                        marks2.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: Center(
                          child: Text(
                        marks3.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: Center(
                          child: Text(
                        average.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Container(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {},
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 1,
                            disabledElevation: 0,
                            backgroundColor: Colors.blueGrey[300],
                            child: const Icon(Icons.edit),
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 1,
                            disabledElevation: 0,
                            backgroundColor: Colors.blueGrey[300],
                            child: const Icon(Icons.delete),
                          ),
                        ],
                      )),
                ),
              )
            ],
          )),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
          height: 45,
          color: Colors.transparent,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    color: Colors.blueGrey[300],
                    child: const Center(
                        child: Text(
                      "ID",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: const Center(
                          child: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: const Center(
                          child: Text(
                        "Marks 1",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: const Center(
                          child: Text(
                        "Marks 2",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: const Center(
                          child: Text(
                        "Marks 3",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.blueGrey[300],
                      child: const Center(
                          child: Text(
                        "Average",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              Container(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.transparent,
                      child: Row(children: [
                        FloatingActionButton(
                          onPressed: () {},
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 1,
                          disabledElevation: 0,
                          backgroundColor: Colors.blueGrey[300],
                          child: const Icon(Icons.add),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            context.read<StudentDataCubit>().refreshData();
                          },
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 1,
                          disabledElevation: 0,
                          backgroundColor: Colors.blueGrey[300],
                          child: const Icon(Icons.refresh),
                        ),
                      ])),
                ),
              )
            ],
          )),
    );
  }
}
