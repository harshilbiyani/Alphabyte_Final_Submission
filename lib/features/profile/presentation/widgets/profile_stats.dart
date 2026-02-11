import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/mock_profile_data.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard('Registered', MockProfileData.stats['Registered']!),
          _buildStatCard('Attended', MockProfileData.stats['Attended']!),
          _buildStatCard('Upcoming', MockProfileData.stats['Upcoming']!),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                color: Color(0xFFC6FF33),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Racing Sans One',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(delay: 200.ms);
  }
}
