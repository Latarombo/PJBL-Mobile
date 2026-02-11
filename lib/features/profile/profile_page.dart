import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f4e4),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image Section
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_profilePage.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),

            // White Card Section with Avatar Overlap
            Transform.translate(
              offset: Offset(0, -60),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // White Card Background dengan Border Radius
                  Container(
                    padding: EdgeInsets.only(
                      top: 80,
                      bottom: 0,
                      left: 24,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff9f4e4),
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(
                      //   color: Color(0xFFE0D5C7),
                      //   width: 2,
                      // ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Color(0xFFD4A574).withValues(alpha: 0.2),
                      //     blurRadius: 15,
                      //     offset: Offset(0, 5),
                      //   ),
                      // ],
                    ),
                    child: Column(
                      children: [
                        // Username
                        Text(
                          'Najwa_Miniww',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 24),

                        // Stats Card
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color(0xfff8843f).withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatItem(
                                icon: Icons.star,
                                label: 'POIN',
                                value: '1200',
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey[300],
                              ),
                              _buildStatItem(
                                icon: Icons.public,
                                label: 'RANGKING',
                                value: '1200',
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey[300],
                              ),
                              _buildStatItem(
                                icon: Icons.trending_up,
                                label: 'PRESENTASE',
                                value: '80%',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 32),

                        // Pengaturan Akun Section Header
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pengaturan akun',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Ganti Nama Button
                        _buildMenuButton(
                          title: 'Ganti Nama',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Fitur Ganti Nama'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 12),

                        // Ganti Sandi Button
                        _buildMenuButton(
                          title: 'Ganti Sandi',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Fitur Ganti Sandi'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 12),

                        // Ganti Email Button
                        _buildMenuButton(
                          title: 'Ganti Email',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Fitur Ganti Email'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 12),

                        // Ajak Teman Button
                        _buildMenuButton(
                          title: 'Ajak teman',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Fitur Ajak Teman'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 12),

                        // Log Out Button
                        _buildMenuButton(
                          title: 'Log out',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('Konfirmasi'),
                                content: Text(
                                  'Apakah Anda yakin ingin keluar?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/sign-in',
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'Keluar',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 40), // Extra space for bottom nav
                      ],
                    ),
                  ),

                  // Avatar positioned to overlap at the top
                  Positioned(
                    top: -60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFC4D6),
                          border: Border.all(color: Colors.white, width: 6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.emoji_emotions,
                                size: 60,
                                color: Color(0xFF8B4789),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2C2C2C),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white,
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
            ),
          ],
        ),
      ),
    );
  }

  // Stats Item Widget
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.black87),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Menu Button Widget
  Widget _buildMenuButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Color(0xfff8843f).withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD4A574).withValues(alpha: 0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.play_arrow, color: Colors.black87, size: 28),
          ],
        ),
      ),
    );
  }
}
