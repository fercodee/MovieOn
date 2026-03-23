import 'package:flutter/material.dart';

import 'package:move_on/core/theme/app_theme.dart';
import 'package:move_on/features/shell/presentation/screens/shell_screen.dart';

class MovieOnApp extends StatelessWidget {
  const MovieOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieOn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ShellScreen(),
    );
  }
}
