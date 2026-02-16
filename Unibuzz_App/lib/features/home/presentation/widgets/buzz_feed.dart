import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

/// Community photo moments feed — social proof gallery.
class BuzzFeed extends StatelessWidget {
  const BuzzFeed({super.key});

  static const List<_BuzzMoment> _moments = [
    _BuzzMoment(
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400&q=80',
      caption: 'Hackathon 24 — All night coding 🔥',
      likes: 42,
      event: 'Hackathon 24',
    ),
    _BuzzMoment(
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=400&q=80',
      caption: 'Cultural Fest Opening Night ✨',
      likes: 89,
      event: 'Cultural Fest',
    ),
    _BuzzMoment(
      imageUrl: 'https://images.unsplash.com/photo-1519861531473-920026393112?w=400&q=80',
      caption: 'Basketball Finals — What a match! 🏀',
      likes: 67,
      event: 'Sports Day',
    ),
    _BuzzMoment(
      imageUrl: 'https://images.unsplash.com/photo-1511578314322-379afb476865?w=400&q=80',
      caption: 'DJ Night crowd going wild 🎶',
      likes: 124,
      event: 'Neon Night',
    ),
    _BuzzMoment(
      imageUrl: 'https://images.unsplash.com/photo-1559223607-a43c990c692c?w=400&q=80',
      caption: 'RoboWars arena showdown 🤖',
      likes: 53,
      event: 'RoboWars',
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
              const Text('📸', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                'BUZZ FEED',
                style: GoogleFonts.racingSansOne(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_a_photo_rounded, size: 12, color: AppColors.primaryLight),
                      const SizedBox(width: 4),
                      Text(
                        'Share',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Photo grid — horizontal scroll
        SizedBox(
          height: 175,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _moments.length,
            itemBuilder: (context, index) {
              return _BuzzCard(moment: _moments[index])
                  .animate(delay: (80 * index).ms)
                  .fadeIn(duration: 400.ms)
                  .scaleXY(begin: 0.92, end: 1.0, curve: Curves.easeOut);
            },
          ),
        ),
      ],
    );
  }
}

class _BuzzCard extends StatefulWidget {
  final _BuzzMoment moment;
  const _BuzzCard({required this.moment});

  @override
  State<_BuzzCard> createState() => _BuzzCardState();
}

class _BuzzCardState extends State<_BuzzCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        HapticFeedback.mediumImpact();
        setState(() => _liked = !_liked);
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo
              Image.network(
                widget.moment.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceLight),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              // Event tag
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.moment.event,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // Heart animation on double tap
              if (_liked)
                Center(
                  child: Icon(
                    Icons.favorite_rounded,
                    color: AppColors.neonPink,
                    size: 48,
                  )
                      .animate()
                      .scaleXY(begin: 0.0, end: 1.0, duration: 300.ms, curve: Curves.easeOutBack)
                      .then(delay: 400.ms)
                      .fadeOut(duration: 300.ms),
                ),
              // Bottom info
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() => _liked = !_liked);
                      },
                      child: Icon(
                        _liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: _liked ? AppColors.neonPink : Colors.white54,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.moment.likes + (_liked ? 1 : 0)}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
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

class _BuzzMoment {
  final String imageUrl;
  final String caption;
  final int likes;
  final String event;

  const _BuzzMoment({
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.event,
  });
}
