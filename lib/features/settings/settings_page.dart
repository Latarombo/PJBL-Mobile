import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _volumeSuara = true;
  bool _deringPonsel = true;
  bool _notifikasi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Image Background - Full Width & Top
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_profilePage.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.black.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Pengaturan',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Settings Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),

                  // Volume Suara Toggle
                  _buildToggleCard(
                    icon: Icons.volume_up,
                    title: 'Volume suara',
                    value: _volumeSuara,
                    onChanged: (value) {
                      setState(() => _volumeSuara = value);
                    },
                  ),

                  SizedBox(height: 12),

                  // Dering Ponsel Toggle
                  _buildToggleCard(
                    icon: Icons.phone_android,
                    title: 'Dering ponsel',
                    value: _deringPonsel,
                    onChanged: (value) {
                      setState(() => _deringPonsel = value);
                    },
                  ),

                  SizedBox(height: 12),

                  // Notifikasi Toggle
                  _buildToggleCard(
                    icon: Icons.notifications,
                    title: 'Notifikasi',
                    value: _notifikasi,
                    onChanged: (value) {
                      setState(() => _notifikasi = value);
                    },
                  ),

                  SizedBox(height: 12),

                  // Buku Panduan Navigation
                  _buildNavigationCard(
                    icon: Icons.menu_book,
                    title: 'Buku panduan',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Buku panduan akan segera hadir'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 24),

                  // Lainnya Section Header
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: Text(
                      'Lainnya',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Tentang Kami Navigation
                  _buildNavigationCard(
                    title: 'Tentang Kami',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Halaman Tentang Kami'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 12),

                  // Kontak Kami Navigation
                  _buildNavigationCard(
                    title: 'Kontak Kami',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Halaman Kontak Kami'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 12),

                  // Email Kami Navigation
                  _buildNavigationCard(
                    title: 'Email Kami',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Halaman Email Kami'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 12),

                  // Bantuan & Dukungan Navigation
                  _buildNavigationCard(
                    title: 'Bantuan & Dukungan',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Halaman Bantuan & Dukungan'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 100), // Extra space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color(0xfff8843f).withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD4A574).withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black87,
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF8B5A3C),
            activeTrackColor: Color(0xFFE8B88A),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard({
    IconData? icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Color(0xfff8843f).withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD4A574).withValues(alpha: 0.15),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.black87,
                size: 24,
              ),
              SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}