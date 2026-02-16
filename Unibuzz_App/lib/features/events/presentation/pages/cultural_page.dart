import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../../core/widgets/filter_sort_bar.dart';
import '../../../home/data/mock_home_data.dart';
import '../../data/mock_category_data.dart';
import '../widgets/category_event_card.dart';

class CulturalPage extends StatefulWidget {
  const CulturalPage({super.key});

  @override
  State<CulturalPage> createState() => _CulturalPageState();
}

class _CulturalPageState extends State<CulturalPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  String _selectedSort = 'Ending Soon';
  late AnimationController _glowController;

  static const _filters = ['All', 'Dance', 'Music', 'Drama', 'Art', 'Literary'];
  static const _sorts = ['Ending Soon', 'Newest', 'Free First', 'Team Events'];

  List<EventModel> get _filteredEvents {
    var events = MockCategoryData.cultural;
    if (_selectedFilter != 'All') {
      events = events.where((e) => e.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
    if (_selectedSort == 'Ending Soon') {
      events = [...events]..sort((a, b) {
          final aNum = int.tryParse(a.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          final bNum = int.tryParse(b.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          return aNum.compareTo(bNum);
        });
    } else if (_selectedSort == 'Free First') {
      events = [...events]..sort((a, b) => a.fee.compareTo(b.fee));
    }
    return events;
  }

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleField(particleCount: 25)),

          // Pink / warm ambient glow
          Positioned(
            top: -60,
            right: -50,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.neonPink.withValues(alpha: 0.10 + _glowController.value * 0.06),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -40,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    const Color(0xFFFF6B35).withValues(alpha: 0.07 + _glowController.value * 0.04),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                leading: _buildBackButton(),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: _buildHeader(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FilterSortBar(
                    filters: _filters,
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (f) => setState(() => _selectedFilter = f),
                    sortOptions: _sorts,
                    selectedSort: _selectedSort,
                    onSortSelected: (s) => setState(() => _selectedSort = s),
                    accentColor: AppColors.neonPink,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _buildGenreChips()),
              if (events.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => CategoryEventCard(
                      event: events[index],
                      variant: CategoryCardVariant.standard,
                      accentColor: AppColors.neonPink,
                    ).animate().fadeIn(delay: Duration(milliseconds: 80 * index)).slideY(begin: 0.05, end: 0),
                    childCount: events.length,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(14),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 18),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.neonPink.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neonPink.withValues(alpha: 0.3)),
                ),
                child: const Text('🎭', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.neonPink, Color(0xFFFF6B35)],
                  ).createShader(bounds),
                  child: Text(
                    'Cultural',
                    style: GoogleFonts.racingSansOne(fontSize: 32, color: AppColors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Express. Perform. Inspire. 🎨',
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildGenreChips() {
    final genres = [
      _GenreItem('💃', 'Dance', const Color(0xFFFF4DA6)),
      _GenreItem('🎸', 'Music', const Color(0xFFFF6B35)),
      _GenreItem('🎭', 'Drama', const Color(0xFF9B5FFF)),
      _GenreItem('🎨', 'Art', const Color(0xFF00E5FF)),
      _GenreItem('✍️', 'Literary', const Color(0xFFC6FF33)),
    ];

    return SizedBox(
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final g = genres[i];
          return GlassContainer(
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedFilter = _selectedFilter == g.label ? 'All' : g.label);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: _selectedFilter == g.label
                      ? Border.all(color: g.color.withValues(alpha: 0.6), width: 1.5)
                      : null,
                ),
                child: Row(
                  children: [
                    Text(g.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(g.label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.white)),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).scaleXY(begin: 0.9, end: 1);
        },
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🎭', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No cultural events found', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _GenreItem {
  final String emoji;
  final String label;
  final Color color;
  const _GenreItem(this.emoji, this.label, this.color);
}
