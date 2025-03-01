import 'package:intl/intl.dart';

class HomeDataHelper {
  /// divide task based on deadline and status
  static divideTasksBasedOnDeadline(tasks) {
    List pendingTasks = [];
    List today = [];
    List upcoming = [];
    List anytime = [];

    for (var item in tasks) {
      final DateTime deadline = DateTime.fromMillisecondsSinceEpoch(
        item['deadline'] * 1000,
      );
      final DateTime current = DateTime.parse(
        DateFormat("yyyy-MM-dd").format(DateTime.now()),
      );

      if (deadline == DateTime(2003, 1, 25)) {
        anytime.add(item);
      } else {
        if (deadline.isAtSameMomentAs(current)) {
          today.add(item);
        } else if (deadline.isBefore(current) && item["status"] == false) {
          pendingTasks.add(item);
        } else if (deadline.isAfter(current)) {
          upcoming.add(item);
        }
      }
    }
    return {
      "today": today,
      "pendingTasks": pendingTasks,
      "upcoming": upcoming,
      "anytime": anytime,
    };
  }

  /// divide task based on collectionName
  static List divideTasksBasedOnCollectionName(tasks, taskCollectionNames) {
    List collections = [];

    for (var collectionName in taskCollectionNames) {
      final Map collection = {};
      collection["collectionName"] = collectionName["collectionName"];
      collection["taskTitles"] = [];
      for (var task in tasks) {
        if (task["collectionName"] == collectionName["collectionName"]) {
          collection["taskTitles"].add(task["title"]);
        }
      }
      collections.add(collection);
    }

    return collections;
  }
}
