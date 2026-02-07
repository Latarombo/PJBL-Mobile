import 'package:flutter/material.dart';

import '../shared/theme/app_theme.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // App identity
      title: 'SantaraNa',

      // Global theme
      theme: AppTheme.lightTheme,

      // Centralized routing
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
