import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thing_easy/blocs/home_data/home_data_event.dart';
import 'package:thing_easy/blocs/home_data/home_data_state.dart';
import 'package:thing_easy/services/firebase_db_services.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, LoadHomeDataState> {
  List pendingTasks = [];
  List tasks = [];
  List today = [];
  List upcoming = [];
  List someday = [];
  List anytime = [];
  List collections = []; // contain task based on collectionName;
  List taskCollectionNames = []; // contain collection names.

  resetAboveValues() {
    pendingTasks.clear();
    tasks.clear();
    today.clear();
    upcoming.clear();
    someday.clear();
    anytime.clear();
    taskCollectionNames.clear();
  }

  HomeDataBloc()
    : super(
        LoadHomeDataState(
          loading: true,
          numberOfTodayTasks: 0,
          numberOfUpcomingTasks: 0,
          numberOfSomedayTasks: 0,
          numberOfAnytimeTasks: 0,
          numberOfPendingTasks: 0,
          collections: [],
        ),
      ) {
    on<FetchHomeDataEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      tasks = await FirebaseDbServices.getTasks();
      divideTasksBasedOnDeadline(tasks);
      taskCollectionNames = await FirebaseDbServices.getTaskCollections();
      collections = divideTasksBasedOnCollectionName(
        tasks,
        taskCollectionNames,
      );
      print(collections);

      emit(
        state.copyWith(
          loading: false,
          numberOfTodayTasks: today.length,
          numberOfUpcomingTasks: upcoming.length,
          numberOfSomedayTasks: someday.length,
          numberOfAnytimeTasks: anytime.length,
          numberOfPendingTasks: pendingTasks.length,
          collections: collections,
        ),
      );
    });
  }

  /// divide task based on deadline and status
  divideTasksBasedOnDeadline(tasks) {
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
  }

  /// divide task based on collectionName
  List divideTasksBasedOnCollectionName(tasks, taskCollectionNames) {
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
