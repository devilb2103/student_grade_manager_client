import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:student_grade_manager/network_vars.dart';

part 'student_data_state.dart';

class StudentDataCubit extends Cubit<StudentDataState> {
  StudentDataCubit() : super(const StudentDataInitial());
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
          data = jsonRes["message"];
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

  Future deleteStudent(id) async {
    if (!_canTriggerActions) return;
    _canTriggerActions = false;

    // logic
    emit(const StudentDataProcessingState());
    try {
      var res = await Dio().delete('$address/delete/student', data: {"id": id});
      if (res.statusCode == 200) {
        var jsonRes = res.data;
        if (jsonRes["status"] == 400) {
          emit(StudentDataErrorState(jsonRes["message"].toString()));
        } else {
          _canTriggerActions = true;
          await refreshData();
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

  Future addStudent(name, marks1, marks2, marks3) async {
    if (!_canTriggerActions) return;
    _canTriggerActions = false;

    // logic
    emit(const StudentDataProcessingState());
    if (name.toString() == "" ||
        marks1 == "" ||
        marks2 == "" ||
        marks3 == "" ||
        !RegExp(r'^[0-9]+$').hasMatch(marks1) ||
        !RegExp(r'^[0-9]+$').hasMatch(marks2) ||
        !RegExp(r'^[0-9]+$').hasMatch(marks3) ||
        int.parse(marks1) < 0 ||
        int.parse(marks2) < 0 ||
        int.parse(marks3) < 0 ||
        int.parse(marks1) > 100 ||
        int.parse(marks2) > 100 ||
        int.parse(marks3) > 100) {
      emit(const StudentDataErrorState("Please enter valid entries only"));
      emit(const StudentDataInitial());
      _canTriggerActions = true;
      return;
    }
    try {
      var res = await Dio().post('$address/create/students', data: {
        "name": name.toString(),
        "grades": [int.parse(marks1), int.parse(marks2), int.parse(marks3)]
      });
      if (res.statusCode == 200) {
        var jsonRes = res.data;
        if (jsonRes["status"] == 400) {
          emit(StudentDataErrorState(jsonRes["message"].toString()));
        } else {
          _canTriggerActions = true;
          await refreshData();
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

  Future editMarks(id, marks1, marks2, marks3) async {
    if (!_canTriggerActions) return;
    _canTriggerActions = false;

    // logic
    emit(const StudentDataProcessingState());
    if (marks1 == "" ||
        marks2 == "" ||
        marks3 == "" ||
        !RegExp(r'^[0-9]+$').hasMatch(marks1) ||
        !RegExp(r'^[0-9]+$').hasMatch(marks2) ||
        !RegExp(r'^[0-9]+$').hasMatch(marks3) ||
        !RegExp(r'^[0-9]+$').hasMatch(id) ||
        int.parse(marks1) < 0 ||
        int.parse(marks2) < 0 ||
        int.parse(marks3) < 0 ||
        int.parse(marks1) > 100 ||
        int.parse(marks2) > 100 ||
        int.parse(marks3) > 100) {
      emit(const StudentDataErrorState("Please enter valid entries only"));
      emit(const StudentDataInitial());
      _canTriggerActions = true;
      return;
    }
    try {
      var res = await Dio().put('$address/update/grades', data: {
        "id": int.parse(id),
        "grades": [int.parse(marks1), int.parse(marks2), int.parse(marks3)]
      });
      if (res.statusCode == 200) {
        var jsonRes = res.data;
        if (jsonRes["status"] == 400) {
          emit(StudentDataErrorState(jsonRes["message"].toString()));
        } else {
          _canTriggerActions = true;
          await refreshData();
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
