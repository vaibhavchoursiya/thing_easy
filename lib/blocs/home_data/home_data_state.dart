class LoadHomeDataState {
  final bool loading;
  final int numberOfTodayTasks;
  final int numberOfUpcomingTasks;
  final int numberOfSomedayTasks;
  final int numberOfAnytimeTasks;
  final int numberOfPendingTasks;
  final List collections;

  LoadHomeDataState({
    required this.loading,
    required this.numberOfTodayTasks,
    required this.numberOfUpcomingTasks,
    required this.numberOfSomedayTasks,
    required this.numberOfAnytimeTasks,
    required this.numberOfPendingTasks,
    required this.collections,
  });

  LoadHomeDataState copyWith({
    bool? loading,
    int? numberOfTodayTasks,
    int? numberOfUpcomingTasks,
    int? numberOfSomedayTasks,
    int? numberOfAnytimeTasks,
    int? numberOfPendingTasks,
    List? collections,
  }) {
    return LoadHomeDataState(
      loading: loading ?? this.loading,
      numberOfTodayTasks: numberOfTodayTasks ?? this.numberOfTodayTasks,
      numberOfUpcomingTasks:
          numberOfUpcomingTasks ?? this.numberOfUpcomingTasks,
      numberOfSomedayTasks: numberOfSomedayTasks ?? this.numberOfSomedayTasks,
      numberOfAnytimeTasks: numberOfAnytimeTasks ?? this.numberOfAnytimeTasks,
      numberOfPendingTasks: numberOfPendingTasks ?? this.numberOfPendingTasks,
      collections: collections ?? this.collections,
    );
  }
}
