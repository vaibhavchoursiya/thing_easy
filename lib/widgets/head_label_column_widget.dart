import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/head_label_widget.dart' show HeadLabelWidget;

class HeadLabelColumnWidget extends StatelessWidget {
  const HeadLabelColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadLabelWidget(
          emoji: "⭐",
          titleText: "Today",
          pendingTasks: 1,
          numOfTask: 10,
        ),
        HeadLabelWidget(
          emoji: "🗓️",
          titleText: "Upcoming",
          pendingTasks: 10,
          numOfTask: 1,
        ),
        HeadLabelWidget(
          emoji: "📚",
          titleText: "Anytime",
          pendingTasks: 15000,
          numOfTask: 10,
        ),
        HeadLabelWidget(
          emoji: "🍓",
          titleText: "Someday",
          pendingTasks: 15000,
          numOfTask: 10,
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
