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

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  late AnimationController _glowController;

  static const _filters = ['All', 'Technical', 'Creative', 'Business', 'Social'];

  List<EventModel> get _filteredClubs {
    var clubs = MockCategoryData.clubs;
    if (_selectedFilter != 'All') {
      clubs = clubs.where((c) => c.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
    return clubs;
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
    final clubs = _filteredClubs;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleField(particleCount: 20)),

          // Cyan / teal glow
          Positioned(
            top: -60,
            right: -50,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.neonCyan.withValues(alpha: 0.10 + _glowController.value * 0.05),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.primary.withValues(alpha: 0.07 + _glowController.value * 0.04),
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
                    accentColor: AppColors.neonCyan,
                  ),
                ),
              ),

              // Stats row
              SliverToBoxAdapter(child: _buildStatsRow()),

              if (clubs.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _ClubCard(club: clubs[index], index: index),
                    childCount: clubs.length,
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
                child: const Text('🏛️', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.neonCyan, AppColors.primaryLight],
                  ).createShader(bounds),
                  child: Text(
                    'Clubs',
                    style: GoogleFonts.racingSansOne(fontSize: 32, color: AppColors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Find Your Tribe. Join a Club. 🤝',
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _stat('${MockCategoryData.clubs.length}', 'Clubs'),
              _divider(),
              _stat('1850+', 'Members'),
              _divider(),
              _stat('50+', 'Events/yr'),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _stat(String val, String label) => Column(
        children: [
          Text(val, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.neonCyan)),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textTertiary)),
        ],
      );
  Widget _divider() => Container(width: 1, height: 28, color: AppColors.glassBorder);

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🏛️', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No clubs in this category yet', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

/// Individual club directory card
class _ClubCard extends StatefulWidget {
  final EventModel club;
  final int index;
  const _ClubCard({required this.club, required this.index});

  @override
  State<_ClubCard> createState() => _ClubCardState();
}

class _ClubCardState extends State<_ClubCard> {
  bool _joined = false;

  Color get _catColor {
    switch (widget.club.category.toLowerCase()) {
      case 'technical':
        return AppColors.neonCyan;
      case 'creative':
        return AppColors.neonPink;
      case 'business':
        return AppColors.accent;
      case 'social':
        return const Color(0xFFFF6B35);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final club = widget.club;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: category + member count
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _catColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _catColor.withValues(alpha: 0.3)),
                    ),
                    child: Text(club.category,
                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: _catColor)),
                  ),
                  const Spacer(),
                  Icon(Icons.people_outline, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(club.timeLeft, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textTertiary)),
                ],
              ),
              const SizedBox(height: 14),

              // Club name
              Text(club.title,
                  style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.white)),
              const SizedBox(height: 4),
              Text(club.description, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              const SizedBox(height: 12),

              // Info chips
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _infoChip(Icons.calendar_today_rounded, club.time),
                  _infoChip(Icons.location_on_outlined, club.venue),
                  _infoChip(Icons.school_outlined, club.department),
                ],
              ),
              const SizedBox(height: 14),

              // Lead info + Join button
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: _catColor.withValues(alpha: 0.25),
                    child: Text(club.organizer.isNotEmpty ? club.organizer[0] : '?',
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.white)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(club.organizer,
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      setState(() => _joined = !_joined);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _joined ? _catColor.withValues(alpha: 0.15) : _catColor,
                      foregroundColor: _joined ? _catColor : AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: _joined ? BorderSide(color: _catColor.withValues(alpha: 0.5)) : BorderSide.none,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      elevation: 0,
                    ),
                    child: Text(
                      _joined ? 'Joined ✓' : 'Join',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 80 * widget.index)).slideY(begin: 0.05, end: 0);
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.glassBackgroundDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.glassBorderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textTertiary),
          const SizedBox(width: 4),
          Text(text, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}
