import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../home/data/mock_home_data.dart';
import '../widgets/search_event_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  final Set<String> _selectedFilters = {};

  final List<String> _filterOptions = [
    'Technical',
    'Cultural',
    'Sports',
    'Gaming',
    'Workshop',
    'Interested',
    'Ending Soon',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<EventModel> get _searchResults {
    final all = [...MockHomeData.urgentEvents, ...MockHomeData.feedEvents];

    List<EventModel> results = all;
    if (_query.isNotEmpty) {
      final lowerQuery = _query.toLowerCase();
      results = results.where((e) {
        return e.title.toLowerCase().contains(lowerQuery) ||
            e.description.toLowerCase().contains(lowerQuery) ||
            e.category.toLowerCase().contains(lowerQuery) ||
            e.department.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    if (_selectedFilters.isNotEmpty) {
      results = results.where((e) {
        bool matchesCategory = true;
        bool matchesStatus = true;

        final categoryFilters = _selectedFilters
            .where((f) => !['Interested', 'Ending Soon'].contains(f))
            .toList();

        if (categoryFilters.isNotEmpty) {
          matchesCategory = categoryFilters.any((filter) {
            if (filter == 'Technical') {
              return ['Tech', 'Coding'].contains(e.category);
            }
            if (filter == 'Cultural') {
              return ['Cultural', 'Music', 'Entertainment'].contains(e.category);
            }
            return e.category == filter;
          });
        }

        if (_selectedFilters.contains('Interested') && !e.isInterested) {
          matchesStatus = false;
        }
        if (_selectedFilters.contains('Ending Soon') && !e.isEndingSoon) {
          matchesStatus = false;
        }

        return (categoryFilters.isEmpty || matchesCategory) && matchesStatus;
      }).toList();
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final results = _searchResults;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient glow
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                elevation: 0,
                expandedHeight: 80,
                collapsedHeight: 80,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.black.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: const Text(
                        'SEARCH EVENTS',
                        style: TextStyle(
                          fontFamily: 'Racing Sans One',
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: _buildSearchBar(),
                    ),
                    _buildFilterChips(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              if (results.isEmpty)
                _buildEmptyState()
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SearchEventCard(event: results[index])
                          .animate()
                          .fade(duration: 400.ms, delay: (60 * index).ms)
                          .slideY(begin: 0.05, end: 0, curve: Curves.easeOut);
                    },
                    childCount: results.length,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      blur: 10,
      opacity: 0.08,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.08),
          blurRadius: 15,
          spreadRadius: 0,
        ),
      ],
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        cursorColor: AppColors.accent,
        onChanged: (val) => setState(() => _query = val),
        decoration: InputDecoration(
          hintText: "Search events, domains...",
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _filterOptions.map((filter) {
          final bool isSelected = _selectedFilters.contains(filter);
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedFilters.remove(filter);
                } else {
                  _selectedFilters.add(filter);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accent
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accent
                      : Colors.white.withValues(alpha: 0.12),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.3),
                          blurRadius: 10,
                        )
                      ]
                    : [],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _query.isEmpty ? Icons.travel_explore : Icons.search_off,
              size: 60,
              color: Colors.white10,
            ),
            const SizedBox(height: 16),
            Text(
              _query.isEmpty
                  ? "Explore upcoming vibes..."
                  : "No events found for '$_query'",
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
            if (_selectedFilters.isNotEmpty && _query.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                  onPressed: () => setState(() => _selectedFilters.clear()),
                  child: const Text("Clear Filters",
                      style: TextStyle(color: AppColors.accent)),
                ),
              ),
          ],
        ).animate().fade(duration: 500.ms),
      ),
    );
  }
}
