import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Added missing import
import '../../../events/presentation/pages/event_participation_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/mock_home_data.dart';
import '../widgets/ending_soon_carousel.dart';
import '../widgets/event_feed_card.dart';
import '../widgets/home_header.dart';
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
          // Background ambient gradient (optional subtle effect)
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
                  color: AppColors.primary.withOpacity(0.15),
                ),
              ),
            ),
          ),
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
                  color: AppColors.accent.withOpacity(0.05),
                ),
              ),
            ),
          ),

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E).withOpacity(0.7),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
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
              ? AppColors.primary.withOpacity(0.2)
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
                        color: AppColors.primary.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
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
              child: EventFeedCard(event: event),
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
