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

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  String _selectedSort = 'Ending Soon';
  late AnimationController _glowController;

  static const _filters = ['All', 'Cricket', 'Football', 'Badminton', 'Athletics', 'Chess'];
  static const _sorts = ['Ending Soon', 'Team Events', 'Solo Events', 'Fee ↑'];

  List<EventModel> get _filteredEvents {
    var events = MockCategoryData.sports;
    if (_selectedFilter != 'All') {
      events = events.where((e) => e.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
    if (_selectedSort == 'Ending Soon') {
      events = [...events]..sort((a, b) {
          final aNum = int.tryParse(a.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          final bNum = int.tryParse(b.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          return aNum.compareTo(bNum);
        });
    } else if (_selectedSort == 'Team Events') {
      events = events.where((e) => e.isTeamEvent).toList();
    } else if (_selectedSort == 'Solo Events') {
      events = events.where((e) => !e.isTeamEvent).toList();
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

          // Green/lime accent glow
          Positioned(
            top: -70,
            left: -50,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.accent.withValues(alpha: 0.10 + _glowController.value * 0.05),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    const Color(0xFF00E676).withValues(alpha: 0.08 + _glowController.value * 0.04),
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
                    accentColor: AppColors.accent,
                  ),
                ),
              ),

              // Live match banner
              SliverToBoxAdapter(child: _buildLiveBanner()),

              if (events.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => CategoryEventCard(
                      event: events[index],
                      variant: CategoryCardVariant.sports,
                      accentColor: AppColors.accent,
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
                  color: AppColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                ),
                child: const Text('🏆', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.accent, Color(0xFF00E676)],
                  ).createShader(bounds),
                  child: Text(
                    'Sports',
                    style: GoogleFonts.racingSansOne(fontSize: 32, color: AppColors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Compete. Conquer. Champion. 🏅',
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildLiveBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.error),
                    ),
                    const SizedBox(width: 6),
                    Text('LIVE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.error)),
                  ],
                ),
              ).animate(onPlay: (c) => c.repeat()).shimmer(delay: 1.seconds, duration: 1500.ms, color: AppColors.error.withValues(alpha: 0.3)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cricket League — Match 3', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.white)),
                    Text('CS vs ENTC • 2nd Innings', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              Text('🏏', style: const TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05, end: 0);
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🏅', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No sports events match this filter', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
