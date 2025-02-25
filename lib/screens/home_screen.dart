import 'package:flutter/material.dart';
import 'package:thing_easy/utilites/app_theme.dart';
import 'package:thing_easy/widgets/quick_find_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light,
      body: SafeArea(child: Column(children: [QuickFindField()])),
    );
  }
}
