class LoadHomeDataState {
  final bool loading;
  final List todayTasks;
  final List upcomingTasks;
  final List somedayTasks;
  final List anytimeTasks;
  final List pendingTasks;
  final List collections;

  LoadHomeDataState({
    required this.loading,
    required this.todayTasks,
    required this.upcomingTasks,
    required this.somedayTasks,
    required this.anytimeTasks,
    required this.pendingTasks,
    required this.collections,
  });

  LoadHomeDataState copyWith({
    bool? loading,
    List? todayTasks,
    List? upcomingTasks,
    List? somedayTasks,
    List? anytimeTasks,
    List? pendingTasks,
    List? collections,
  }) {
    return LoadHomeDataState(
      loading: loading ?? this.loading,
      todayTasks: todayTasks ?? this.todayTasks,
      upcomingTasks: upcomingTasks ?? this.upcomingTasks,
      somedayTasks: somedayTasks ?? this.somedayTasks,
      anytimeTasks: anytimeTasks ?? this.anytimeTasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      collections: collections ?? this.collections,
    );
  }
}
