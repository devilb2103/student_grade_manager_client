import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grade_manager/Cubit/StudentData/student_data_cubit.dart';
import 'package:student_grade_manager/Widgets/add_student_bottom_sheet.dart';
import 'package:student_grade_manager/Widgets/edit_marks_bottom_sheet.dart';
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
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Container(
          color: Colors.blueGrey[200],
          child: Column(children: const [
            //header
            TableHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Divider(),
            ),
            ScrollableDataContainer(),
          ]),
        ),
      ),
    );
  }
}

class ScrollableDataContainer extends StatefulWidget {
  const ScrollableDataContainer({
    super.key,
  });

  @override
  State<ScrollableDataContainer> createState() =>
      _ScrollableDataContainerState();
}

class _ScrollableDataContainerState extends State<ScrollableDataContainer> {
  @override
  void initState() {
    super.initState();
    context.read<StudentDataCubit>().refreshData();
  }

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
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 9),
            child: Container(
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return TableItem(
                    index: int.parse(data.keys.elementAt(index)),
                    name: data[data.keys.elementAt(index)]["name"],
                    marks1: data[data.keys.elementAt(index)]["grades"][0],
                    marks2: data[data.keys.elementAt(index)]["grades"][1],
                    marks3: data[data.keys.elementAt(index)]["grades"][2],
                    average:
                        data[data.keys.elementAt(index)]["average"].toString(),
                  );
                },
              ),
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
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ))),
                ),
              ),
              SizedBox(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              showModalBottomSheet(
                                  context: context,
                                  enableDrag:
                                      true, // <----------- value to change when state changes
                                  isDismissible:
                                      true, // <----------- value to change when state changes
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return EditMarksBottomsheet(
                                      id: index.toString(),
                                      marks1: marks1.toString(),
                                      marks2: marks2.toString(),
                                      marks3: marks3.toString(),
                                    );
                                  });
                            },
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 1,
                            disabledElevation: 0,
                            backgroundColor: Colors.blueGrey[300],
                            child: const Icon(Icons.edit),
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              await context
                                  .read<StudentDataCubit>()
                                  .deleteStudent(int.parse(index.toString()));
                            },
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
              SizedBox(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                      color: Colors.transparent,
                      child: Row(children: [
                        FloatingActionButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            showModalBottomSheet(
                                context: context,
                                enableDrag:
                                    true, // <----------- value to change when state changes
                                isDismissible:
                                    true, // <----------- value to change when state changes
                                isScrollControlled: true,
                                builder: (context) {
                                  return const AddStudentBottomSheet();
                                });
                          },
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 1,
                          disabledElevation: 0,
                          backgroundColor: Colors.blueGrey[300],
                          child: const Icon(Icons.add),
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            await context
                                .read<StudentDataCubit>()
                                .refreshData();
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
