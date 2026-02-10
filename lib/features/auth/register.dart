import 'package:flutter/material.dart';
import '../../app/app_routes.dart';
import '../../shared/widgets/social_login_button.dart';
import '../../shared/widgets/app_snackbar.dart';
import '../../shared/widgets/app_input_field.dart';
import '../../shared/widgets/app_buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    // Regex untuk validasi email
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleRegister() {
    // Validasi semua field kosong
    if (emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppSnackBar.show(
        context,
        message: 'Semua field harus diisi',
        type: SnackType.error,
      );
      return;
    }

    // Validasi format email
    if (!_isValidEmail(emailController.text)) {
      AppSnackBar.show(
        context,
        message: 'Format email tidak valid',
        type: SnackType.error,
      );
      return;
    }

    // Validasi panjang username
    if (usernameController.text.length < 3) {
      AppSnackBar.show(
        context,
        message: 'Username minimal 3 karakter',
        type: SnackType.warning,
      );
      return;
    }

    // Validasi panjang password
    if (passwordController.text.length < 6) {
      AppSnackBar.show(
        context,
        message: 'Password minimal 6 karakter',
        type: SnackType.warning,
      );
      return;
    }

    // Validasi password sama
    if (passwordController.text != confirmPasswordController.text) {
      AppSnackBar.show(
        context,
        message: 'Password tidak sesuai! Cek kembali password Anda.',
        type: SnackType.error,
      );
      return;
    }

    // Jika semua validasi berhasil
    AppSnackBar.show(
      context,
      message:
          'Registrasi berhasil! Selamat datang, ${usernameController.text}!',
      type: SnackType.success,
    );

    // Navigate ke home
    // Future.delayed(Duration(milliseconds: 1500), () {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.app, (route) => false);

    // });
  }

  void _handleGoogleSignIn() {
    AppSnackBar.show(
      context,
      message: 'Login dengan Google sedang diproses...',
      type: SnackType.info,
      iconPath: 'assets/images/icon_google.png',
    );
  }

  void _handleFacebookSignIn() {
    AppSnackBar.show(
      context,
      message: 'Login dengan Facebook sedang diproses...',
      type: SnackType.info,
      iconPath: 'assets/images/icon_facebook.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image - Only at the top
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
              // Dark overlay
              child: Container(color: Colors.black.withValues(alpha: 0.45)),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    // Header with Login button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Flexible space
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),

                    // Register Form - This will overlap the background
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title
                            Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Subtitle
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed to tempor',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 32),

                            // Email Field
                            InputField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              hint: 'Email',
                              onSubmitted: (_) => _handleRegister(),
                            ),
                            SizedBox(height: 16),

                            // Username Field
                            InputField(
                              controller: usernameController,
                              hint: 'Username',
                              onSubmitted: (_) => _handleRegister(),
                            ),
                            SizedBox(height: 16),

                            // Password Field
                            InputField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              hint: 'Password',
                              toggleObscure: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Confirm Password Field
                            InputField(
                              controller: confirmPasswordController,
                              obscureText: _obscureConfirmPassword,

                              hint: 'Confirm password',
                              toggleObscure: () => setState(
                                () => _obscureConfirmPassword =
                                    !_obscureConfirmPassword,
                              ),
                            ),
                            SizedBox(height: 24),

                            // Register Button
                            PrimaryButton(
                              text: 'Daftar',
                              onPressed: _handleRegister,
                            ),
                            SizedBox(height: 24),

                            // Google Sign In Button
                            SocialLoginButton(
                              text: 'Lanjut dengan Google',
                              iconPath: 'assets/images/icon_google.png',
                              onPressed: _handleGoogleSignIn,
                            ),

                            SizedBox(height: 16),
                            // Facebok Sign In button
                            SocialLoginButton(
                              text: 'Lanjut dengan Facebook',
                              iconPath: 'assets/images/icon_facebook.png',
                              onPressed: _handleFacebookSignIn,
                            ),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
