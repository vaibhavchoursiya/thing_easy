import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_event.dart';
import 'package:thing_easy/blocs/add_form/add_form_state.dart';
import 'package:thing_easy/models/task_model.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class SubtaskWidget extends StatelessWidget {
  const SubtaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFormBloc, AddFormState>(
      buildWhen: (previous, current) {
        if (current is InitialAddFormState || current is SubTaskListFormState) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        if (state is InitialAddFormState) {
          return SubTaskListView(subTasks: state.subTasks);
        }
        if (state is SubTaskListFormState) {
          return SubTaskListView(subTasks: state.subTasks);
        }
        return Text("sub task listview");
      },
    );
  }
}

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
      },
    );
  }
}
