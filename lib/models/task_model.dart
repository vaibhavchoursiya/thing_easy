class TaskModel {
  final String title;
  final String desc;
  final DateTime deadline;
  final bool status;
  final String collectionName;
  final List<SubTask> subTasks;

  TaskModel({
    required this.collectionName,
    required this.title,
    required this.desc,
    required this.deadline,
    required this.status,

    required this.subTasks,
  });

  toMap() {
    final List sub = [];

    for (var subTask in subTasks) {
      sub.add(subTask.toMap());
    }

    return {
      "collectionName": collectionName,
      "title": title,
      "desc": desc,
      "deadline": deadline.millisecondsSinceEpoch ~/ 1000,
      "status": status,
      "subTasks": sub,
    };
  }
}

class SubTask {
  final String title;
  final bool status;

  SubTask({required this.title, required this.status});

  toMap() {
    return {"status": status, "title": title};
  }
}
