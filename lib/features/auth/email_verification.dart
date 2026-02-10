import 'package:flutter/material.dart';
import 'password_recovery_success.dart';
import '../../shared/widgets/input_otp.dart';
import '../../shared/widgets/app_buttons.dart';
import '../../shared/widgets/app_snackbar.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({super.key, this.email = 'Lylya8@gmail.com'});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  String _otpCode = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // ===== Background Image =====
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(color: Colors.black.withValues(alpha: 0.45)),
              ),
            ),

            // ===== Header =====
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Lupa Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            // ===== Content =====
            DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.75,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E7),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 20),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/ilustration_forgotPass.png',
                              width: 220,
                              height: 220,
                            ),

                            const SizedBox(height: 32),

                            const Text(
                              'Verifikasi Alamat Email',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff270f0f), //text primary color
                              ),
                            ),

                            const SizedBox(height: 12),

                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Kode verifikasi dikirim ke: ',
                                  ),
                                  TextSpan(
                                    text: widget.email,
                                    style: const TextStyle(
                                      color: Color(0xFF4A90E2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            // ===== OTP INPUT (REUSABLE) =====
                            OtpInput(
                              length: 4,
                              onCompleted: (otp) {
                                _otpCode = otp;
                                debugPrint('OTP Code: $otp');
                              },
                            ),

                            const SizedBox(height: 32),

                            // Button Confirm OTP
                            PrimaryButton(
                              text: 'Konfirmasi Kode OTP',
                              onPressed: _onConfirm,
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onConfirm() {

        if (_otpCode.isEmpty) {
      AppSnackBar.show(
        context,
        message: 'Mohon lengkapi kode OTP',
        type: SnackType.warning,
      );
      return;
    }

    if (_otpCode.length != 4) {
      AppSnackBar.show(
        context,
        message: 'Kode OTP tidak valid. Silakan coba lagi.',
        type: SnackType.error,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PasswordRecoverySuccessPage()),
    );
  }
}
