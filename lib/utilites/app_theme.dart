import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color light = Color(0xFFffffff);
  static const Color dark = Color(0xFF1e1e1e);
  static const Color grey = Color(0xFFf4f5f7);
  static const Color subTextColor = Color(0xFF595c5e);
  static const Color accentColor = Color(0xFF469ffc);

  static final headingStyle = GoogleFonts.inter(
    color: AppTheme.dark,
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
  );
  static final subHeadingStyle = GoogleFonts.inter(
    color: AppTheme.dark.withValues(alpha: 0.9),
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );
  static final titleStyle = GoogleFonts.inter(
    color: AppTheme.dark.withValues(alpha: 0.8),
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static final subTitleStyle = GoogleFonts.inter(
    color: AppTheme.subTextColor,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );
}
