import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: false,
      onChanged: (value) {},
      activeColor: AppTheme.accentColor,
      side: BorderSide(color: AppTheme.grey),
    );
  }
}
