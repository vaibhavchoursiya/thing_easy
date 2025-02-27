import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/add_task_button.dart';
import 'package:thing_easy/widgets/check_box_widget.dart';
import 'package:thing_easy/widgets/mtext_form_field.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
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
              child: Column(
                children: [
                  CancelButton(),
                  AddScreenForm(),
                  Spacer(),
                  AddTaskButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddScreenForm extends StatefulWidget {
  const AddScreenForm({super.key});

  @override
  State<AddScreenForm> createState() => _AddScreenFormState();
}

class _AddScreenFormState extends State<AddScreenForm> {
  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckBoxWidget(),
        Form(
          key: addFormKey,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                MtextFormField(
                  controller: _titleController,
                  hintText: "Enter you note here!",
                  maxLine: 1,
                  textStyle: AppTheme.titleStyle,
                  maxHeight: 40.0,
                ),
                MtextFormField(
                  controller: _descriptionController,
                  hintText: "Add you description",
                  maxLine: 4,
                  textStyle: AppTheme.subTitleStyle,
                  maxHeight: 100.0,
                ),
                const SizedBox(height: 20.0),
                MDateTimeField(
                  controller: _deadlineController,
                  hintText: DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  textStyle: AppTheme.titleStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.cancel, color: AppTheme.grey),
        ),
      ],
    );
  }
}
