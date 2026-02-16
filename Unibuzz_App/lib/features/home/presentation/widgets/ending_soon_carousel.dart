import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_home_data.dart';
import '../../../events/presentation/pages/event_detail_page.dart';

class EndingSoonCarousel extends StatefulWidget {
  const EndingSoonCarousel({super.key});

  @override
  State<EndingSoonCarousel> createState() => _EndingSoonCarouselState();
}

class _EndingSoonCarouselState extends State<EndingSoonCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.78);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() => _currentPage = next);
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
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt_rounded, size: 14, color: AppColors.accent),
                    const SizedBox(width: 4),
                    Text(
                      'ENDING SOON',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .shimmer(color: Colors.white.withValues(alpha: 0.3), duration: 1800.ms),
              const Spacer(),
              // Dot indicator
              Row(
                children: List.generate(events.length, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 4,
                    width: isActive ? 16 : 4,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.accent : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isActive
                          ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 6)]
                          : [],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),

        // Carousel with depth stacking
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final event = events[index];
              final bool isActive = index == _currentPage;

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  double parallaxOffset = 0;
                  if (_pageController.position.haveDimensions) {
                    final diff = _pageController.page! - index;
                    value = (1 - (diff.abs() * 0.15)).clamp(0.85, 1.0);
                    parallaxOffset = diff * -20; // Slight parallax on image
                  } else {
                    value = isActive ? 1.0 : 0.85;
                  }

                  return Center(
                    child: Transform.translate(
                      offset: Offset(0, isActive ? 0 : 8),
                      child: SizedBox(
                        height: Curves.easeOut.transform(value) * 220,
                        width: Curves.easeOut.transform(value) * MediaQuery.of(context).size.width * 0.78,
                        child: _buildEventCard(context, event, isActive, parallaxOffset),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, dynamic event, bool isActive, double parallaxOffset) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    blurRadius: 40,
                    spreadRadius: -6,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Parallax image
              Transform.translate(
                offset: Offset(parallaxOffset, 0),
                child: Image.network(
                  event.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.surfaceLight,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.surfaceLight,
                    child: const Center(child: Icon(Icons.broken_image, color: Colors.white24)),
                  ),
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.3, 0.6, 1.0],
                  ),
                ),
              ),

              // Glass bottom info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GlassContainer(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
                  blur: 12,
                  opacity: 0.08,
                  color: Colors.black,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.racingSansOne(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 11,
                            color: Colors.white.withValues(alpha: 0.6)),
                          const SizedBox(width: 4),
                          Text(
                            event.date,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 11,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            event.department,
                            style: TextStyle(
                              color: AppColors.primaryLight.withValues(alpha: 0.7),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Urgency badge with glow
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer_outlined, size: 12, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(
                        event.timeLeft,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                 .scaleXY(begin: 1.0, end: 1.05, duration: 1200.ms),
              ),

              // Active neon border
              if (isActive)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1.2,
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
