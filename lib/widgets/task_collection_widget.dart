import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class TaskCollectionWidget extends StatelessWidget {
  final String collectionName;
  final List taskTitleCollections;

  const TaskCollectionWidget({
    super.key,
    required this.collectionName,
    required this.taskTitleCollections,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category, color: AppTheme.dark.withValues(alpha: 0.6)),
            const SizedBox(width: 10.0),
            Text(collectionName, style: AppTheme.subHeadingStyle),
          ],
        ),
        const SizedBox(height: 4.0),

        ListView.builder(
          padding: const EdgeInsets.only(top: 2.0),
          shrinkWrap: true,
          itemCount: taskTitleCollections.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0.1,
              ),
              leading: Icon(
                Icons.timelapse_outlined,
                color: AppTheme.dark.withValues(alpha: 0.4),
              ),
              title: Text(
                taskTitleCollections[index],
                style: AppTheme.subTitleStyle,
              ),
            );
          },
        ),
        Divider(),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
