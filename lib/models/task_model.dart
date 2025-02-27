class TaskModel {
  final String title;
  final String desc;
  final DateTime deadline;
  final bool status;
  final DateTime created;
  final DateTime updated;
  final List<SubTask> subTask;

  TaskModel({
    required this.title,
    required this.desc,
    required this.deadline,
    required this.status,
    required this.created,
    required this.updated,
    required this.subTask,
  });

  toMap() {
    return {
      "title": title,
      "desc": desc,
      "deadline": deadline,
      "status": status,
      "created": created,
      "updated": updated,
      "subTask": subTask,
    };
  }
}

class SubTask {
  final String title;
  final bool status;

  SubTask({required this.title, required this.status});
}
