import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

/// Happening Now — real-time live activity feed with pulsing indicators.
class LiveActivityFeed extends StatelessWidget {
  const LiveActivityFeed({super.key});

  static final List<_LiveItem> _items = [
    _LiveItem(
      title: 'CodeSprint 2.0',
      status: LiveStatus.live,
      subtitle: 'Round 2 in progress',
      detail: '142 participants battling it out',
      icon: Icons.code_rounded,
      accentColor: AppColors.error,
      actionLabel: 'Watch Stream',
      actionIcon: Icons.play_circle_filled_rounded,
    ),
    _LiveItem(
      title: 'TechTalk: AI/ML Workshop',
      status: LiveStatus.startingSoon,
      subtitle: 'Starting in 23 min',
      detail: 'Prof. Sharma — Seminar Hall B',
      icon: Icons.smart_toy_rounded,
      accentColor: AppColors.warning,
      actionLabel: 'Set Reminder',
      actionIcon: Icons.notifications_active_rounded,
    ),
    _LiveItem(
      title: 'Basketball Finals',
      status: LiveStatus.justEnded,
      subtitle: 'Ended 10 min ago',
      detail: 'CSE won 78-65 vs ECE',
      icon: Icons.sports_basketball_rounded,
      accentColor: AppColors.textTertiary,
      actionLabel: 'View Results',
      actionIcon: Icons.arrow_forward_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Icon(Icons.bolt_rounded, size: 18, color: AppColors.accent),
              const SizedBox(width: 6),
              Text(
                'HAPPENING NOW',
                style: GoogleFonts.racingSansOne(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              // Live pulse dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.error.withValues(alpha: 0.6), blurRadius: 6),
                  ],
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(begin: 1.0, end: 1.5, duration: 800.ms),
            ],
          ),
          const SizedBox(height: 14),
          // Activity items
          ...List.generate(_items.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _LiveActivityCard(item: _items[i])
                  .animate(delay: (100 * i).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: 0.05, end: 0, curve: Curves.easeOut),
            );
          }),
        ],
      ),
    );
  }
}

class _LiveActivityCard extends StatelessWidget {
  final _LiveItem item;
  const _LiveActivityCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        blur: 12,
        opacity: 0.06,
        padding: const EdgeInsets.all(14),
        border: Border.all(
          color: item.accentColor.withValues(alpha: 0.25),
          width: 1,
        ),
        glowColor: item.accentColor,
        glowIntensity: item.status == LiveStatus.live ? 0.12 : 0.0,
        child: Row(
          children: [
            // Status icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: item.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: item.accentColor.withValues(alpha: 0.25)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(item.icon, color: item.accentColor, size: 22),
                  if (item.status == LiveStatus.live)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.error.withValues(alpha: 0.8),
                                blurRadius: 4),
                          ],
                        ),
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scaleXY(begin: 1.0, end: 1.4, duration: 600.ms),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _StatusBadge(status: item.status),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: item.accentColor.withValues(alpha: 0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.detail,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Action
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: item.accentColor.withValues(alpha: 0.2)),
              ),
              child: Icon(item.actionIcon, color: item.accentColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final LiveStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (String label, Color color) = switch (status) {
      LiveStatus.live => ('LIVE', AppColors.error),
      LiveStatus.startingSoon => ('SOON', AppColors.warning),
      LiveStatus.justEnded => ('ENDED', AppColors.textTertiary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

enum LiveStatus { live, startingSoon, justEnded }

class _LiveItem {
  final String title;
  final LiveStatus status;
  final String subtitle;
  final String detail;
  final IconData icon;
  final Color accentColor;
  final String actionLabel;
  final IconData actionIcon;

  const _LiveItem({
    required this.title,
    required this.status,
    required this.subtitle,
    required this.detail,
    required this.icon,
    required this.accentColor,
    required this.actionLabel,
    required this.actionIcon,
  });
}
