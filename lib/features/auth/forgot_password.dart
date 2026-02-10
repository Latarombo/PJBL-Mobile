import 'package:flutter/material.dart';
import 'email_verification.dart';
import '../../shared/widgets/app_input_field.dart';
import '../../shared/widgets/app_buttons.dart';
import '../../shared/widgets/app_snackbar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    // Regex untuk validasi email
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _validEmailSubmit() {

    // Validasi format email
    if (!_isValidEmail(emailController.text)) {
      AppSnackBar.show(
        context,
        message: 'Format email tidak valid',
        type: SnackType.error,
      );
      return;
    }

    // Navigate ke sign in page setelah delay
    // Future.delayed(Duration(milliseconds: 1500), () {
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EmailVerificationPage(email: emailController.text),
        ),
      );
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(color: Colors.black.withValues(alpha: 0.45)),
            ),
          ),

          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Lupa Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // Draggable Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.75,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFF8E7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: Offset(0, -5),
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
                        margin: EdgeInsets.only(top: 12, bottom: 20),
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

                          SizedBox(height: 32),

                          Text(
                            'Lupa password?',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff270f0f), //text primary color
                            ),
                          ),

                          SizedBox(height: 12),

                          Text(
                            'Silakan tulis email Anda untuk menerima kode konfirmasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 32),

                          // Email Input Field
                          InputField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            hint: 'Email',
                            onSubmitted: (_) => _validEmailSubmit(),
                          ),

                          SizedBox(height: 24),

                          // Submit Button
                          PrimaryButton(
                            text: 'Konfirmasi Email',
                            onPressed: _validEmailSubmit,
                          ),

                          SizedBox(height: 40),
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
    );
  }
}
