import 'package:thing_easy/models/task_model.dart';

class TaskCollectionModel {
  final String name;
  final int length;
  final List<TaskModel> tasks;

  TaskCollectionModel({
    required this.name,
    required this.length,
    required this.tasks,
  });
}
