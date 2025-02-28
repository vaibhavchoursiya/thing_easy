import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thing_easy/blocs/home_data/home_data_event.dart';
import 'package:thing_easy/blocs/home_data/home_data_state.dart';
import 'package:thing_easy/services/firebase_db_services.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, LoadHomeDataState> {
  List pendingTasks = [];
  List task = [];
  List today = [];
  List upcoming = [];
  List someday = [];
  List anytime = [];
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
      task = await FirebaseDbServices.getTasks();
      divideTasksBasedOnDeadline(task);
      emit(
        state.copyWith(
          loading: false,
          numberOfTodayTasks: today.length,
          numberOfUpcomingTasks: upcoming.length,
          numberOfSomedayTasks: someday.length,
          numberOfAnytimeTasks: anytime.length,
          numberOfPendingTasks: pendingTasks.length,
          collections: task,
        ),
      );
    });
  }

  /// divide task based on deadline and status
  divideTasksBasedOnDeadline(task) {
    for (var item in task) {
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
}
