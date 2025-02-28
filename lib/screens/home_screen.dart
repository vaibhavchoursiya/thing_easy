import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_bloc.dart';
import 'package:thing_easy/blocs/home_data/home_data_event.dart';
import 'package:thing_easy/blocs/home_data/home_data_state.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/add_task_screen.dart';
import 'package:thing_easy/widgets/head_label_column_widget.dart';
import 'package:thing_easy/widgets/quick_find_field.dart';
import 'package:thing_easy/widgets/task_collection_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeDataBloc = context.read<HomeDataBloc>();
      homeDataBloc.add(FetchHomeDataEvent());
    });
  }

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
      body: BlocBuilder<HomeDataBloc, LoadHomeDataState>(
        buildWhen: (previous, current) {
          return previous.loading != current.loading;
        },
        builder: (context, state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppTheme.accentColor),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  QuickFindField(),
                  HeadLabelColumnWidget(),
                  TaskCollectionList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
