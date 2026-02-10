import 'package:flutter/material.dart';
import 'dart:async';
import '../../app/app_routes.dart';
import '../../shared/widgets/app_buttons.dart';

class PasswordRecoverySuccessPage extends StatefulWidget {
  const PasswordRecoverySuccessPage({super.key});

  @override
  State<PasswordRecoverySuccessPage> createState() =>
      _PasswordRecoverySuccessPageState();
}

class _PasswordRecoverySuccessPageState
    extends State<PasswordRecoverySuccessPage> {
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.app,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E7),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon_succes.png',
                  width: 200,
                  height: 200,
                ),

                SizedBox(height: 48),

                // Title
                Text(
                  'Password berhasil\ndipulihkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),

                SizedBox(height: 16),

                // Description
                Text(
                  'Password Anda telah berhasil dipulihkan, kami akan\nmemberi tahu Anda jika ada masalah lebih lanjut\ndengan akun Anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32),

                // Countdown indicator
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFB8886F).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: Color(0xFFB8886F),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Mengarahkan dalam $_countdown detik',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Manual navigation button
                PrimaryButton(
                  text: 'Ke Halaman Utama',
                  onPressed: () {
                    _timer?.cancel();
                    _navigateToHome();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
