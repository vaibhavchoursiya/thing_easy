import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thing_easy/blocs/add_form/add_form_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_event.dart';
import 'package:thing_easy/blocs/add_form/add_form_state.dart';
import 'package:thing_easy/blocs/home_data/home_data_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_event.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/utilites/validator.dart';
import 'package:thing_easy/widgets/check_box_widget.dart';
import 'package:thing_easy/widgets/mtext_form_field.dart';
import 'package:thing_easy/widgets/subtask_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initialization();
    });
  }

  Future<void> initialization() async {
    final addFormBloc = context.read<AddFormBloc>();
    addFormBloc.add(ResetAddFormEvent());
  }

  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController collectionNameController =
      TextEditingController();

  void clearTextEditingController() {
    titleController.clear();
    descriptionController.clear();
    deadlineController.clear();
    collectionNameController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    collectionNameController.dispose();
    super.dispose();
  }

  /// covert empty date to anytime date
  /// (a date that is represent that user does not add any deadline for the tasd)
  String convertEmptyDateToAnytime(String date) {
    final deadline =
        date == ""
            ? DateFormat("yyyy-MM-dd").format(DateTime(2003, 1, 25))
            : date;
    return deadline;
  }

  /// covert empty collection to zero collection
  /// (zero collection represent that user does not add any collection name)
  String convertEmptyCollectionNameToZeroCollection(String collectionName) {
    if (collectionName != "") {
      return collectionName;
    }
    return "zero";
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.transparent,
      child: BlocConsumer<AddFormBloc, AddFormState>(
        listener: (context, state) {
          if (state is SuccessAddFormState) {
            final homeDataBloc = context.read<HomeDataBloc>();
            homeDataBloc.add(FetchHomeDataEvent());
            if (context.mounted) {
              context.pop();
            }
          }
        },
        buildWhen: (previous, current) {
          return current is InitialAddFormState ||
              current is LoadingAddFormState;
        },
        builder: (context, state) {
          if (state is LoadingAddFormState) {
            print("loading state");
            return const Center(child: CircularProgressIndicator());
          }
          if (state is InitialAddFormState) {
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
                    child: Column(
                      children: [
                        CancelButton(),
                        AddScreenForm(
                          addFormKey: addFormKey,
                          deadlineController: deadlineController,
                          descriptionController: descriptionController,
                          titleController: titleController,
                        ),

                        Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppTheme.grey.withValues(alpha: 0.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: MtextFormField(
                                  controller: collectionNameController,
                                  validator: () => null,
                                  hintText: "Enter collection name",
                                  maxLine: 1,
                                  textStyle: AppTheme.titleStyle,
                                  maxHeight: 40,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (addFormKey.currentState!.validate()) {
                                    final addFormBloc =
                                        context.read<AddFormBloc>();

                                    final deadline = convertEmptyDateToAnytime(
                                      deadlineController.text,
                                    );
                                    final collectionName =
                                        convertEmptyCollectionNameToZeroCollection(
                                          collectionNameController.text,
                                        );
                                    addFormBloc.add(
                                      AddTaskEvent(
                                        deadline: DateTime.parse(deadline),
                                        desc: descriptionController.text,
                                        title: titleController.text,
                                        collectionName: collectionName,
                                      ),
                                    );
                                    clearTextEditingController();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.inter(
                                    color: AppTheme.light,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class AddScreenForm extends StatelessWidget {
  final GlobalKey<FormState> addFormKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController deadlineController;

  const AddScreenForm({
    super.key,
    required this.addFormKey,
    required this.titleController,
    required this.descriptionController,
    required this.deadlineController,
  });

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
                  controller: titleController,
                  validator: Validator.emptyValidator,
                  hintText: "Enter you note here!",
                  maxLine: 1,
                  textStyle: AppTheme.titleStyle,
                  maxHeight: 40.0,
                ),
                MtextFormField(
                  controller: descriptionController,
                  validator: Validator.emptyValidator,
                  hintText: "Add you description",
                  maxLine: 4,
                  textStyle: AppTheme.subTitleStyle,
                  maxHeight: 100.0,
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    MDateTimeField(
                      controller: deadlineController,
                      hintText: "Deadline",
                      textStyle: AppTheme.titleStyle,
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.dark,
                        foregroundColor: AppTheme.light,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        final addFormBloc = context.read<AddFormBloc>();
                        addFormBloc.add(AddSubTaskEvent());
                      },
                      child: Text("add item"),
                    ),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     final addFormBloc = context.read<AddFormBloc>();
                //     addFormBloc.add(AddSubTaskEvent(status: false, title: ""));
                //   },
                //   child: Text("add subTask"),
                // ),
                SubtaskWidget(),
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
