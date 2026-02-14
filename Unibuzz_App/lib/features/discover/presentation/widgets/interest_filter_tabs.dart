import 'package:flutter/material.dart';
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
            onTap: () => onTabSelected(tab),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.accent : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  )
                ] : [],
              ),
              child: Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? AppColors.accent : Colors.white60,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
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
