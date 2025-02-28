abstract class AddFormEvent {}

class AddTaskEvent extends AddFormEvent {
  final String title;
  final String desc;
  final DateTime deadline;
  final String collectionName;

  AddTaskEvent({
    required this.title,
    required this.desc,
    required this.deadline,
    required this.collectionName,
  });
}

class UpdateStatusEvent extends AddFormEvent {
  final bool status;

  UpdateStatusEvent({required this.status});
}

class AddSubTaskEvent extends AddFormEvent {}

class UpdateSubTaskStatusEvent extends AddFormEvent {
  final int index;
  final bool status;
  UpdateSubTaskStatusEvent({required this.index, required this.status});
}

class UpdateSubTaskTitleEvent extends AddFormEvent {
  final int index;
  final String title;
  UpdateSubTaskTitleEvent({required this.index, required this.title});
}

class DeleteSubTaskEvent extends AddFormEvent {
  final int index;

  DeleteSubTaskEvent({required this.index});
}

class ResetAddFormEvent extends AddFormEvent {}
