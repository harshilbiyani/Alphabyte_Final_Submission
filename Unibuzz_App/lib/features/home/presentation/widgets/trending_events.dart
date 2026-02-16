import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_home_data.dart';
import '../../../events/presentation/pages/event_detail_page.dart';

/// Horizontal scrolling trending event cards with snap behavior.
class TrendingEvents extends StatelessWidget {
  const TrendingEvents({super.key});

  static final List<_TrendingItem> _items = [
    _TrendingItem(
      title: 'Hackathon 24',
      category: 'Tech',
      prize: '₹50K',
      spots: '32 spots left',
      imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&q=80',
      accentColor: AppColors.neonCyan,
      emoji: '💻',
      event: MockHomeData.urgentEvents[1],
    ),
    _TrendingItem(
      title: 'Cultural Fest',
      category: 'Cultural',
      prize: 'Free',
      spots: 'Open for all',
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600&q=80',
      accentColor: AppColors.neonPink,
      emoji: '🎭',
      event: MockHomeData.feedEvents[0],
    ),
    _TrendingItem(
      title: 'BGMI Tournament',
      category: 'Gaming',
      prize: '₹10K',
      spots: '16 teams left',
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=600&q=80',
      accentColor: AppColors.primary,
      emoji: '🎮',
      event: MockHomeData.feedEvents[3],
    ),
    _TrendingItem(
      title: 'AI Workshop',
      category: 'Workshop',
      prize: '₹99',
      spots: '12 seats left',
      imageUrl: 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=600&q=80',
      accentColor: AppColors.warning,
      emoji: '🤖',
      event: MockHomeData.feedEvents[1],
    ),
    _TrendingItem(
      title: 'RoboWars',
      category: 'Robotics',
      prize: '₹40K',
      spots: '20 teams left',
      imageUrl: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=600&q=80',
      accentColor: AppColors.accent,
      emoji: '🤖',
      event: MockHomeData.urgentEvents[2],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '🔥',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 6),
              Text(
                'TRENDING',
                style: GoogleFonts.racingSansOne(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
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
        const SizedBox(height: 14),
        // Horizontal card list
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _TrendingCard(item: _items[index])
                  .animate(delay: (80 * index).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: 0.1, end: 0, curve: Curves.easeOut);
            },
          ),
        ),
      ],
    );
  }
}

class _TrendingCard extends StatefulWidget {
  final _TrendingItem item;
  const _TrendingCard({required this.item});

  @override
  State<_TrendingCard> createState() => _TrendingCardState();
}

class _TrendingCardState extends State<_TrendingCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailPage(event: widget.item.event)),
        );
      },
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 155,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.item.accentColor.withValues(alpha: _pressed ? 0.25 : 0.1),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
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
                // Image
                Image.network(
                  widget.item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceLight),
                ),
                // Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.9),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
                // Top accent corner glow
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.item.accentColor.withValues(alpha: 0.0),
                          widget.item.accentColor,
                          widget.item.accentColor.withValues(alpha: 0.0),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.item.accentColor.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                // Category badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: widget.item.accentColor.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      widget.item.category.toUpperCase(),
                      style: TextStyle(
                        color: widget.item.accentColor,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                // Content
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.spots,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Prize + Quick register
                      Row(
                        children: [
                          if (widget.item.prize.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                widget.item.prize,
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.bolt_rounded, color: Colors.black, size: 14),
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
      ),
    );
  }
}

class _TrendingItem {
  final String title;
  final String category;
  final String prize;
  final String spots;
  final String imageUrl;
  final Color accentColor;
  final String emoji;
  final EventModel event;

  const _TrendingItem({
    required this.title,
    required this.category,
    required this.prize,
    required this.spots,
    required this.imageUrl,
    required this.accentColor,
    required this.emoji,
    required this.event,
  });
}
