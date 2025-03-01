import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_state.dart';
import 'package:thing_easy/widgets/task_collection_widget.dart';

class TaskCollectionList extends StatelessWidget {
  const TaskCollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, LoadHomeDataState>(
      buildWhen: (previous, current) {
        return previous.collections != current.collections;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children:
                state.collections.map((e) {
                  return TaskCollectionWidget(
                    collectionName: e["collectionName"],
                    taskTitleCollections: e["taskTitles"],
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
