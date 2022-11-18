import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:student_grade_manager/Cubit/Auth/auth_cubit.dart';
import 'package:student_grade_manager/network_vars.dart';

part 'student_data_state.dart';

class StudentDataCubit extends Cubit<StudentDataState> {
  StudentDataCubit() : super(StudentDataInitial());
  bool _canTriggerActions = true;

  Future refreshData() async {
    if (!_canTriggerActions) return;
    _canTriggerActions = false;

    // logic
    emit(const StudentDataProcessingState());
    try {
      var res = await Dio().get('$address/get/students');
      if (res.statusCode == 200) {
        var jsonRes = res.data;
        if (jsonRes["status"] == 400) {
          emit(StudentDataErrorState(jsonRes["message"].toString()));
        } else {
          Data = jsonRes["message"];
          print(Data[Data.keys.elementAt(0)]["average"]);
        }
      } else {
        emit(StudentDataErrorState(
            "Server returned an error with status code ${res.statusCode}"));
      }
      emit(const StudentDataInitial());
    } on DioError catch (e) {
      emit(StudentDataErrorState(e.error.toString()));
      emit(const StudentDataInitial());
    }
    // logic

    _canTriggerActions = true;
  }
}
