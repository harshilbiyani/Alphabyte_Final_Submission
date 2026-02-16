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

class GamingPage extends StatefulWidget {
  const GamingPage({super.key});

  @override
  State<GamingPage> createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  String _selectedSort = 'Ending Soon';
  late AnimationController _glowController;

  static const _filters = ['All', 'BGMI', 'Valorant', 'FIFA', 'Chess'];
  static const _sorts = ['Ending Soon', 'Prize Pool ↓', 'Solo Only', 'Team Only'];

  List<EventModel> get _filteredEvents {
    var events = MockCategoryData.gaming;
    if (_selectedFilter != 'All') {
      events = events.where((e) => e.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
    if (_selectedSort == 'Ending Soon') {
      events = [...events]..sort((a, b) {
          final aNum = int.tryParse(a.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          final bNum = int.tryParse(b.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          return aNum.compareTo(bNum);
        });
    } else if (_selectedSort == 'Solo Only') {
      events = events.where((e) => !e.isTeamEvent).toList();
    } else if (_selectedSort == 'Team Only') {
      events = events.where((e) => e.isTeamEvent).toList();
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
          const Positioned.fill(child: ParticleField(particleCount: 35)),

          // Neon purple / red esports glow
          Positioned(
            top: -80,
            right: -60,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.neonPurple.withValues(alpha: 0.12 + _glowController.value * 0.07),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -50,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    const Color(0xFFFF1744).withValues(alpha: 0.08 + _glowController.value * 0.05),
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
                    accentColor: AppColors.neonPurple,
                  ),
                ),
              ),

              // Platform quick-select
              SliverToBoxAdapter(child: _buildPlatformRow()),

              // Featured tournament banner
              SliverToBoxAdapter(child: _buildFeaturedBanner()),

              if (events.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => CategoryEventCard(
                      event: events[index],
                      variant: CategoryCardVariant.gaming,
                      accentColor: AppColors.neonPurple,
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
                  color: AppColors.neonPurple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.3)),
                ),
                child: const Text('🎮', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.neonPurple, Color(0xFFFF1744)],
                  ).createShader(bounds),
                  child: Text(
                    'Gaming',
                    style: GoogleFonts.racingSansOne(fontSize: 32, color: AppColors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Play. Dominate. GG. 🕹️',
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildPlatformRow() {
    final platforms = [
      _PlatformItem('📱', 'Mobile', const Color(0xFF00E5FF)),
      _PlatformItem('💻', 'PC', AppColors.neonPurple),
      _PlatformItem('🎮', 'Console', const Color(0xFFFF1744)),
      _PlatformItem('🌐', 'Online', AppColors.accent),
    ];

    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        scrollDirection: Axis.horizontal,
        itemCount: platforms.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final p = platforms[i];
          return GlassContainer(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(p.emoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(p.label, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: p.color)),
                ],
              ),
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 50 * i)).scaleXY(begin: 0.9, end: 1);
        },
      ),
    );
  }

  Widget _buildFeaturedBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                AppColors.neonPurple.withValues(alpha: 0.08),
                const Color(0xFFFF1744).withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 36)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VALORANT INVITATIONAL',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.neonPurple, letterSpacing: 0.5)),
                    const SizedBox(height: 2),
                    Text('₹30,000 Prize Pool • LAN Finals',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.neonPurple, AppColors.neonPurple.withValues(alpha: 0.7)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('18d', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.white)),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.06, end: 0);
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🎮', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No gaming events found', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _PlatformItem {
  final String emoji;
  final String label;
  final Color color;
  const _PlatformItem(this.emoji, this.label, this.color);
}
