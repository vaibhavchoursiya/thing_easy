import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_event.dart';
import 'package:thing_easy/blocs/add_form/add_form_state.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFormBloc, AddFormState>(
      buildWhen: (previous, current) {
        if (current is InitialAddFormState || current is StatusFormState) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        if (state is StatusFormState) {
          return Checkbox(
            value: state.status,
            activeColor: AppTheme.accentColor,
            onChanged: (value) {
              final addFormBloc = context.read<AddFormBloc>();
              addFormBloc.add(UpdateStatusEvent(status: value!));
            },
          );
        }
        if (state is InitialAddFormState) {
          return Checkbox(
            value: state.status,
            activeColor: AppTheme.accentColor,
            onChanged: (value) {
              final addFormBloc = context.read<AddFormBloc>();
              addFormBloc.add(UpdateStatusEvent(status: value!));
            },
          );
        }
        return Text("checkBox");
      },
    );
  }
}
