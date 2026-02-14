import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_home_data.dart';
import '../../../events/presentation/pages/event_participation_page.dart';

class EndingSoonCarousel extends StatefulWidget {
  const EndingSoonCarousel({super.key});

  @override
  State<EndingSoonCarousel> createState() => _EndingSoonCarouselState();
}

class _EndingSoonCarouselState extends State<EndingSoonCarousel> {
  // Viewport fraction ensures side cards are visible.
  // 0.75 gives good prominence to the center card while showing sides.
  final PageController _pageController = PageController(viewportFraction: 0.75);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = MockHomeData.urgentEvents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                    'ENDING SOON',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fadeIn(duration: 600.ms)
                  .shimmer(color: Colors.white, duration: 1200.ms),
              const Spacer(),
              // Indication of horizontal scroll or "Show All" could go here
            ],
          ),
        ),

        // Carousel Section
        SizedBox(
          height:
              200, // Adjusted height for rectangular aspect ratio (approx 5:4 or 16:9 feel)
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final event = events[index];
              final bool isActive = index == _currentPage;

              // Smooth transition for scaling
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                  } else {
                    // Initial state when no dimensions yet
                    value = isActive ? 1.0 : 0.8;
                  }

                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 200,
                      width:
                          Curves.easeOut.transform(value) *
                          300, // Full width of viewport item
                      child: child,
                    ),
                  );
                },
                child: _buildEventCard(context, event, isActive),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, dynamic event, bool isActive) {
    return GestureDetector(
      onTap: () {
        // Tap animation effect could be added here before navigation if desired
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventParticipationPage(event: event),
          ),
        );
      },
      child: AnimatedContainer(
        duration: 300.ms,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ), // Spacing between cards
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 0),
                    spreadRadius: -5,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Event Poster Image
              Image.network(
                event.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: AppColors.primary,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.white54),
                    ),
                  );
                },
              ),

              // Glassmorphism Text Overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GlassContainer(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                  blur: 10,
                  opacity: 0.1, // Subtle glass
                  color: Colors.black,
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Colors.black.withValues(alpha: 0.1),
                  //     Colors.black.withValues(alpha: 0.8),
                  //   ],
                  // ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Urgency Badge (Top Right)
              Positioned(
                top: 12,
                right: 12,
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  color: AppColors.accent, // Neon Green
                  opacity: 0.8,
                  blur: 5,
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event.timeLeft,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Active Indicator Border (Optional for Premium Feel)
              if (isActive)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1,
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
