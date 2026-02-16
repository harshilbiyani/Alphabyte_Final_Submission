import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_club_data.dart';
import '../widgets/club_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/filter_sort_bar.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  static const Color _accent = Color(0xFFFF7043);

  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _sortBy = 'Popular';
  String _searchQuery = '';

  final List<String> _categories = ['All', 'Technical', 'Cultural', 'Sports', 'Social', 'Media'];

  List<ClubModel> get _filteredClubs {
    var list = MockClubData.clubs.toList();

    if (_selectedCategory != 'All') {
      list = list.where((c) => c.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((c) =>
          c.name.toLowerCase().contains(q) ||
          c.category.toLowerCase().contains(q) ||
          c.tags.any((t) => t.toLowerCase().contains(q))).toList();
    }

    switch (_sortBy) {
      case 'Popular':
        list.sort((a, b) => b.memberCount.compareTo(a.memberCount));
        break;
      case 'Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Recruiting':
        list.sort((a, b) {
          if (a.isRecruiting && !b.isRecruiting) return -1;
          if (!a.isRecruiting && b.isRecruiting) return 1;
          return 0;
        });
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
    final clubs = _filteredClubs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              Icon(Icons.groups_rounded, color: _accent, size: 15),
                              const SizedBox(width: 5),
                              Text(
                                '${MockClubData.clubs.length} Clubs',
                                style: GoogleFonts.poppins(color: _accent, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [_accent, Color(0xFFFFAB91), Color(0xFFFFCC80)],
                      ).createShader(bounds),
                      child: Text(
                        'Clubs',
                        style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1),
                      ),
                    ),
                    Text(
                      'Find your tribe. Join the vibe. 🤝',
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(.5), fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    GlassContainer(
                      borderRadius: BorderRadius.circular(16),
                      opacity: .07,
                      blur: 14,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search clubs, categories, tags…',
                          hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                          prefixIcon: Icon(Icons.search_rounded, color: _accent.withOpacity(.7)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
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
                      sortOptions: const ['Popular', 'Rating', 'Recruiting'],
                      selectedSort: _sortBy,
                      onSortSelected: (v) => setState(() => _sortBy = v),
                      accentColor: _accent,
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms),

            if (clubs.isEmpty)
              SliverFillRemaining(
                child: EmptyStateWidget(
                  icon: Icons.groups_rounded,
                  title: 'No clubs found',
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
                      child: ClubCard(club: clubs[i]),
                    ),
                    childCount: clubs.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
