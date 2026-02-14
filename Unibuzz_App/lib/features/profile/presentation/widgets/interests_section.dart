import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/mock_profile_data.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InterestsSection extends StatefulWidget {
  const InterestsSection({super.key});

  @override
  State<InterestsSection> createState() => _InterestsSectionState();
}

class _InterestsSectionState extends State<InterestsSection> {
  final List<String> _availableInterests = [
    'Technical', 'Cultural', 'Sports', 'Gaming', 'Music', 'Coding', 'Debate', 'Art', 'Dance'
  ];

  late List<String> _userInterests;

  @override
  void initState() {
    super.initState();
    _userInterests = List.from(MockProfileData.interests);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Interests",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.edit, size: 16, color: Colors.white.withValues(alpha: 0.4)),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableInterests.asMap().entries.map((entry) {
              final index = entry.key;
              final interest = entry.value;
              final isSelected = _userInterests.contains(interest);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _userInterests.remove(interest);
                    } else {
                      _userInterests.add(interest);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent
                        : Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent
                          : Colors.white.withValues(alpha: 0.12),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.25),
                              blurRadius: 8,
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    interest,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ).animate().fade(delay: (40 * index).ms, duration: 300.ms).scaleXY(begin: 0.9, end: 1);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
