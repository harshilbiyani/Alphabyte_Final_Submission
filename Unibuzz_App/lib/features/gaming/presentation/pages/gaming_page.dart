import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_gaming_data.dart';
import '../widgets/gaming_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/filter_sort_bar.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({super.key});

  @override
  State<GamingPage> createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
  static const Color _accent = Color(0xFF7B2FFF);
  static const Color _neonGreen = Color(0xFF39FF14);

  final _searchController = TextEditingController();
  String _selectedGame = 'All';
  String _sortBy = 'Live First';
  String _searchQuery = '';

  final List<String> _games = ['All', 'Valorant', 'BGMI', 'FIFA', 'CS2', 'Tekken'];

  List<GamingEventModel> get _filteredEvents {
    var list = MockGamingData.events.toList();

    if (_selectedGame != 'All') {
      list = list.where((e) => e.game == _selectedGame).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((e) =>
          e.title.toLowerCase().contains(q) ||
          e.game.toLowerCase().contains(q) ||
          e.platform.toLowerCase().contains(q)).toList();
    }

    switch (_sortBy) {
      case 'Live First':
        list.sort((a, b) {
          if (a.isLive && !b.isLive) return -1;
          if (!a.isLive && b.isLive) return 1;
          return 0;
        });
        break;
      case 'Prize Pool':
        // keep live first then by registration
        list.sort((a, b) => b.registeredTeams.compareTo(a.registeredTeams));
        break;
      case 'Slots Left':
        list.sort((a, b) => (a.maxTeams - a.registeredTeams).compareTo(b.maxTeams - b.registeredTeams));
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
                    // Back + Live badge
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
                            border: Border.all(color: _accent.withOpacity(.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.sports_esports_rounded, color: _neonGreen, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                '${MockGamingData.events.length} Tournaments',
                                style: GoogleFonts.poppins(color: _accent, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // RGB-glow title
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [_accent, Color(0xFFE040FB), _neonGreen],
                      ).createShader(bounds),
                      child: Text(
                        'Gaming',
                        style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1),
                      ),
                    ),
                    Text(
                      'Play. Compete. Dominate. 🎮',
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(.5), fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    // Search
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _accent.withOpacity(.2)),
                        boxShadow: [BoxShadow(color: _accent.withOpacity(.06), blurRadius: 12)],
                      ),
                      child: GlassContainer(
                        borderRadius: BorderRadius.circular(16),
                        opacity: .07,
                        blur: 14,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (v) => setState(() => _searchQuery = v),
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Search games, tournaments…',
                            hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                            prefixIcon: Icon(Icons.search_rounded, color: _accent.withOpacity(.7)),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Game chips
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _games.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final game = _games[i];
                          final selected = game == _selectedGame;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedGame = game),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: selected ? _accent : Colors.white.withOpacity(.06),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: selected ? _neonGreen.withOpacity(.6) : Colors.white.withOpacity(.1)),
                                boxShadow: selected ? [BoxShadow(color: _accent.withOpacity(.3), blurRadius: 8)] : [],
                              ),
                              child: Text(
                                game,
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
                      sortOptions: const ['Live First', 'Prize Pool', 'Slots Left'],
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
                  icon: Icons.sports_esports_rounded,
                  title: 'No tournaments found',
                  subtitle: 'Try a different game or search term',
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
                      child: GamingCard(event: events[i]),
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
