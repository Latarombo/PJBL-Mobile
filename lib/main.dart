import 'package:flutter/material.dart';
import 'splash_screen/splash_screen.dart';
import 'screens/sign_in.dart';
import 'screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SantaraNa',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signIn': (context) => const SignInPage(),
        '/register': (context) => const RegisterPage(),

      },
    );
  }
}
