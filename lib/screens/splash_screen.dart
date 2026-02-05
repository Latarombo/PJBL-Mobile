import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Controller untuk fade in logo
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Controller untuk slide up dan text fade in
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Animasi fade in untuk logo
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Animasi slide up untuk logo
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.15), // Geser ke atas sedikit
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    // Animasi fade in untuk text
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    ));

    // Jalankan animasi
    _startAnimations();
  }

  void _startAnimations() async {
    // Mulai fade in logo
    await _fadeController.forward();
    
    // Tunggu sebentar
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Mulai slide up dan text fade in
    await _slideController.forward();
    
    // Tunggu sebentar sebelum navigasi
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Navigasi ke start screen
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/start');
    }
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFB85C52), // Warna merah dari gambar
              const Color(0xFFD4896B), // Warna transisi
              const Color(0xFFE4A67C), // Warna cream/orange
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo dengan animasi fade in dan slide up
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Image.asset(
                    'assets/images/WhatsApp_Image_2025-09-19_at_22_20_06-removebg-preview_2.png',
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              
              // Text logo dengan animasi fade in
              FadeTransition(
                opacity: _textFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Image.asset(
                    'assets/images/NADANE-removebg-preview__1__2.png',
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}