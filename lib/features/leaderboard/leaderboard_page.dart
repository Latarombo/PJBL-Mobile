import 'package:flutter/material.dart';
import 'dart:math' as math;

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  // Hardcoded current user
  static const String currentUsername = 'Najwa_Miniww';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4E4),
      body: Stack(
        children: [
          // Background with gradient and decorative elements
          Positioned.fill(
            child: CustomPaint(painter: LeaderboardBackgroundPainter()),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Top 3 Podium
                        _buildPodium(),

                        const SizedBox(height: 40),

                        // Cloud decoration (transition between podium and list)
                        _buildCloudDecoration(),

                        const SizedBox(height: 20),

                        // Leaderboard List
                        _buildLeaderboardList(),

                        const SizedBox(height: 20),

                        // Current User Card (sticky at bottom)
                        _buildCurrentUserCard(),

                        const SizedBox(height: 100), // Space for bottom nav
                      ],
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

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B3A3A), Color(0xFFB85C52)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.public, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Text(
            'PERINGKAT GLOBAL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodium() {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          // Second Place (Left)
          Positioned(
            left: 20,
            bottom: 0,
            child: _buildPodiumItem(
              rank: 2,
              username: 'adalahpokoknya',
              score: 1500,
              avatarAsset: 'assets/images/character_game.png',
              wingsAsset: 'assets/images/rank_2.png',
              podiumColor: const Color(0xFFC0C0C0),
            ),
          ),

          // First Place (Center) - Larger and higher
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: _buildPodiumItem(
              rank: 1,
              username: 'kelsya_pfp',
              score: 1500,
              avatarAsset: 'assets/images/character_game.png',
              wingsAsset: 'assets/images/rank_1.png',
              podiumColor: const Color(0xFFFFD700),
              isFirst: true,
            ),
          ),

          // Third Place (Right)
          Positioned(
            right: 20,
            bottom: 0,
            child: _buildPodiumItem(
              rank: 3,
              username: 'Najwa_Miniww',
              score: 500,
              avatarAsset: 'assets/images/character_game.png',
              wingsAsset: 'assets/images/rank_3.png',
              podiumColor: const Color(0xFFCD7F32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumItem({
    required int rank,
    required String username,
    required int score,
    required String avatarAsset,
    required String wingsAsset,
    required Color podiumColor,
    bool isFirst = false,
  }) {
    final size = isFirst ? 110.0 : 90.0;
    final badgeSize = isFirst ? 185.0 : 120.0;

    return Column(
      children: [
        // Wings Badge and Avatar Stack
        SizedBox(
          width: badgeSize,
          height: badgeSize + 20,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Avatar circle - BEHIND the badge (drawn first)
              Positioned(
                left: (badgeSize - size) / 2,
                top: (badgeSize - size) / 2,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFC4D6),
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      avatarAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: size * 0.6,
                          color: const Color(0xFF8B4789),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Wings/Badge IN FRONT (drawn second, overlays avatar)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 20,
                child: Image.asset(
                  wingsAsset,
                  width: badgeSize,
                  height: badgeSize,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return CustomPaint(
                      size: Size(badgeSize, badgeSize),
                      painter: WingsPainter(color: podiumColor),
                    );
                  },
                ),
              ),

              // Score badge at bottom (on top of everything)
              Positioned(
                left: 0,
                right: 0,
                bottom: 55,

                child: Text(
                  score.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isFirst ? 30 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 0),

        // Username
        SizedBox(
          width: badgeSize + 20,
          child: Text(
            username,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isFirst ? 14 : 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF270F0F),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCloudDecoration() {
    return SizedBox(
      height: 60,
      child: Image.asset(
                'assets/images/cloud.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.cloud,
                    size: 24,
                    color: Color(0xFF8B4789),
                  );
                },
              ),
    );
  }

  Widget _buildLeaderboardList() {
    final leaderboardData = [
      LeaderboardEntry(rank: 1, username: 'kelsya_pfp', score: 1500),
      LeaderboardEntry(rank: 2, username: 'adalahpokoknya', score: 1450),
      LeaderboardEntry(rank: 3, username: 'Najwa_Miniww', score: 1200),
      LeaderboardEntry(rank: 4, username: 'nimiwisa_laber', score: 100),
      LeaderboardEntry(rank: 5, username: 'nimiwisa_laber', score: 100),
      LeaderboardEntry(rank: 6, username: 'nimiwisa_laber', score: 100),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: leaderboardData.map((entry) {
          return _buildLeaderboardCard(entry);
        }).toList(),
      ),
    );
  }

  Widget _buildLeaderboardCard(LeaderboardEntry entry) {
    final isCurrentUser = entry.username == currentUsername;

    // Color based on rank
    Color cardColor;
    if (entry.rank == 1) {
      cardColor = const Color(0xFFFFF9C4); // Gold tint
    } else if (entry.rank == 2) {
      cardColor = const Color(0xFFE0E0E0); // Silver tint
    } else if (entry.rank == 3) {
      cardColor = const Color(0xFFD7CCC8); // Bronze tint
    } else {
      cardColor = Colors.white;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: entry.rank <= 3
              ? const Color(0xFFD4A574).withValues(alpha: 0.4)
              : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank number
          SizedBox(
            width: 30,
            child: Text(
              entry.rank.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF270F0F),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFC4D6),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/character_game.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 24,
                    color: Color(0xFF8B4789),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Username
          Expanded(
            child: Text(
              entry.username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF270F0F),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 12),

          // Score
          Text(
            entry.score.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF270F0F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentUserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B3A3A), Color(0xFFB85C52)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Rank number
            const SizedBox(
              width: 30,
              child: Text(
                '3',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Avatar
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFC4D6),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/character_game.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      size: 28,
                      color: Color(0xFF8B4789),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 12),

            // "Anda" label
            const Expanded(
              child: Text(
                'Anda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Score
            const Text(
              '1200',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data model
class LeaderboardEntry {
  final int rank;
  final String username;
  final int score;

  LeaderboardEntry({
    required this.rank,
    required this.username,
    required this.score,
  });
}

// Custom Painters
class LeaderboardBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient background
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFF9F4E4),
        const Color(0xFFFFE8D6).withValues(alpha: 0.3),
        const Color(0xFFF9F4E4),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Sprinkles/stars decoration
    final sprinklePaint = Paint()..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent pattern

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final starSize = 3.0 + random.nextDouble() * 4;

      // Random color for sprinkles (white, light pink, light yellow)
      final colors = [
        Colors.white.withValues(alpha: 0.7),
        const Color(0xFFFFE0E0).withValues(alpha: 0.5),
        const Color(0xFFFFFFCC).withValues(alpha: 0.5),
      ];
      sprinklePaint.color = colors[random.nextInt(colors.length)];

      // Draw star
      _drawStar(canvas, Offset(x, y), starSize, sprinklePaint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    const points = 4;

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * math.pi / points) - math.pi / 2;
      final radius = i.isEven ? size : size / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Create wavy cloud shape
    path.moveTo(0, size.height * 0.5);

    for (double i = 0; i <= size.width; i += 30) {
      final wave = math.sin((i / size.width) * math.pi * 4) * 10;
      path.lineTo(i, size.height * 0.5 + wave);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Add some cloud circles
    final circlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    for (double i = 0; i < size.width; i += 60) {
      canvas.drawCircle(Offset(i + 15, size.height * 0.3), 15, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WingsPainter extends CustomPainter {
  final Color color;

  WingsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Left wing
    path.moveTo(size.width * 0.3, size.height * 0.5);
    path.quadraticBezierTo(
      0,
      size.height * 0.3,
      size.width * 0.1,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.6,
      size.width * 0.3,
      size.height * 0.5,
    );

    // Right wing
    path.moveTo(size.width * 0.7, size.height * 0.5);
    path.quadraticBezierTo(
      size.width,
      size.height * 0.3,
      size.width * 0.9,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.6,
      size.width * 0.7,
      size.height * 0.5,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
