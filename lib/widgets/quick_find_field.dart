import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thing_easy/utilites/app_theme.dart';

class QuickFindField extends StatelessWidget {
  const QuickFindField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            onChanged: (query) {},
            decoration: InputDecoration(
              constraints: BoxConstraints(maxHeight: 40.0),
              contentPadding: const EdgeInsets.all(2),
              filled: true,
              fillColor: Color(0xFFe6e8ea),
              hintText: "🔍 Quick Find",
              hintStyle: GoogleFonts.inter(
                color: AppTheme.subTextColor.withValues(alpha: 0.35),
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
