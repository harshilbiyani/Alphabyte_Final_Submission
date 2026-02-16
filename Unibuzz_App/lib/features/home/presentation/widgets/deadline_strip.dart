import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

/// Upcoming deadlines with draining progress bars creating urgency.
class DeadlineStrip extends StatelessWidget {
  const DeadlineStrip({super.key});

  static final List<_DeadlineItem> _items = [
    _DeadlineItem(
      title: 'Hackathon 24 Registration',
      timeLeft: '2 days left',
      progress: 0.7,
      urgency: _Urgency.high,
      icon: Icons.code_rounded,
    ),
    _DeadlineItem(
      title: 'AI Workshop — Limited Seats',
      timeLeft: '3 days left',
      progress: 0.55,
      urgency: _Urgency.medium,
      icon: Icons.smart_toy_rounded,
    ),
    _DeadlineItem(
      title: 'Cultural Fest Early Bird',
      timeLeft: '5 days left',
      progress: 0.3,
      urgency: _Urgency.low,
      icon: Icons.theater_comedy_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.timer_rounded, size: 18, color: AppColors.warning),
              const SizedBox(width: 6),
              Text(
                'DEADLINES APPROACHING',
                style: GoogleFonts.racingSansOne(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...List.generate(_items.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DeadlineCard(item: _items[i])
                  .animate(delay: (100 * i).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.05, end: 0, curve: Curves.easeOut),
            );
          }),
        ],
      ),
    );
  }
}

class _DeadlineCard extends StatelessWidget {
  final _DeadlineItem item;
  const _DeadlineCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final Color urgencyColor = switch (item.urgency) {
      _Urgency.high => AppColors.error,
      _Urgency.medium => AppColors.warning,
      _Urgency.low => AppColors.accent,
    };

    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(14),
        blur: 10,
        opacity: 0.05,
        padding: const EdgeInsets.all(14),
        border: Border.all(color: urgencyColor.withValues(alpha: 0.15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: urgencyColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: urgencyColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.timeLeft,
                        style: TextStyle(
                          color: urgencyColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: urgencyColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: urgencyColor.withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    'Register →',
                    style: TextStyle(
                      color: urgencyColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: [
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  FractionallySizedBox(
                    widthFactor: item.progress,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            urgencyColor.withValues(alpha: 0.6),
                            urgencyColor,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: urgencyColor.withValues(alpha: 0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .shimmer(
                        color: Colors.white.withValues(alpha: 0.3),
                        duration: 2000.ms,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _Urgency { high, medium, low }

class _DeadlineItem {
  final String title;
  final String timeLeft;
  final double progress;
  final _Urgency urgency;
  final IconData icon;

  const _DeadlineItem({
    required this.title,
    required this.timeLeft,
    required this.progress,
    required this.urgency,
    required this.icon,
  });
}
