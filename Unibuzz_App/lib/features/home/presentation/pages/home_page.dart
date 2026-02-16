import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../data/mock_home_data.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_category_section.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/live_activity_feed.dart';
import '../widgets/stats_banner.dart';
import '../widgets/trending_events.dart';
import '../widgets/deadline_strip.dart';
import '../widgets/leaderboard_peek.dart';
import '../widgets/buzz_feed.dart';
import '../../../events/presentation/pages/event_detail_page.dart';
import '../../../discover/presentation/pages/discover_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../mentor/presentation/pages/mentor_page.dart';
import '../../../events/presentation/pages/hackathons_page.dart';
import '../../../events/presentation/pages/cultural_page.dart';
import '../../../events/presentation/pages/sports_page.dart';
import '../../../events/presentation/pages/gaming_page.dart';
import '../../../events/presentation/pages/workshops_page.dart';
import '../../../events/presentation/pages/clubs_page.dart';
import '../../../events/presentation/pages/fests_page.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ── 1. Animated Greeting ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.white, AppColors.accent],
                      ).createShader(bounds),
                      child: Text(
                        "WHAT'S BUZZING?",
                        style: GoogleFonts.racingSansOne(
                          fontSize: 28,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: -0.05, end: 0)
                        .shimmer(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          duration: 2500.ms,
                          delay: 800.ms,
                        ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 18),

              // ── 2. Hero Carousel ──
              const HeroCarousel()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 100.ms)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOut),

              const SizedBox(height: 24),

              // ── 3. Category Cards (animated grid) ──
              HeroCategorySection(
                onCategoryTap: (category) {
                  Widget? page;
                  switch (category) {
                    case 'Hackathons':
                      page = const HackathonsPage();
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
                      page = const WorkshopsPage();
                      break;
                    case 'Mentors':
                      page = const MentorPage();
                      break;
                    case 'Clubs':
                      page = const ClubsPage();
                      break;
                    case 'Fests':
                      page = const FestsPage();
                      break;
                  }
                  if (page != null) {
                    Navigator.push(context, SlideUpRoute(page: page));
                  }
                },
                onCategoryLongPress: (category) {},
              ),

              const SizedBox(height: 24),

              // ── 4. Happening Now — Live Activity Feed ──
              const LiveActivityFeed()
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 200.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 28),

              // ── 5. Stats Banner — "Your Skills. Verified On Chain." ──
              const StatsBanner()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 250.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 28),

              // ── 6. Trending Events ──
              const TrendingEvents()
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 300.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 28),

              // ── 7. "For You" — Personalized Picks ──
              _buildForYouSection(context),

              const SizedBox(height: 28),

              // ── 8. Deadlines Approaching ──
              const DeadlineStrip()
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 350.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 28),

              // ── 9. Leaderboard Peek ──
              const LeaderboardPeek()
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 400.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 28),

              // ── 10. Buzz Feed — Community Moments ──
              const BuzzFeed()
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 450.ms)
                  .slideY(begin: 0.06, end: 0),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }

  static String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return '🌙 Late Night Grind?';
    if (hour < 12) return '☀️ Good Morning';
    if (hour < 17) return '🌤 Good Afternoon';
    if (hour < 21) return '🌆 Good Evening';
    return '🌙 Night Owl Mode';
  }

  static Widget _buildForYouSection(BuildContext context) {
    final event = MockHomeData.feedEvents[1]; // AI Workshop as recommendation

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎯', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                'PICKED FOR YOU',
                style: GoogleFonts.racingSansOne(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Based on your interests & activity',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
              );
            },
            child: GlassContainer(
              borderRadius: BorderRadius.circular(18),
              blur: 14,
              opacity: 0.06,
              padding: const EdgeInsets.all(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
              glowColor: AppColors.primary,
              glowIntensity: 0.05,
              child: Row(
                children: [
                  // Event image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      event.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 70,
                        height: 70,
                        color: AppColors.surfaceLight,
                        child: const Icon(Icons.broken_image, color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            event.category.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          event.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'You attended 3 similar events',
                          style: TextStyle(
                            color: AppColors.accent.withValues(alpha: 0.7),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                    ),
                    child: Icon(Icons.arrow_forward_rounded, color: AppColors.accent, size: 18),
                  ),
                ],
              ),
            ),
          )
              .animate(delay: 300.ms)
              .fadeIn(duration: 500.ms)
              .slideX(begin: 0.05, end: 0),
        ],
      ),
    );
  }
}
