import 'package:flutter/material.dart';
import 'dart:async';
import '../../app/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _slideController;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startFlow();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.15),
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _textFadeAnimation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    );
  }

  Future<void> _startFlow() async {
    await _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    await _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 2800));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, AppRoutes.signIn);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB85C52), Color(0xFFD4896B), Color(0xFFE4A67C)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Image.asset(
                    'assets/images/logo_mascot.png',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              FadeTransition(
                opacity: _textFadeAnimation,
                child: Transform.translate(
                  offset: const Offset(0, -60),
                  child: Image.asset('assets/images/logo_name.png', width: 280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
