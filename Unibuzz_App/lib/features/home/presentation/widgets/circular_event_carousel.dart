import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../events/presentation/pages/event_participation_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/mock_home_data.dart';

class CircularEventCarousel extends StatefulWidget {
  const CircularEventCarousel({super.key});

  @override
  State<CircularEventCarousel> createState() => _CircularEventCarouselState();
}

class _CircularEventCarouselState extends State<CircularEventCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.5);
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
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .fadeIn(duration: 600.ms)
               .shimmer(color: Colors.white, duration: 1200.ms),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 12),
            ],
          ),
        ),
        
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final event = events[index];
              // Calculate scaling for 3D effect
              // We use an AnimatedBuilder logic implicitly by rebuilding on scroll logic if needed,
              // but for simplicity with PageView, we can use the active index differentiation.
              final bool isActive = index == _currentPage;
              
              return AnimatedContainer(
                duration: 300.ms,
                curve: Curves.easeOutBack,
                transform: Matrix4.identity()..scale(isActive ? 1.1 : 0.85),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventParticipationPage(event: event),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // Circular Poster
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (isActive)
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          const BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: isActive ? AppColors.accent : Colors.white12,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(event.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Title
                    Text(
                      event.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Timer
                    Text(
                      event.timeLeft,
                      style: TextStyle(
                        color: isActive ? AppColors.accent : Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
