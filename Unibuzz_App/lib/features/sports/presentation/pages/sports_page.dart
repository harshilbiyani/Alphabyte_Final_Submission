import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_sports_data.dart';
import '../widgets/sports_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/filter_sort_bar.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  static const Color _accent = Color(0xFFFFB800);

  final _searchController = TextEditingController();
  String _selectedSport = 'All';
  String _sortBy = 'Date';
  String _searchQuery = '';

  final List<String> _sports = ['All', 'Cricket', 'Football', 'Basketball', 'Badminton', 'Athletics', 'Chess'];

  List<SportsEventModel> get _filteredEvents {
    var list = MockSportsData.events.toList();

    if (_selectedSport != 'All') {
      list = list.where((e) => e.sport == _selectedSport).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((e) =>
          e.title.toLowerCase().contains(q) ||
          e.sport.toLowerCase().contains(q) ||
          e.venue.toLowerCase().contains(q)).toList();
    }

    // live events first
    list.sort((a, b) {
      if (a.isLive && !b.isLive) return -1;
      if (!a.isLive && b.isLive) return 1;
      return 0;
    });

    switch (_sortBy) {
      case 'Prize Pool':
        // secondary sort keeping live first
        break;
      case 'Slots Left':
        list.sort((a, b) {
          if (a.isLive && !b.isLive) return -1;
          if (!a.isLive && b.isLive) return 1;
          return (a.maxTeams - a.registeredTeams).compareTo(b.maxTeams - b.registeredTeams);
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
    final events = _filteredEvents;

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
                    // Back + live count
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
                        if (MockSportsData.events.any((e) => e.isLive))
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.redAccent.withOpacity(.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
                                const SizedBox(width: 6),
                                Text('Live Now', style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 1, end: .5, duration: 1000.ms),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Title with trophy
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [_accent, Color(0xFFFF8F00), Color(0xFFFFF176)],
                          ).createShader(bounds),
                          child: Text(
                            'Sports',
                            style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('🏆', style: const TextStyle(fontSize: 30)),
                      ],
                    ),
                    Text(
                      'Train. Compete. Conquer.',
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(.5), fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    // Search
                    GlassContainer(
                      borderRadius: BorderRadius.circular(16),
                      opacity: .07,
                      blur: 14,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search sports events…',
                          hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                          prefixIcon: Icon(Icons.search_rounded, color: _accent.withOpacity(.7)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Sport chips
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _sports.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final sport = _sports[i];
                          final selected = sport == _selectedSport;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedSport = sport),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: selected ? _accent : Colors.white.withOpacity(.06),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: selected ? _accent : Colors.white.withOpacity(.1)),
                              ),
                              child: Text(
                                sport,
                                style: GoogleFonts.poppins(
                                  color: selected ? Colors.black87 : Colors.white.withOpacity(.6),
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
                      sortOptions: const ['Date', 'Prize Pool', 'Slots Left'],
                      selectedSort: _sortBy,
                      onSortSelected: (v) => setState(() => _sortBy = v),
                      accentColor: _accent,
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms),

            if (events.isEmpty)
              SliverFillRemaining(
                child: EmptyStateWidget(
                  icon: Icons.sports_rounded,
                  title: 'No events found',
                  subtitle: 'Try a different sport or search term',
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
                      child: SportsCard(event: events[i]),
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
