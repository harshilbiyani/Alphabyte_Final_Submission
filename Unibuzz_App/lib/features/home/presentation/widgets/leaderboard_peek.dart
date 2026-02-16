import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

/// Leaderboard peek — gamified top buzzers section with your rank highlighted.
class LeaderboardPeek extends StatelessWidget {
  const LeaderboardPeek({super.key});

  static const List<_RankerItem> _topRankers = [
    _RankerItem(name: 'Aarav M.', points: 420, avatar: '🥇', rank: 1),
    _RankerItem(name: 'Priya S.', points: 380, avatar: '🥈', rank: 2),
    _RankerItem(name: 'Rishi K.', points: 350, avatar: '🥉', rank: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(20),
        blur: 14,
        opacity: 0.06,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        glowColor: AppColors.primary,
        glowIntensity: 0.05,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Text('👑', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 6),
                  Text(
                    'TOP BUZZERS',
                    style: GoogleFonts.racingSansOne(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'THIS MONTH',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Top 3 rankers
              ...List.generate(_topRankers.length, (i) {
                return _RankerRow(item: _topRankers[i])
                    .animate(delay: (80 * i).ms)
                    .fadeIn(duration: 350.ms)
                    .slideX(begin: -0.04, end: 0);
              }),
              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.0),
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Your rank — highlighted
              GlassContainer(
                borderRadius: BorderRadius.circular(12),
                blur: 8,
                opacity: 0.08,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
                glowColor: AppColors.accent,
                glowIntensity: 0.08,
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '#12',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'You',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '180 pts',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.trending_up_rounded, color: AppColors.success, size: 18),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .shimmer(color: AppColors.accent.withValues(alpha: 0.1), duration: 2000.ms, delay: 600.ms),
              const SizedBox(height: 12),
              // CTA
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Center(
                  child: Text(
                    'View Full Leaderboard →',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RankerRow extends StatelessWidget {
  final _RankerItem item;
  const _RankerRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final Color rankColor = switch (item.rank) {
      1 => const Color(0xFFFFD700),
      2 => const Color(0xFFC0C0C0),
      3 => const Color(0xFFCD7F32),
      _ => Colors.white54,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Rank emoji
          SizedBox(
            width: 28,
            child: Text(
              item.avatar,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          // Rank bar (visual weight)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    color: rankColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                // Mini progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Stack(
                    children: [
                      Container(
                        height: 3,
                        width: double.infinity,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                      FractionallySizedBox(
                        widthFactor: (item.points / 500).clamp(0.0, 1.0),
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                rankColor.withValues(alpha: 0.3),
                                rankColor,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: rankColor.withValues(alpha: 0.4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${item.points} pts',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankerItem {
  final String name;
  final int points;
  final String avatar;
  final int rank;

  const _RankerItem({
    required this.name,
    required this.points,
    required this.avatar,
    required this.rank,
  });
}
