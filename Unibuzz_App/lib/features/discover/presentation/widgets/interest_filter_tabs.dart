import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class InterestFilterTabs extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;

  const InterestFilterTabs({
    super.key, 
    required this.selectedTab, 
    required this.onTabSelected
  });

  final List<String> tabs = const [
    'All',
    'Technical',
    'Non-Technical',
    'Sports',
    'Gaming',
    'Guest Lectures',
    'Cultural',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab == selectedTab;
          
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              onTabSelected(tab);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.accent.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    blurRadius: 10,
                  )
                ] : [],
              ),
              child: Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? AppColors.accent : Colors.white.withValues(alpha: 0.5),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
