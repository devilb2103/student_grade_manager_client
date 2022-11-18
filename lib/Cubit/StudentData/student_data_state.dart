part of 'student_data_cubit.dart';

@immutable
abstract class StudentDataState {
  const StudentDataState();
}

class StudentDataInitial extends StudentDataState {
  const StudentDataInitial();
}

class StudentDataAddedState extends StudentDataState {
  const StudentDataAddedState();
}

class StudentMarksModifiedState extends StudentDataState {
  const StudentMarksModifiedState();
}

class StudentDataDeletedState extends StudentDataState {
  const StudentDataDeletedState();
}

class StudentDataErrorState extends StudentDataState {
  final String message;
  const StudentDataErrorState(this.message);
}

class StudentDataProcessingState extends StudentDataState {
  const StudentDataProcessingState();
}
