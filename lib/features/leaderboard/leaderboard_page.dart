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

                        // Top 3 Podium (with cloud integrated)
                        _buildPodium(),

                        const SizedBox(height: 30),

                        // Leaderboard List
                        _buildLeaderboardList(),

                        const SizedBox(
                          height: 80,
                        ), // Space for fixed user card and bottom nav
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Fixed User Card at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 60, // Space for bottom navigation bar
            child: _buildCurrentUserCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B3A3A), Color(0xFFB85C52)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
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
      height: 340, // Increased to accommodate cloud overlap
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Cloud decoration - BEHIND everything (drawn first)
          Positioned(
            left: 0,
            right: 0,
            bottom: 20, // Slightly lower to overlap with list
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Image.asset(
                'assets/images/cloud.png',
                fit: BoxFit.fill, // Use fill to cover full width
                // errorBuilder: (context, error, stackTrace) {
                //   return CustomPaint(painter: CloudPainter());
                // },
              ),
            ),
          ),

          // Second Place (Left)
          Positioned(
            left: 20,
            bottom: 40,
            child: _buildPodiumItem(
              rank: 2,
              username: 'adalahpokoknya',
              score: 12500,
              avatarAsset: 'assets/images/character_game.png',
              wingsAsset: 'assets/images/rank_2.png',
              podiumColor: const Color(0xFFC0C0C0),
            ),
          ),

          // First Place (Center) - Larger and higher
          Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: _buildPodiumItem(
              rank: 1,
              username: 'keisya_pfp',
              score: 8450,
              avatarAsset: 'assets/images/character_game.png',
              wingsAsset: 'assets/images/rank_1.png',
              podiumColor: const Color(0xFFFFD700),
              isFirst: true,
            ),
          ),

          // Third Place (Right)
          Positioned(
            right: 20,
            bottom: 40,
            child: _buildPodiumItem(
              rank: 3,
              username: 'Najwa_Miniww',
              score: 6370,
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
    final size = isFirst ? 89.0 : 75.0;
    final badgeSize = isFirst ? 180.0 : 120.0;

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
              // Avatar circle - BEHIND (drawn first)
              Positioned(
                left: (badgeSize - size) / 2,
                top: (badgeSize - size) / 2 - 10,
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
                  // errorBuilder: (context, error, stackTrace) {
                  //   return CustomPaint(
                  //     size: Size(badgeSize, badgeSize),
                  //     painter: WingsPainter(color: podiumColor),
                  //   );
                  // },
                ),
              ),

              // Score badge at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: isFirst ? 32 : 32,
                child: Center(
                  child: Stack(
                    children: [
                      // Stroke/Border text
                      Text(
                        score.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth =
                                3 // ketebalan border
                            ..color = rank == 1
                                ? const Color(
                                    0xFFB8860B,
                                  ) // gold dark untuk rank 1
                                : rank == 2
                                ? const Color(0xFF808080) // gray untuk rank 2
                                : const Color(0xfff7d9bc), // brown untuk rank 3
                          fontSize: isFirst ? 28 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Fill text
                      Text(
                        score.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: rank == 1
                              ? const Color(0xfff9eda5)
                              : rank == 2
                              ? const Color(0xffe7e7e7)
                              : const Color(0xffce8946),
                          fontSize: isFirst ? 28 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Username
        Transform.translate(
          offset: const Offset(0, -25), // geser ke atas 15 pixel
          child: SizedBox(
            width: badgeSize + 10,
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
        ),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    final leaderboardData = [
      LeaderboardEntry(rank: 1, username: 'keisya_pfp', score: 12500),
      LeaderboardEntry(rank: 2, username: 'adalahpokoknya', score: 8450),
      LeaderboardEntry(rank: 3, username: 'Najwa_Miniww', score: 6370),
      LeaderboardEntry(rank: 4, username: 'nimiwisa_laber', score: 4220),
      LeaderboardEntry(rank: 5, username: 'nimiwisa_laber', score: 3400),
      LeaderboardEntry(rank: 6, username: 'nimiwisa_laber', score: 2500),
      LeaderboardEntry(rank: 7, username: 'nimiwisa_laber', score: 1580),
      LeaderboardEntry(rank: 8, username: 'nimiwisa_laber', score: 1200),
      LeaderboardEntry(rank: 9, username: 'nimiwisa_laber', score: 1100),
      LeaderboardEntry(rank: 10, username: 'nimiwisa_laber', score: 1000),
      LeaderboardEntry(rank: 11, username: 'nimiwisa_laber', score: 900),
      LeaderboardEntry(rank: 12, username: 'nimiwisa_laber', score: 800),
      LeaderboardEntry(rank: 13, username: 'nimiwisa_laber', score: 700),
      LeaderboardEntry(rank: 14, username: 'nimiwisa_laber', score: 600),
      LeaderboardEntry(rank: 15, username: 'nimiwisa_laber', score: 500),
      LeaderboardEntry(rank: 16, username: 'nimiwisa_laber', score: 300),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: leaderboardData.map((entry) {
          return _buildLeaderboardCard(entry);
        }).toList(),
      ),
    );
  }

  Widget _buildLeaderboardCard(LeaderboardEntry entry) {
    // final isCurrentUser = entry.username == currentUsername;

    // Color dan Gradient yang ada di rank
    Gradient? cardGradient;
    Color? cardColor;

    if (entry.rank == 1) {
      // Gold gradient
      cardGradient = const LinearGradient(
        colors: [Color(0xffffe802), Color(0xffffce00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (entry.rank == 2) {
      // Silver gradient
      cardGradient = const LinearGradient(
        colors: [Color(0xffebecf0), Color(0xffbec0c2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (entry.rank == 3) {
      // Bronze gradient
      cardGradient = const LinearGradient(
        colors: [Color(0xffc18563), Color(0xff9c7a3c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      // Plain white for others
      cardColor = Colors.white;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        gradient: cardGradient,
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: entry.rank <= 3
              ? const Color.fromARGB(255, 200, 110, 92).withValues(alpha: 0.4)
              : const Color(0xffffd9cc),
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
            width: 20,
            child: Text(
              entry.rank.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF270F0F),
              ),
            ),
          ),

          const SizedBox(width: 8),

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
                fontSize: 14,
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
    return Container(
      // Background dikosongkan
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B3A3A), Color(0xFFB85C52)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(2, 6),
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
                  color: Color(0xfff7d9bc),
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
                  color: Color(0xfff7d9bc),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Score
            const Text(
              '6370',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xfff7d9bc),
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
        const Color(0xFFFFE8D6),
        const Color(0xffd2947b),
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

    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final starSize = 3.0 + random.nextDouble() * 4;

      // Random color for sprinkles (white, light pink, light yellow)
      final colors = [
        // Colors.white.withValues(alpha: 0.7),
        // const Color(0xFFFFE0E0).withValues(alpha: 0.5),
        // const Color(0xFFFFFFCC).withValues(alpha: 0.5),
        Colors.white,
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

// class CloudPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     // Create wavy cloud shape
//     path.moveTo(0, size.height * 0.5);

//     for (double i = 0; i <= size.width; i += 30) {
//       final wave = math.sin((i / size.width) * math.pi * 4) * 10;
//       path.lineTo(i, size.height * 0.5 + wave);
//     }

//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);

//     // Add some cloud circles
//     final circlePaint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.3)
//       ..style = PaintingStyle.fill;

//     for (double i = 0; i < size.width; i += 60) {
//       canvas.drawCircle(Offset(i + 15, size.height * 0.3), 15, circlePaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class WingsPainter extends CustomPainter {
//   final Color color;

//   WingsPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     // Left wing
//     path.moveTo(size.width * 0.3, size.height * 0.5);
//     path.quadraticBezierTo(
//       0,
//       size.height * 0.3,
//       size.width * 0.1,
//       size.height * 0.8,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.2,
//       size.height * 0.6,
//       size.width * 0.3,
//       size.height * 0.5,
//     );

//     // Right wing
//     path.moveTo(size.width * 0.7, size.height * 0.5);
//     path.quadraticBezierTo(
//       size.width,
//       size.height * 0.3,
//       size.width * 0.9,
//       size.height * 0.8,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.8,
//       size.height * 0.6,
//       size.width * 0.7,
//       size.height * 0.5,
//     );

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
