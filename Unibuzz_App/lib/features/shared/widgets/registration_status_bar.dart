import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Shows registration progress: "23/32 slots filled".
class RegistrationStatusBar extends StatelessWidget {
  final int filled;
  final int total;
  final Color color;

  const RegistrationStatusBar({
    super.key,
    required this.filled,
    required this.total,
    this.color = AppColors.accent,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? (filled / total).clamp(0.0, 1.0) : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$filled / $total spots',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (progress >= 0.9)
              Text(
                'Almost Full!',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: Colors.white.withValues(alpha: 0.06),
            valueColor: AlwaysStoppedAnimation(
              progress >= 0.9 ? AppColors.error : color,
            ),
          ),
        ),
      ],
    );
  }
}
