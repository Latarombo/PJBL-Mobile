import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Pages
import '../features/home/home_page.dart';
import '../features/leaderboard/leaderboard_page.dart';
import '../features/profile/profile_page.dart';
import '../features/settings/settings_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    LeaderboardPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        items: const [
          Icon(Icons.home_rounded, size: 28, color: Color(0xFF8B5A3C)),
          Icon(Icons.gamepad_rounded, size: 28, color: Color(0xFF8B5A3C)),
          Icon(Icons.person_rounded, size: 28, color: Color(0xFF8B5A3C)),
          Icon(Icons.settings_rounded, size: 28, color: Color(0xFF8B5A3C)),
        ],
        color: Color(0xFFFFDDB3),
        buttonBackgroundColor: Color(0xFFE8B88A),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
