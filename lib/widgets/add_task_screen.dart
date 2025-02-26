import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.11),
          Container(
            width: double.infinity,
            height: height * 0.5,
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: AppTheme.light,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(),
          ),
        ],
      ),
    );
  }
}
