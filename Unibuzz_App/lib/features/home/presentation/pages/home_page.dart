import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../data/mock_home_data.dart';
import '../widgets/ending_soon_carousel.dart';
import '../widgets/event_feed_card.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_category_section.dart';
import '../../../events/presentation/pages/event_detail_page.dart';
import '../../../discover/presentation/pages/discover_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../mentor/presentation/pages/mentor_page.dart';
import '../../../hackathons/presentation/pages/hackathon_page.dart';
import '../../../cultural/presentation/pages/cultural_page.dart';
import '../../../sports/presentation/pages/sports_page.dart';
import '../../../gaming/presentation/pages/gaming_page.dart';
import '../../../sessions/presentation/pages/sessions_page.dart';
import '../../../clubs/presentation/pages/clubs_page.dart';
import '../../../fests/presentation/pages/fests_page.dart';
import '../../../../core/widgets/page_transitions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _navGlowController;

  @override
  void initState() {
    super.initState();
    _navGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _navGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        body: Stack(
          children: [
            // ── Ambient glow orbs ──
            Positioned(
              top: -100,
              right: -80,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.13),
                  ),
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 1.0, end: 1.25, duration: 5.seconds, curve: Curves.easeInOut)
                .moveY(begin: 0, end: 30, duration: 6.seconds, curve: Curves.easeInOut),

            Positioned(
              bottom: 80,
              left: -60,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.04),
                  ),
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 1.0, end: 1.3, duration: 7.seconds, curve: Curves.easeInOut)
                .moveX(begin: 0, end: 40, duration: 8.seconds, curve: Curves.easeInOut),

            // ── Floating particles ──
            Positioned.fill(
              child: IgnorePointer(
                child: ParticleField(
                  particleCount: 12,
                  color: AppColors.primary.withValues(alpha: 0.4),
                  maxSize: 2.5,
                  minSize: 1.0,
                ),
              ),
            ),

            // ── Screen content ──
            IndexedStack(
              index: _currentIndex,
              children: const [
                _HomeContent(),
                DiscoverPage(),
                SearchPage(),
                ProfilePage(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: _buildGlassDockNav(),
      ),
    );
  }

  /// Floating glass dock navigation bar with active glow.
  Widget _buildGlassDockNav() {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 8),
      child: AnimatedBuilder(
        animation: _navGlowController,
        builder: (context, child) {
          final glowPulse = 0.08 + (_navGlowController.value * 0.06);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: glowPulse),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.03),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.10),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(Icons.home_rounded, 'Home', 0),
                      _buildNavItem(Icons.explore_rounded, 'Discover', 1),
                      _buildNavItem(Icons.search_rounded, 'Search', 2),
                      _buildNavItem(Icons.person_rounded, 'Profile', 3),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _currentIndex = index);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                padding: EdgeInsets.all(isSelected ? 9 : 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.18)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    icon,
                    color: isSelected ? AppColors.white : Colors.white30,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: isSelected ? AppColors.white : Colors.transparent,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const HomeHeader(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 10),
              HeroCategorySection(
                onCategoryTap: (category) {
                  Widget? page;
                  switch (category) {
                    case 'Mentors':
                      page = const MentorPage();
                      break;
                    case 'Hackathons':
                      page = const HackathonPage();
                      break;
                    case 'Cultural':
                      page = const CulturalPage();
                      break;
                    case 'Sports':
                      page = const SportsPage();
                      break;
                    case 'Gaming':
                      page = const GamingPage();
                      break;
                    case 'Sessions':
                      page = const SessionsPage();
                      break;
                    case 'Clubs':
                      page = const ClubsPage();
                      break;
                    case 'Fests':
                      page = const FestsPage();
                      break;
                  }
                  if (page != null) {
                    Navigator.push(
                      context,
                      SlideUpRoute(page: page),
                    );
                  }
                },
                onCategoryLongPress: (category) {},
              ),
              const SizedBox(height: 8),
              const EndingSoonCarousel(),
              const SizedBox(height: 24),

              // Feed Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'UPCOMING VIBES',
                      style: GoogleFonts.racingSansOne(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ].animate(interval: 80.ms).fade(duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOut),
          ),
        ),

        // Event Feed
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final event = MockHomeData.feedEvents[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailPage(event: event),
                  ),
                );
              },
              child: EventFeedCard(event: event)
                  .animate()
                  .fade(duration: 500.ms, delay: (80 * index).ms)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOut),
            );
          }, childCount: MockHomeData.feedEvents.length),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 110)),
      ],
    );
  }
}
