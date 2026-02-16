import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';

/// Reusable filter/sort bar with horizontal chips + sort dropdown.
class FilterSortBar extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;
  final List<String> sortOptions;
  final String selectedSort;
  final ValueChanged<String> onSortSelected;
  final Color accentColor;

  const FilterSortBar({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.sortOptions = const [],
    this.selectedSort = '',
    this.onSortSelected = _noop,
    this.accentColor = AppColors.primary,
  });

  static void _noop(String _) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (context, index) {
                  final f = filters[index];
                  final isActive = f == selectedFilter;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onFilterSelected(f);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isActive
                            ? accentColor.withValues(alpha: 0.18)
                            : Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isActive
                              ? accentColor.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.07),
                        ),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          color: isActive ? accentColor : Colors.white.withValues(alpha: 0.45),
                          fontSize: 11,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (sortOptions.isNotEmpty) ...[
            const SizedBox(width: 8),
            _buildSortDropdown(context),
          ],
        ],
      ),
    );
  }

  Widget _buildSortDropdown(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSortSelected,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      offset: const Offset(0, 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sort_rounded, color: accentColor, size: 16),
            const SizedBox(width: 4),
            Text(
              'Sort',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => sortOptions.map((s) {
        return PopupMenuItem(
          value: s,
          child: Row(
            children: [
              if (s == selectedSort)
                Icon(Icons.check_rounded, color: accentColor, size: 16)
              else
                const SizedBox(width: 16),
              const SizedBox(width: 8),
              Text(s, style: const TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
