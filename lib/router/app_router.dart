import 'package:flutter/material.dart';
import '../splash_screen/splash_screen.dart';
import '../screens/sign_in.dart';
import '../screens/register.dart';
// import '../screens/home_page.dart';
import '../screens/profile_screen.dart';

class AppRouter {
  // initial route
  static const String initialRoute = '/';

  // routes map
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/signIn': (context) => const SignInPage(),
    '/register': (context) => const RegisterPage(),
    '/profile': (context) => const ProfilePage(),
  };
}
