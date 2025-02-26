import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/head_label_column_widget.dart';
import 'package:thing_easy/widgets/quick_find_field.dart';
import 'package:thing_easy/widgets/task_collection_list.dart';
import 'package:thing_easy/widgets/task_collection_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
