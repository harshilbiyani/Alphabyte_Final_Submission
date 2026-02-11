import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
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
    
    // 1. Text Search
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

    // 2. Chip Filters (AND logic or OR logic? Usually OR within chips if multiple selected, but strictly filtering the subset)
    // Let's do: If any category filter is selected, match one of them.
    // If 'Interested' is selected, MUST be interested.
    
    if (_selectedFilters.isNotEmpty) {
      results = results.where((e) {
        bool matchesCategory = true;
        bool matchesStatus = true;

        // Extract category filters
        final categoryFilters = _selectedFilters.where((f) => 
            !['Interested', 'Ending Soon'].contains(f)).toList();
        
        if (categoryFilters.isNotEmpty) {
           // E.g. 'Tech', 'Music' -> if event.category matches either/or logic or exact mapping
           // Our mock data categories: 'Tech', 'Music', 'Sports', 'Gaming', 'Workshop', 'Cultural'.
           // _filterOptions mismatch slightly ('Technical' vs 'Tech'). Let's map.
           
           matchesCategory = categoryFilters.any((filter) {
               if (filter == 'Technical') return ['Tech', 'Coding'].contains(e.category);
               if (filter == 'Cultural') return ['Cultural', 'Music', 'Entertainment'].contains(e.category);
               return e.category == filter; // Exact match for others
           });
        }

        if (_selectedFilters.contains('Interested')) {
           if (!e.isInterested) matchesStatus = false;
        }
        if (_selectedFilters.contains('Ending Soon')) {
           if (!e.isEndingSoon) matchesStatus = false;
        }

        // If no category filters were active, ignoring category match (it's true)
        // matchesStatus must be true if those filters are active.
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
      body: CustomScrollView(
        slivers: [
          // Sticky Header
          const SliverAppBar(
             backgroundColor: Colors.transparent, // We handle background in flexible space for blur
             pinned: true,
             elevation: 0,
             expandedHeight: 80, 
             collapsedHeight: 80,
             flexibleSpace: _SearchHeader(),
          ),

          // Search Bar & Chips
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

          // Results
          if (results.isEmpty)
             _buildEmptyState()
          else
             SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                   return SearchEventCard(event: results[index]);
                },
                childCount: results.length,
              ),
             ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
           BoxShadow(
             color: AppColors.primary.withOpacity(0.05),
             blurRadius: 10,
             spreadRadius: 0,
           )
        ],
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        cursorColor: const Color(0xFFC6FF33), // Neon Green Cursor
        onChanged: (val) => setState(() => _query = val),
        decoration: InputDecoration(
          hintText: "Search events, domains...",
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          suffixIcon: _query.isNotEmpty ? IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: () {
               _searchController.clear();
               setState(() => _query = '');
            },
          ) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFC6FF33) : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFFC6FF33) : Colors.white.withOpacity(0.15),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
         padding: const EdgeInsets.only(top: 50),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(
                _query.isEmpty ? Icons.travel_explore : Icons.search_off, 
                size: 60, 
                color: Colors.white10
             ),
             const SizedBox(height: 16),
             Text(
               _query.isEmpty 
                   ? "Explore upcoming vibes..." 
                   : "No events found for '$_query'",
               style: TextStyle(color: Colors.white.withOpacity(0.5)),
             ),
             if (_selectedFilters.isNotEmpty && _query.isNotEmpty)
               Padding(
                 padding: const EdgeInsets.only(top: 8.0),
                 child: TextButton(
                    onPressed: () => setState(() => _selectedFilters.clear()),
                    child: const Text("Clear Filters", style: TextStyle(color: Color(0xFFC6FF33))),
                 ),
               )
           ],
         ),
       ),
     );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(   // Clip blur
       child: BackdropFilter(
         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
         child: Container(
             color: AppColors.background.withOpacity(0.8),
             alignment: Alignment.centerLeft,
             padding: const EdgeInsets.only(left: 20, top: 40), // status bar padding
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
    );
  }
}
