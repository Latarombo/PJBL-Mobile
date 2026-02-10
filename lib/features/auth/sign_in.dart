import 'package:flutter/material.dart';
import '../../app/app_routes.dart';
import 'forgot_password.dart';
import '../../shared/widgets/social_login_button.dart';
import '../../shared/widgets/app_snackbar.dart';
import '../../shared/widgets/app_input_field.dart';
import '../../shared/widgets/app_buttons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    // Validasi input kosong
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      AppSnackBar.show(
        context,
        message: 'Username dan password tidak boleh kosong',
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

    // Jika validasi berhasil
    AppSnackBar.show(
      context,
      message: 'Login berhasil!...',
      type: SnackType.success,
    );

    // Navigate ke profile page setelah delay singkat
    // Future.delayed(Duration(milliseconds: 500), () {
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
              height:
                  MediaQuery.of(context).size.height * 0.30, // 35% tinggi layar
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  fit: BoxFit.cover, // Penuh kiri-kanan
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
                    // Header with Register button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.register);
                            },
                            child: Text(
                              'Register',
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
                    // Flexible space - adjusts based on available height
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    // Sign In Form - This will overlap the background
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
                              'Sign In',
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
                            // Username Field
                            InputField(
                              controller: usernameController,
                              hint: 'Username',
                            ),

                            SizedBox(height: 16),
                            // Password field
                            InputField(
                              controller: passwordController,
                              hint: 'Password',
                              obscureText: _obscurePassword,
                              toggleObscure: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                            ),

                            SizedBox(height: 8),
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'lupa password?*',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            // Sign In Button
                            PrimaryButton(
                              text: 'Sign In',
                              onPressed: _handleSignIn,
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

                            SizedBox(height: 45), // Bottom Spacing
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
