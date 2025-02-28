import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class HeadLabelWidget extends StatelessWidget {
  final String emoji;
  final String titleText;
  final int pendingTasks;
  final int numOfTask;
  final bool showPendingList;
  const HeadLabelWidget({
    super.key,
    required this.titleText,
    required this.pendingTasks,
    required this.numOfTask,
    required this.emoji,
    this.showPendingList = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(emoji, style: TextStyle(fontSize: 24)),
          const SizedBox(width: 8.0),
          Text(titleText, style: AppTheme.subHeadingStyle),
          Spacer(),
          if (showPendingList)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 2.5,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.accentColor,
              ),
              child: Text(
                pendingTasks.toString(),
                style: GoogleFonts.aDLaMDisplay(
                  color: AppTheme.light,
                  fontSize: 14.0,
                ),
              ),
            ),
          const SizedBox(width: 16.0),

          Text(numOfTask.toString(), style: AppTheme.titleStyle),
        ],
      ),
    );
  }
}
