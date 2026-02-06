import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tutup keyboard saat tap di luar input field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Background Image - Only at the top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.30, // 30% tinggi layar
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

            // Header with back button and title
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                    SizedBox(width: 48), // Balance untuk back button
                  ],
                ),
              ),
            ),

            // Draggable Card Container
            DraggableScrollableSheet(
              initialChildSize: 0.85, // Mulai tinggi layar
              minChildSize: 0.75, // Minimal bisa ditarik
              maxChildSize: 0.85, // Maksimal bisa ditarik
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8E7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
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
                      // Drag Handle (indicator untuk drag)
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
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            // Illustration
                            Image.asset(
                              'assets/images/ilustration_forgotPass.png',
                              width: 220,
                              height: 220,
                            ),

                            SizedBox(height: 32),

                            // Title
                            Text(
                              'Lupa password?',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),

                            SizedBox(height: 12),

                            // Description
                            Text(
                              'silakan tulis email Anda untuk menerima kode konfirmasi untuk mengatur ulang kata sandi baru',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 32),

                            // Email Input Field
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Alamat email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 18,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),

                            SizedBox(height: 24),

                            // Confirm Email Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle confirm email
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationCodePage()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF2C2C2C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Konfirmasi Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
