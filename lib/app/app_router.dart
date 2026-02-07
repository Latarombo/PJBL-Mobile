import 'package:flutter/material.dart';

// Pages
import '../features/splash_screen/splash_screen.dart';
import '../features/auth/sign_in.dart';
import 'app_shell.dart';
import 'app_routes.dart';

class AppRouter {
  static const initialRoute = AppRoutes.splash;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case AppRoutes.app:
        return MaterialPageRoute(builder: (_) => const AppShell());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route tidak ditemukan')),
          ),
        );
    }
  }
}
