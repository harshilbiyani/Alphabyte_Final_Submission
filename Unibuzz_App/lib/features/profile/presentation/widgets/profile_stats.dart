import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_profile_data.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard('Registered', MockProfileData.stats['Registered']!, AppColors.accent),
          _buildStatCard('Attended', MockProfileData.stats['Attended']!, AppColors.primary),
          _buildStatCard('Upcoming', MockProfileData.stats['Upcoming']!, const Color(0xFF00E5FF)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int value, Color accentColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: 0.06,
          color: accentColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          border: Border.all(color: accentColor.withValues(alpha: 0.15)),
          child: Column(
            children: [
              Text(
                value.toString(),
                style: TextStyle(
                  color: accentColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Racing Sans One',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().scaleXY(begin: 0.8, end: 1.0, duration: 500.ms, curve: Curves.easeOutBack);
  }
}
