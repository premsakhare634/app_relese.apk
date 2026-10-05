import 'package:flutter/material.dart';
import 'screens/home_shell.dart';
import 'theme.dart';

class SmartDailyNotebookApp extends StatelessWidget {
  const SmartDailyNotebookApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Smart Daily Notebook',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    home: const HomeShell(),
  );
}
