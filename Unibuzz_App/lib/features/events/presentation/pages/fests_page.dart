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
import 'event_detail_page.dart';

class FestsPage extends StatefulWidget {
  const FestsPage({super.key});

  @override
  State<FestsPage> createState() => _FestsPageState();
}

class _FestsPageState extends State<FestsPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  late AnimationController _glowController;

  static const _filters = ['All', 'Tech Fest', 'Cultural Fest', 'Sports Fest', 'Business Fest'];

  List<EventModel> get _filteredFests {
    var fests = MockCategoryData.fests;
    if (_selectedFilter != 'All') {
      fests = fests.where((f) => f.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
    return fests;
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
    final fests = _filteredFests;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleField(particleCount: 35)),

          // Multi-color festival glow
          Positioned(
            top: -80,
            left: -50,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 300,
                height: 300,
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
            top: -30,
            right: -60,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.neonCyan.withValues(alpha: 0.07 + _glowController.value * 0.04),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -30,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.accent.withValues(alpha: 0.08 + _glowController.value * 0.05),
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
                expandedHeight: 200,
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
                    accentColor: AppColors.neonPink,
                  ),
                ),
              ),

              if (fests.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _FestCard(fest: fests[index], index: index),
                    childCount: fests.length,
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
                  gradient: LinearGradient(colors: [
                    AppColors.neonPink.withValues(alpha: 0.2),
                    AppColors.neonCyan.withValues(alpha: 0.1),
                  ]),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neonPink.withValues(alpha: 0.3)),
                ),
                child: const Text('🎪', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.neonPink, AppColors.neonCyan, AppColors.accent],
                    stops: [0.0, 0.5, 1.0],
                  ).createShader(bounds),
                  child: Text(
                    'Fests',
                    style: GoogleFonts.racingSansOne(fontSize: 34, color: AppColors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'The Biggest Events of the Year 🎉',
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            '${MockCategoryData.fests.length} Mega Fests Lined Up',
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.neonPink),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🎪', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No fests in this category', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

/// Large, immersive fest card with image, schedule preview, and pass info
class _FestCard extends StatelessWidget {
  final EventModel fest;
  final int index;
  const _FestCard({required this.fest, required this.index});

  Color get _festColor {
    switch (fest.category.toLowerCase()) {
      case 'tech fest':
        return AppColors.neonCyan;
      case 'cultural fest':
        return AppColors.neonPink;
      case 'sports fest':
        return AppColors.accent;
      case 'business fest':
        return const Color(0xFFFFAB00);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image header with gradient overlay
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      fest.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _festColor.withValues(alpha: 0.1),
                        child: Center(child: Text('🎪', style: const TextStyle(fontSize: 48))),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, AppColors.background.withValues(alpha: 0.9)],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                    // Category tag
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _festColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _festColor.withValues(alpha: 0.4)),
                        ),
                        child: Text(fest.category,
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: _festColor)),
                      ),
                    ),
                    // Countdown
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Text(fest.timeLeft,
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: _festColor)),
                      ),
                    ),
                    // Title over image
                    Positioned(
                      bottom: 12,
                      left: 14,
                      right: 14,
                      child: Text(fest.title,
                          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.white, height: 1.2)),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fest.description, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                  const SizedBox(height: 14),

                  // Info row
                  Row(
                    children: [
                      _infoChip(Icons.calendar_today_rounded, fest.date),
                      const SizedBox(width: 8),
                      _infoChip(Icons.location_on_outlined, fest.venue),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Prize + fee row
                  if (fest.prizes.isNotEmpty || fest.fee > 0)
                    Row(
                      children: [
                        if (fest.prizes.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [_festColor.withValues(alpha: 0.15), _festColor.withValues(alpha: 0.05)]),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _festColor.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(fest.prizes.first.icon, style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 6),
                                Text(fest.prizes.first.reward,
                                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: _festColor)),
                              ],
                            ),
                          ),
                        const Spacer(),
                        if (fest.fee > 0)
                          Text('Pass: ₹${fest.fee}',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.white)),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => EventDetailPage(event: fest)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _festColor,
                            foregroundColor: AppColors.background,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                          ),
                          child: Text('Explore Fest',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GlassContainer(
                        borderRadius: BorderRadius.circular(12),
                        child: IconButton(
                          onPressed: () => HapticFeedback.lightImpact(),
                          icon: Icon(Icons.share_outlined, color: _festColor, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideY(begin: 0.08, end: 0);
  }

  Widget _infoChip(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.glassBackgroundDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.glassBorderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: AppColors.textTertiary),
            const SizedBox(width: 5),
            Flexible(child: Text(text, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textTertiary), overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
