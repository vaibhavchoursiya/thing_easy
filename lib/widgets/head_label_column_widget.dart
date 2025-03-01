import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            return previous.pendingTasks.length != current.pendingTasks.length;
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.push(
                  "\\today",
                  extra: {
                    "todayTasks": state.todayTasks,
                    "pendingTasks": state.pendingTasks,
                  },
                );
              },
              child: HeadLabelWidget(
                emoji: "⭐",
                titleText: "Today",
                pendingTasks: state.pendingTasks.length,
                numOfTask: state.todayTasks.length,
              ),
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
              numOfTask: state.upcomingTasks.length,
            );
          },
        ),

        BlocBuilder<HomeDataBloc, LoadHomeDataState>(
          buildWhen: (previous, current) {
            return previous.somedayTasks.length != current.somedayTasks.length;
          },
          builder: (context, state) {
            return HeadLabelWidget(
              emoji: "🍓",
              titleText: "Someday",
              pendingTasks: -1,
              showPendingList: false,

              numOfTask: state.somedayTasks.length,
            );
          },
        ),
        BlocBuilder<HomeDataBloc, LoadHomeDataState>(
          buildWhen: (previous, current) {
            return previous.anytimeTasks.length != current.anytimeTasks.length;
          },
          builder: (context, state) {
            return HeadLabelWidget(
              emoji: "📚",
              titleText: "Anytime",
              pendingTasks: -1, // mean no pending tasks
              numOfTask: state.anytimeTasks.length,
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
