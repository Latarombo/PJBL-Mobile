import 'package:flutter/material.dart';
import 'package:santarana/features/home/home_page.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // int _page = 3; // Default ke halaman profile (index 3)
  // final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E7),
      extendBody: true, // Penting untuk curved navigation bar
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_profilePage.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // Dark overlay
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header with back button and title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.arrow_back,
                      //     color: Colors.white,
                      //     size: 24,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(builder: (_) => const HomePage()),
                      //     );
                      //   },
                      //   padding: EdgeInsets.zero,
                      //   constraints: BoxConstraints(),
                      // ),
                      Expanded(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 24), // Balance for back button
                    ],
                  ),
                ),

                SizedBox(height: 8),

                // Profile Avatar and Name Section
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF8E7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 60,
                              ), //seberapa tinggi di sebelah lingkaran
                              // Username
                              Text(
                                'John Doe', // Ganti Posisi Username supaya center dengan avatar profile
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Avatar with edit button - positioned to overlap
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFC4D6),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.emoji_emotions,
                                  size: 50,
                                  color: Color(0xFF8B4789),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2C2C2C),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Stats Card and rest of content
                Expanded(
                  child: Container(
                    color: Color(0xFFFFF8E7),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Stats Card
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
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
                                  height: 45,
                                  color: Colors.grey[300],
                                ),
                                _buildStatItem(
                                  icon: Icons.public,
                                  label: 'TOTAL POIN',
                                  value: '1200',
                                ),
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: Colors.grey[300],
                                ),
                                _buildStatItem(
                                  icon: Icons.trending_up,
                                  label: 'LEVEL',
                                  value: '2',
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 28),

                          // Top 3 Players Section
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildTopPlayer(
                                  rank: 2,
                                  name: 'adalahpokoknya',
                                  points: '1450',
                                  avatarColor: Color(0xFFB8D4A8),
                                ),
                                SizedBox(width: 16),
                                _buildTopPlayer(
                                  rank: 1,
                                  name: 'keisya_pfp',
                                  points: '1500',
                                  avatarColor: Color(0xFF9ACD32),
                                  hasCrown: true,
                                  isWinner: true,
                                ),
                                SizedBox(width: 16),
                                _buildTopPlayer(
                                  rank: 3,
                                  name: 'Anda',
                                  points: '1200',
                                  avatarColor: Color(0xFFFFC4D6),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          // Leaderboard List
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                _buildLeaderboardItem(1, 'keisya_pfp', '1500'),
                                _buildLeaderboardItem(
                                  2,
                                  'adalahpokoknya',
                                  '1450',
                                ),
                                _buildLeaderboardItem(3, 'Anda', '1200'),
                                _buildLeaderboardItem(
                                  4,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                                _buildLeaderboardItem(
                                  5,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                                _buildLeaderboardItem(
                                  6,
                                  'nimiwisa_laber',
                                  '100',
                                  isLast: true,
                                ),
                                _buildLeaderboardItem(
                                  7,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                                _buildLeaderboardItem(
                                  8,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                                _buildLeaderboardItem(
                                  9,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                                _buildLeaderboardItem(
                                  10,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                                _buildLeaderboardItem(
                                  11,
                                  'nimiwisa_laber',
                                  '100',
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 100),
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
    );
  }

  //batas
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: Colors.black87),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
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

  Widget _buildTopPlayer({
    required int rank,
    required String name,
    required String points,
    required Color avatarColor,
    bool hasCrown = false,
    bool isWinner = false,
  }) {
    double avatarSize = isWinner ? 85 : 65;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isWinner)
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text('👑', style: TextStyle(fontSize: 32)),
          ),
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: avatarColor,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: avatarSize * 0.45,
              color: Colors.black45,
            ),
          ),
        ),
        SizedBox(height: 6),
        Container(
          constraints: BoxConstraints(maxWidth: 90),
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(
          points,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(
    int rank,
    String name,
    String points, {
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
        borderRadius: isLast
            ? BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )
            : rank == 1
            ? BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xFFD4B896),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, size: 16, color: Colors.brown[800]),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            points,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
