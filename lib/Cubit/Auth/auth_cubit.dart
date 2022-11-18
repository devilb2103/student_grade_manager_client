import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:student_grade_manager/network_vars.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(SignedOutState());
  bool _canTriggerAuthActions = true;

  Future<void> signIn(String username, String password) async {
    if (!_canTriggerAuthActions) return;
    _canTriggerAuthActions = false;

    emit(const ProcessingState());
    try {
      var res = await Dio()
          .post('$address/login', data: {'user': username, 'pswd': password});
      if (res.statusCode == 200) {
        var jsonRes = res.data;
        if (jsonRes["status"] == 401) {
          emit(const SignInErrorState("Invalid Credentials entered"));
          emit(const SignedOutState());
        } else {
          //when login is successfull
          emit(const SignedInState());
        }
      } else {
        emit(SignInErrorState(
            "Server returned an error with status code ${res.statusCode}"));
        emit(const SignedOutState());
      }
    } on DioError catch (e) {
      emit(SignInErrorState(e.error.toString()));
      emit(const SignedOutState());
    }
    _canTriggerAuthActions = true;
  }
}
