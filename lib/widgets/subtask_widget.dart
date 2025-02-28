import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_event.dart';
import 'package:thing_easy/blocs/add_form/add_form_state.dart';
import 'package:thing_easy/models/task_model.dart';
import 'package:thing_easy/utilites/app_theme.dart';

/// A widget that displays a list of subtasks and updates the state in the AddFormBloc.
class SubtaskWidget extends StatelessWidget {
  const SubtaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFormBloc, AddFormState>(
      buildWhen: (previous, current) {
        return current is InitialAddFormState ||
            current is SubTaskListFormState;
      },
      builder: (context, state) {
        if (state is InitialAddFormState) {
          return SubTaskListView(subTasks: state.subTasks);
        } else if (state is SubTaskListFormState) {
          return SubTaskListView(subTasks: state.subTasks);
        }
        return const SizedBox.shrink(); // Return an empty container for unhandled states
      },
    );
  }
}

/// A widget that displays a list of subtasks.
class SubTaskListView extends StatelessWidget {
  final List<SubTask> subTasks;
  const SubTaskListView({super.key, required this.subTasks});

  @override
  Widget build(BuildContext context) {
    final addFormBloc = context.read<AddFormBloc>();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: subTasks.length,
      itemBuilder: (context, index) {
        final SubTask subTask = subTasks[index];
        return SubTaskItem(
          subTask: subTask,
          index: index,
          addFormBloc: addFormBloc,
        );
      },
    );
  }
}

/// A widget that displays a single subtask item.
class SubTaskItem extends StatelessWidget {
  final SubTask subTask;
  final int index;
  final AddFormBloc addFormBloc;

  const SubTaskItem({
    super.key,
    required this.subTask,
    required this.index,
    required this.addFormBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: subTask.status,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          onChanged: (value) {
            addFormBloc.add(
              UpdateSubTaskStatusEvent(index: index, status: value!),
            );
          },
          activeColor: AppTheme.accentColor,
        ),
        Expanded(
          child: TextFormField(
            initialValue: subTask.title,
            onChanged: (value) {
              addFormBloc.add(
                UpdateSubTaskTitleEvent(index: index, title: value),
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            addFormBloc.add(DeleteSubTaskEvent(index: index));
          },
          icon: Icon(Icons.delete, color: AppTheme.grey),
        ),
      ],
    );
  }
}
