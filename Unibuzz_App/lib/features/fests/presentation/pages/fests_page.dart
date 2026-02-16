import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_fest_data.dart';
import '../widgets/fest_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class FestsPage extends StatefulWidget {
  const FestsPage({super.key});

  @override
  State<FestsPage> createState() => _FestsPageState();
}

class _FestsPageState extends State<FestsPage> {
  static const Color _accent = Color(0xFFE040FB);

  final _searchController = TextEditingController();
  String _searchQuery = '';

  List<FestModel> get _filteredFests {
    var list = MockFestData.fests.toList();
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((f) =>
          f.name.toLowerCase().contains(q) ||
          f.tagline.toLowerCase().contains(q) ||
          f.highlights.any((h) => h.toLowerCase().contains(q))).toList();
    }
    // live fests first
    list.sort((a, b) {
      if (a.isLive && !b.isLive) return -1;
      if (!a.isLive && b.isLive) return 1;
      return 0;
    });
    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fests = _filteredFests;

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
                        if (MockFestData.fests.any((f) => f.isLive))
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
                                Text('Live Fest!', style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 1, end: .5, duration: 1000.ms),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [_accent, Color(0xFFFF80AB), Color(0xFFFFC107)],
                      ).createShader(bounds),
                      child: Text(
                        'Fests',
                        style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1),
                      ),
                    ),
                    Text(
                      'The biggest campus celebrations 🎉',
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
                          hintText: 'Search fests, events…',
                          hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
                          prefixIcon: Icon(Icons.search_rounded, color: _accent.withOpacity(.7)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms),

            if (fests.isEmpty)
              SliverFillRemaining(
                child: EmptyStateWidget(
                  icon: Icons.celebration_rounded,
                  title: 'No fests found',
                  subtitle: 'Check back soon for upcoming campus fests!',
                  color: _accent,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 30),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FestCard(fest: fests[i]),
                    ),
                    childCount: fests.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
