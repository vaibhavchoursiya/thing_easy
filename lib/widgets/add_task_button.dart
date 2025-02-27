import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thing_easy/blocs/add_form/add_form_bloc.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    final addFormBloc = context.read<AddFormBloc>();
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: AppTheme.grey.withValues(alpha: 0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              // addFormBloc.add(AddTaskEvent())
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
    );
  }
}
