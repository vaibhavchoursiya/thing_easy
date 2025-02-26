import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/add_task_screen.dart';
import 'package:thing_easy/widgets/head_label_column_widget.dart';
import 'package:thing_easy/widgets/quick_find_field.dart';
import 'package:thing_easy/widgets/task_collection_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddTaskScreen(),
          );
        },
        child: Icon(Icons.add, color: AppTheme.light, size: 45.0),
      ),
      backgroundColor: AppTheme.light,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QuickFindField(),
              HeadLabelColumnWidget(),
              TaskCollectionList(),
            ],
          ),
        ),
      ),
    );
  }
}
