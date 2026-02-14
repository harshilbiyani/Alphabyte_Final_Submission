import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_home_data.dart';
import '../widgets/ending_soon_carousel.dart';
import '../widgets/event_feed_card.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_category_section.dart';
import '../../../events/presentation/pages/event_participation_page.dart';
import '../../../discover/presentation/pages/discover_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true, // Crucial for floating glass nav
      body: Stack(
        children: [
          // Background ambient gradient (animated)
          Positioned(
            top: -100,
            right: -100,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scaleXY(begin: 1.0, end: 1.2, duration: 4.seconds, curve: Curves.easeInOut)
           .moveY(begin: 0, end: 30, duration: 5.seconds, curve: Curves.easeInOut),

          Positioned(
            bottom: 100,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.05),
                ),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scaleXY(begin: 1.0, end: 1.3, duration: 6.seconds, curve: Curves.easeInOut)
           .moveX(begin: 0, end: 40, duration: 7.seconds, curve: Curves.easeInOut),

          // Main Content Area
          IndexedStack(
            index: _currentIndex,
            children: [
              const _HomeContent(),      // Index 0: Home 
              const DiscoverPage(),      // Index 1: Discover
              const SearchPage(),        // Index 2: Search
              const ProfilePage(),       // Index 3: Profile
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildGlassBottomNav(),
    );
  }

  Widget _buildGlassBottomNav() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 70,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(35),
        blur: 15,
        opacity: 0.7,
        color: const Color(0xFF1E1E1E),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home_filled, 0),
            _buildNavItem(Icons.explore_outlined, 1),
            _buildNavItem(Icons.search, 2),
            _buildNavItem(Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.2)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Animate(
          target: isSelected ? 1 : 0,
          effects: [
            ScaleEffect(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ],
          child: Icon(
            icon,
            color: isSelected ? AppColors.white : Colors.white38,
            size: 26,
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
                onCategoryTap: (category) {},
                onCategoryLongPress: (category) {},
              ),
              const SizedBox(height: 8),
              const EndingSoonCarousel(),
              const SizedBox(height: 20),

              // Feed Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'UPCOMING VIBES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            'Racing Sans One', // Fallback or explicit
                        letterSpacing: 1.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primary.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ].animate(interval: 100.ms).fade(duration: 500.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
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
                    builder: (context) =>
                        EventParticipationPage(event: event),
                  ),
                );
              },
              child: EventFeedCard(event: event)
                  .animate()
                  .fade(duration: 500.ms, delay: (100 * index).ms)
                  .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
            );
          }, childCount: MockHomeData.feedEvents.length),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 100), // Space for bottom nav
        ),
      ],
    );
  }
}
