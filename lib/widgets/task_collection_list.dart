import 'package:flutter/material.dart';
import 'package:thing_easy/widgets/task_collection_widget.dart';

class TaskCollectionList extends StatelessWidget {
  const TaskCollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TaskCollectionWidget(collectionName: "Family"),
          TaskCollectionWidget(collectionName: "Personal"),
          TaskCollectionWidget(collectionName: "Work"),
        ],
      ),
    );
  }
}
