import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_grade_manager/Cubit/StudentData/student_data_cubit.dart';
import 'package:student_grade_manager/Widgets/custom_text_field.dart';

class EditMarksBottomsheet extends StatefulWidget {
  final String id;
  final String? marks1;
  final String? marks2;
  final String? marks3;
  const EditMarksBottomsheet(
      {super.key, required this.id, this.marks1, this.marks2, this.marks3});

  @override
  State<EditMarksBottomsheet> createState() => _EditMarksBottomsheetState();
}

class _EditMarksBottomsheetState extends State<EditMarksBottomsheet> {
  final TextEditingController marks1 = TextEditingController();
  final TextEditingController marks2 = TextEditingController();
  final TextEditingController marks3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: Container(
        color: Colors.blueGrey[50],
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, right: 21, left: 21, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomSheetBody(widget.id, marks1, marks2, marks3),
              SizedBox(width: 300, height: 60, child: confirmButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetBody(String id, TextEditingController marks1,
      TextEditingController marks2, TextEditingController marks3) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SingleChildScrollView(
          // child: Expanded(
          // color: Colors.green,
          // height: 100,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Text("Edit Marks",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w300)),
            const Divider(),
            const SizedBox(height: 9),
            Text(
              'ID: $id',
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: CustomTextField(
                      controller: marks1,
                      hintText: "Marks 1",
                      initialValue: widget.marks1.toString()),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 130,
                  child: CustomTextField(
                      controller: marks2,
                      hintText: "Marks 2",
                      initialValue: widget.marks2.toString()),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 130,
                  child: CustomTextField(
                      controller: marks3,
                      hintText: "Marks 3",
                      initialValue: widget.marks3.toString()),
                ),
              ],
            )
          ]),
        ),
      ),
      // ),
    );
  }

  Widget confirmButton() {
    void clearControllers() {
      marks1.clear();
      marks2.clear();
      marks3.clear();
    }

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        onPressed: () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          await context.read<StudentDataCubit>().editMarks(widget.id,
              marks1.text.trim(), marks2.text.trim(), marks3.text.trim());
          clearControllers();
          try {
            Navigator.pop(context);
          } catch (e) {}
        },
        child: BlocConsumer<StudentDataCubit, StudentDataState>(
          listener: (context, state) {
            if (state is StudentDataErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red[300],
              ));
            }
          },
          builder: (context, state) {
            if (state is StudentDataProcessingState) {
              return const CircularProgressIndicator();
            } else {
              return const Text("Confirm");
            }
          },
        ));
  }
}
