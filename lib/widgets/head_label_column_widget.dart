import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_state.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/head_label_widget.dart' show HeadLabelWidget;

class HeadLabelColumnWidget extends StatelessWidget {
  const HeadLabelColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeDataBloc, LoadHomeDataState>(
          buildWhen: (previous, current) {
            return previous.numberOfPendingTasks !=
                current.numberOfPendingTasks;
          },
          builder: (context, state) {
            return HeadLabelWidget(
              emoji: "⭐",
              titleText: "Today",
              pendingTasks: state.numberOfPendingTasks,
              numOfTask: state.numberOfTodayTasks,
            );
          },
        ),
        BlocBuilder<HomeDataBloc, LoadHomeDataState>(
          builder: (context, state) {
            return HeadLabelWidget(
              emoji: "🗓️",
              titleText: "Upcoming",
              pendingTasks: -1,
              showPendingList: false,
              numOfTask: state.numberOfUpcomingTasks,
            );
          },
        ),

        BlocBuilder<HomeDataBloc, LoadHomeDataState>(
          buildWhen: (previous, current) {
            return previous.numberOfSomedayTasks !=
                current.numberOfSomedayTasks;
          },
          builder: (context, state) {
            return HeadLabelWidget(
              emoji: "🍓",
              titleText: "Someday",
              pendingTasks: -1,
              showPendingList: false,

              numOfTask: state.numberOfSomedayTasks,
            );
          },
        ),
        BlocBuilder<HomeDataBloc, LoadHomeDataState>(
          buildWhen: (previous, current) {
            return previous.numberOfAnytimeTasks !=
                current.numberOfAnytimeTasks;
          },
          builder: (context, state) {
            return HeadLabelWidget(
              emoji: "📚",
              titleText: "Anytime",
              pendingTasks: -1, // mean no pending tasks
              numOfTask: state.numberOfAnytimeTasks,
              showPendingList: false,
            );
          },
        ),
        const SizedBox(height: 14.0),
        Divider(
          indent: 20.0,
          endIndent: 20.0,
          color: AppTheme.dark.withValues(alpha: 0.2),
        ),
      ],
    );
  }
}
