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
import 'event_detail_page.dart';

class WorkshopsPage extends StatefulWidget {
  const WorkshopsPage({super.key});

  @override
  State<WorkshopsPage> createState() => _WorkshopsPageState();
}

class _WorkshopsPageState extends State<WorkshopsPage> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  String _selectedSort = 'Ending Soon';
  late AnimationController _glowController;

  static const _filters = ['All', 'Tech', 'Career', 'Soft Skills'];
  static const _sorts = ['Ending Soon', 'Free First', 'Newest'];

  List<EventModel> get _filteredEvents {
    var events = MockCategoryData.workshops;
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
          const Positioned.fill(child: ParticleField(particleCount: 20)),

          // Knowledge-themed warm glow
          Positioned(
            top: -70,
            left: -40,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, _) => Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    const Color(0xFFFFAB00).withValues(alpha: 0.10 + _glowController.value * 0.06),
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -40,
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
                    accentColor: AppColors.warning,
                  ),
                ),
              ),

              // Upcoming highlight
              SliverToBoxAdapter(child: _buildUpcomingHighlight()),

              if (events.isEmpty)
                SliverFillRemaining(child: _buildEmpty())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final event = events[index];
                      return _WorkshopCard(
                        event: event,
                        index: index,
                      );
                    },
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
                  color: AppColors.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                ),
                child: const Text('🎓', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFFFAB00), AppColors.neonCyan],
                  ).createShader(bounds),
                  child: Text(
                    'Workshops',
                    style: GoogleFonts.racingSansOne(fontSize: 32, color: AppColors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Learn. Build. Level Up. 📚',
            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildUpcomingHighlight() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('🔥', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trending This Week',
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.warning)),
                    const SizedBox(height: 2),
                    Text('GenAI Masterclass • Free Entry',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: Text('FREE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.success)),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.06, end: 0);
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📚', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No workshops match this filter', style: GoogleFonts.poppins(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

/// Workshop-specific card with speaker info and seats progress
class _WorkshopCard extends StatelessWidget {
  final EventModel event;
  final int index;

  const _WorkshopCard({required this.event, required this.index});

  @override
  Widget build(BuildContext context) {
    // Simulated seat fill percentage
    final seatPercent = (0.4 + (index * 0.15)).clamp(0.0, 0.95);
    final seatsText = '${(seatPercent * 80).toInt()}/80 seats filled';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category chip + date
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _categoryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _categoryColor.withValues(alpha: 0.3)),
                    ),
                    child: Text(event.category, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: _categoryColor)),
                  ),
                  const Spacer(),
                  Text(event.timeLeft, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.warning)),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(event.title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white)),
              const SizedBox(height: 4),
              Text(event.description, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              const SizedBox(height: 12),

              // Speaker / organizer
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.3),
                    child: Text(event.organizer.isNotEmpty ? event.organizer[0] : '?',
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.white)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.organizer, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.white)),
                        Text('${event.venue} • ${event.time}', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Seat progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(seatsText, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textTertiary)),
                      Text(event.fee == 0 ? 'FREE' : '₹${event.fee}',
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700,
                              color: event.fee == 0 ? AppColors.success : AppColors.warning)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: seatPercent,
                      minHeight: 5,
                      backgroundColor: AppColors.glassBorder,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        seatPercent > 0.8 ? AppColors.error : AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Register
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EventDetailPage(event: event)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning.withValues(alpha: 0.15),
                    foregroundColor: AppColors.warning,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.warning.withValues(alpha: 0.3)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text('Reserve Seat', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 80 * index)).slideY(begin: 0.05, end: 0);
  }

  Color get _categoryColor {
    switch (event.category.toLowerCase()) {
      case 'tech':
        return AppColors.neonCyan;
      case 'career':
        return AppColors.accent;
      case 'soft skills':
        return AppColors.neonPink;
      default:
        return AppColors.warning;
    }
  }
}

