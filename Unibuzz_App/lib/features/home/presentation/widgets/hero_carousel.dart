import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_home_data.dart';
import '../../../events/presentation/pages/event_detail_page.dart';

/// Full-width hero carousel with countdown timers, parallax, and LIVE indicators.
class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.92);
  int _current = 0;
  Timer? _autoScroll;

  static final List<_HeroEvent> _events = [
    _HeroEvent(
      title: 'HACKATHON X\n3.0',
      subtitle: 'Code. Build. Disrupt.',
      prize: '₹50K+',
      participants: '120+',
      timeLeft: '48 HRS LEFT',
      imageUrl: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800&q=80',
      isLive: true,
      accentColor: AppColors.neonCyan,
      category: 'Tech',
      event: MockHomeData.urgentEvents[1],
    ),
    _HeroEvent(
      title: 'NEON\nNIGHT',
      subtitle: 'The biggest DJ night of the semester.',
      prize: '',
      participants: '300+',
      timeLeft: 'TONIGHT',
      imageUrl: 'https://images.unsplash.com/photo-1545128485-c400e7702796?w=800&q=80',
      isLive: false,
      accentColor: AppColors.neonPink,
      category: 'Music',
      event: MockHomeData.urgentEvents[0],
    ),
    _HeroEvent(
      title: 'ROBO\nWARS',
      subtitle: 'Battle of the bots in the arena.',
      prize: '₹40K',
      participants: '60+',
      timeLeft: '2 DAYS LEFT',
      imageUrl: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&q=80',
      isLive: false,
      accentColor: AppColors.accent,
      category: 'Robotics',
      event: MockHomeData.urgentEvents[2],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final next = _controller.page!.round();
      if (_current != next) setState(() => _current = next);
    });
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScroll = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_current + 1) % _events.length;
      _controller.animateToPage(next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
    });
  }

  @override
  void dispose() {
    _autoScroll?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: _controller,
            itemCount: _events.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final hero = _events[index];
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double scale = 1.0;
                  double parallax = 0;
                  if (_controller.position.haveDimensions) {
                    final diff = _controller.page! - index;
                    scale = (1 - diff.abs() * 0.12).clamp(0.88, 1.0);
                    parallax = diff * -30;
                  }
                  return Center(
                    child: Transform.scale(
                      scale: scale,
                      child: _HeroCard(
                        hero: hero,
                        isActive: index == _current,
                        parallaxOffset: parallax,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_events.length, (i) {
            final active = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 24 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: active ? AppColors.accent : Colors.white.withValues(alpha: 0.2),
                boxShadow: active
                    ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.5), blurRadius: 8)]
                    : [],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final _HeroEvent hero;
  final bool isActive;
  final double parallaxOffset;

  const _HeroCard({
    required this.hero,
    required this.isActive,
    required this.parallaxOffset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailPage(event: hero.event)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: hero.accentColor.withValues(alpha: 0.3),
                    blurRadius: 28,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Parallax background
              Transform.translate(
                offset: Offset(parallaxOffset, 0),
                child: Image.network(
                  hero.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.surfaceLight,
                    child: const Icon(Icons.broken_image, color: Colors.white24, size: 48),
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
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.4),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
              // Left accent bar
              Positioned(
                left: 0,
                top: 30,
                bottom: 30,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        hero.accentColor.withValues(alpha: 0.0),
                        hero.accentColor,
                        hero.accentColor.withValues(alpha: 0.0),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: hero.accentColor.withValues(alpha: 0.6),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 20,
                right: 20,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LIVE badge or countdown
                    Row(
                      children: [
                        if (hero.isLive)
                          _LiveBadge()
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: hero.accentColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: hero.accentColor.withValues(alpha: 0.4)),
                            ),
                            child: Text(
                              hero.timeLeft,
                              style: TextStyle(
                                color: hero.accentColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            hero.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Bold italic title — website style
                    Text(
                      hero.title,
                      style: GoogleFonts.racingSansOne(
                        fontSize: 32,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 1,
                        shadows: [
                          Shadow(
                            color: hero.accentColor.withValues(alpha: 0.4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      hero.subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Bottom row: stats + CTA
                    Row(
                      children: [
                        if (hero.prize.isNotEmpty) ...[
                          Icon(Icons.emoji_events_rounded, size: 14, color: AppColors.accent),
                          const SizedBox(width: 4),
                          Text(hero.prize,
                              style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(width: 16),
                        ],
                        Icon(Icons.people_alt_rounded, size: 14, color: Colors.white54),
                        const SizedBox(width: 4),
                        Text(hero.participants,
                            style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        const Spacer(),
                        // JOIN THE HYPE button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withValues(alpha: 0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'JOIN',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.bolt_rounded, size: 14, color: Colors.black),
                            ],
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
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.error.withValues(alpha: 0.8), blurRadius: 6),
              ],
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 1.0, end: 1.6, duration: 800.ms),
          const SizedBox(width: 6),
          const Text(
            'LIVE NOW',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroEvent {
  final String title;
  final String subtitle;
  final String prize;
  final String participants;
  final String timeLeft;
  final String imageUrl;
  final bool isLive;
  final Color accentColor;
  final String category;
  final EventModel event;

  const _HeroEvent({
    required this.title,
    required this.subtitle,
    required this.prize,
    required this.participants,
    required this.timeLeft,
    required this.imageUrl,
    required this.isLive,
    required this.accentColor,
    required this.category,
    required this.event,
  });
}
