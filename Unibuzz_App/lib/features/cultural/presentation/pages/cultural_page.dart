import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_cultural_data.dart';
import '../widgets/cultural_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/filter_sort_bar.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class CulturalPage extends StatefulWidget {
  const CulturalPage({super.key});

  @override
  State<CulturalPage> createState() => _CulturalPageState();
}

class _CulturalPageState extends State<CulturalPage> {
  static const Color _accent = Color(0xFFFF6B9D);

  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _sortBy = 'Trending';
  String _searchQuery = '';

  final List<String> _categories = ['All', 'Dance', 'Music', 'Drama', 'Art', 'Literature', 'Fashion'];

  List<CulturalEventModel> get _filteredEvents {
    var list = MockCulturalData.events.toList();

    if (_selectedCategory != 'All') {
      list = list.where((e) => e.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((e) =>
          e.title.toLowerCase().contains(q) ||
          e.category.toLowerCase().contains(q) ||
          e.venue.toLowerCase().contains(q)).toList();
    }

    switch (_sortBy) {
      case 'Trending':
        list.sort((a, b) => b.interestedCount.compareTo(a.interestedCount));
        break;
      case 'Date':
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 'Fee: Low':
        list.sort((a, b) => a.fee.compareTo(b.fee));
        break;
      case 'Fee: High':
        list.sort((a, b) => b.fee.compareTo(a.fee));
        break;
    }

    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back row
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: GlassContainer(
                            borderRadius: BorderRadius.circular(14),
                            opacity: .08,
                            blur: 12,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(Icons.arrow_back_ios_new_rounded, color: _accent, size: 18),
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Interested count badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _accent.withOpacity(.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: _accent.withOpacity(.25)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.favorite_rounded, color: _accent, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                '${MockCulturalData.events.fold<int>(0, (s, e) => s + e.interestedCount)} interested',
                                style: GoogleFonts.poppins(color: _accent, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Title
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [_accent, Color(0xFFFF8A65), Color(0xFFFFC107)],
                      ).createShader(bounds),
                      child: Text(
                        'Cultural',
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ),
                    Text(
                      'Express. Perform. Celebrate. 🎭',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Search bar
                    GlassContainer(
                      borderRadius: BorderRadius.circular(16),
                      opacity: .07,
                      blur: 14,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search events, categories, venues…',
                          hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                          prefixIcon: Icon(Icons.search_rounded, color: _accent.withOpacity(.7)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Category chips
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final cat = _categories[i];
                          final selected = cat == _selectedCategory;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedCategory = cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: selected ? _accent : Colors.white.withOpacity(.06),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: selected ? _accent : Colors.white.withOpacity(.1)),
                              ),
                              child: Text(
                                cat,
                                style: GoogleFonts.poppins(
                                  color: selected ? Colors.white : Colors.white.withOpacity(.6),
                                  fontSize: 12,
                                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilterSortBar(
                      filters: const [],
                      selectedFilter: '',
                      onFilterSelected: (_) {},
                      sortOptions: const ['Trending', 'Date', 'Fee: Low', 'Fee: High'],
                      selectedSort: _sortBy,
                      onSortSelected: (v) => setState(() => _sortBy = v),
                      accentColor: _accent,
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms),

            // ── Events List ──
            if (events.isEmpty)
              SliverFillRemaining(
                child: EmptyStateWidget(
                  icon: Icons.theater_comedy_rounded,
                  title: 'No events found',
                  subtitle: 'Try a different category or search term',
                  color: _accent,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CulturalCard(event: events[i]),
                    ),
                    childCount: events.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
