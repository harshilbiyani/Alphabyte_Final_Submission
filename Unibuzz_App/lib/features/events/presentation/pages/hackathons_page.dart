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

class HackathonsPage extends StatefulWidget {
  const HackathonsPage({super.key});

  @override
  State<HackathonsPage> createState() => _HackathonsPageState();
}

class _HackathonsPageState extends State<HackathonsPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  String _selectedSort = 'Ending Soon';
  late AnimationController _glowController;

  static const _filters = ['All', 'Web3', 'AI/ML', 'DSA', 'Open Theme'];
  static const _sorts = ['Ending Soon', 'Prize Pool ↓', 'Team Size', 'Newest'];

  List<EventModel> get _filteredEvents {
    var events = MockCategoryData.hackathons;
    if (_selectedFilter != 'All') {
      events = events
          .where((e) =>
              e.title.toLowerCase().contains(_selectedFilter.toLowerCase()) ||
              e.description.toLowerCase().contains(_selectedFilter.toLowerCase()) ||
              e.about.toLowerCase().contains(_selectedFilter.toLowerCase()))
          .toList();
    }
    if (_selectedSort == 'Ending Soon') {
      events = [...events]..sort((a, b) {
          final aNum = int.tryParse(a.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          final bNum = int.tryParse(b.timeLeft.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          return aNum.compareTo(bNum);
        });
    }
    return events;
  }

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
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
          // Particle background
          const Positioned.fill(child: ParticleField(particleCount: 30)),

          // Ambient glow
          Positioned(
            top: -80,
            left: -60,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.neonCyan.withValues(alpha: 0.10 + _glowController.value * 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.08 + _glowController.value * 0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Main content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // --- App Bar ---
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

              // --- Filter Bar ---
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
                    accentColor: AppColors.neonCyan,
                  ),
                ),
              ),

              // --- Stats Banner ---
              SliverToBoxAdapter(child: _buildStatsBanner()),

              // --- Event List ---
              if (events.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => CategoryEventCard(
                      event: events[index],
                      variant: CategoryCardVariant.hackathon,
                      accentColor: AppColors.neonCyan,
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
                  color: AppColors.neonCyan.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.3)),
                ),
                child: const Text('⚡', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.neonCyan, AppColors.primaryLight],
                  ).createShader(bounds),
                  child: Text(
                    'Hackathons',
                    style: GoogleFonts.racingSansOne(
                      fontSize: 32,
                      color: AppColors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Build. Break. Ship. 🚀',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildStatsBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _stat('${MockCategoryData.hackathons.length}', 'Active'),
              _statDivider(),
              _stat('₹2L+', 'Prize Pool'),
              _statDivider(),
              _stat('4', 'Tracks'),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.neonCyan)),
        const SizedBox(height: 2),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textTertiary)),
      ],
    );
  }

  Widget _statDivider() {
    return Container(width: 1, height: 28, color: AppColors.glassBorder);
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No hackathons match this filter', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
