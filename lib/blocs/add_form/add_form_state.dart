import 'package:thing_easy/models/task_model.dart';

abstract class AddFormState {}

class LoadingAddFormState extends AddFormState {}

class InitialAddFormState extends AddFormState {
  final bool status;
  final List<SubTask> subTasks;

  InitialAddFormState({required this.status, required this.subTasks});
}

class StatusFormState extends AddFormState {
  final bool status;

  StatusFormState({required this.status});
}

class SubTaskListFormState extends AddFormState {
  final List<SubTask> subTasks;
  SubTaskListFormState({required this.subTasks});
}

// class SubTaskStatusFormState extends AddFormState {
//   final bool status;

//   SubTaskStatusFormState({required this.status});
// }

// class SubTaskTitleFormState extends AddFormState {
//   final String title;

//   SubTaskTitleFormState({required this.title});
// }
