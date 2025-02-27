import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class MtextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final int maxLine;
  final String hintText;
  final TextStyle textStyle;
  final double maxHeight;
  const MtextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.maxLine,
    required this.textStyle,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      minLines: 1,
      maxLines: maxLine,
      style: textStyle,
      decoration: InputDecoration(
        // filled: true,
        constraints: BoxConstraints(maxHeight: maxHeight),
        contentPadding: const EdgeInsets.all(2),
        isDense: true,
        hintStyle: textStyle,
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}

class MDateTimeField extends StatelessWidget {
  final TextEditingController controller;

  final Function validator;
  final String hintText;
  final TextStyle textStyle;
  const MDateTimeField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextFormField(
          readOnly: true,
          controller: controller,
          validator: (value) {
            return validator(value);
          },
          onTap: () async {
            final currentDate = DateTime.now();
            final DateTime? selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime(2030),
              initialDate: currentDate,
            );
            if (selectedDate != null) {
              controller.text = DateFormat("yyyy-MM-dd").format(selectedDate);
            } else {
              controller.text = DateFormat("yyyy-MM-dd").format(currentDate);
            }
          },
          style: textStyle,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: 130.0, maxHeight: 45.0),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            hintText: hintText,
            hintStyle: textStyle,
            border: InputBorder.none,

            filled: true,
          ),
        ),
        const SizedBox(width: 10.0),
        Icon(Icons.calendar_month, color: AppTheme.dark.withValues(alpha: 0.6)),
      ],
    );
  }
}
