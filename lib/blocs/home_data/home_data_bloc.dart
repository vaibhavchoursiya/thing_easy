import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/helper/home_data_helper.dart';
import 'package:thing_easy/blocs/home_data/home_data_event.dart';
import 'package:thing_easy/blocs/home_data/home_data_state.dart';
import 'package:thing_easy/services/firebase_db_services.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, LoadHomeDataState> {
  List tasks = [];
  List pendingTasks = [];
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
          todayTasks: [],
          upcomingTasks: [],
          somedayTasks: [],
          anytimeTasks: [],
          pendingTasks: [],
          collections: [],
        ),
      ) {
    on<FetchHomeDataEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      tasks = await FirebaseDbServices.getTasks();
      final deadlineData = HomeDataHelper.divideTasksBasedOnDeadline(tasks);

      pendingTasks = deadlineData["pendingTasks"];
      today = deadlineData["today"];
      upcoming = deadlineData["upcoming"];
      anytime = deadlineData["anytime"];

      taskCollectionNames = await FirebaseDbServices.getTaskCollections();
      collections = HomeDataHelper.divideTasksBasedOnCollectionName(
        tasks,
        taskCollectionNames,
      );

      emit(
        LoadHomeDataState(
          loading: false,
          todayTasks: today,
          upcomingTasks: upcoming,
          somedayTasks: someday,
          anytimeTasks: anytime,
          pendingTasks: pendingTasks,
          collections: collections,
        ),
      );
    });
  }
}
