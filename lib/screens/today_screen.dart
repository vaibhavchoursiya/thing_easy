import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class TodayScreen extends StatelessWidget {
  final List todayTasks;
  final List pendingTasks;

  const TodayScreen({
    super.key,
    required this.todayTasks,
    required this.pendingTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppTheme.grey,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [Text("⭐ Today", style: AppTheme.headingStyle)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
