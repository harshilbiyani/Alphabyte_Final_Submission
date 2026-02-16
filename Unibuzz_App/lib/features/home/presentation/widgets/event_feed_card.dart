import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_home_data.dart';
import '../../../events/presentation/pages/event_detail_page.dart';

class EventFeedCard extends StatefulWidget {
  final EventModel event;

  const EventFeedCard({super.key, required this.event});

  @override
  State<EventFeedCard> createState() => _EventFeedCardState();
}

class _EventFeedCardState extends State<EventFeedCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: Container(
          margin: const EdgeInsets.only(bottom: 22, left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _pressed ? 0.18 : 0.08),
                blurRadius: _pressed ? 30 : 18,
                offset: const Offset(0, 8),
                spreadRadius: _pressed ? 2 : 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(24),
            blur: 16,
            opacity: 0.08,
            color: Colors.white,
            showReflection: true,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
              width: 1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Image with overlay ──
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ).createShader(bounds),
                        blendMode: BlendMode.dstIn,
                        child: Image.network(
                          widget.event.imageUrl,
                          height: 210,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 210,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary.withValues(alpha: 0.1),
                                    AppColors.surfaceLight,
                                  ],
                                ),
                              ),
                              child: const Icon(Icons.broken_image, color: Colors.white24, size: 40),
                            );
                          },
                        ),
                      ),
                    ),
                    // Category pill
                    Positioned(
                      top: 14,
                      left: 14,
                      child: GlassContainer(
                        borderRadius: BorderRadius.circular(30),
                        blur: 12,
                        opacity: 0.15,
                        color: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          width: 1,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withValues(alpha: 0.6),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.event.category.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bookmark icon
                    Positioned(
                      top: 14,
                      right: 14,
                      child: GlassContainer(
                        shape: BoxShape.circle,
                        blur: 10,
                        opacity: 0.12,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Content ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date row
                      Row(
                        children: [
                          Icon(Icons.schedule_rounded, size: 13,
                            color: AppColors.accent.withValues(alpha: 0.8)),
                          const SizedBox(width: 6),
                          Text(
                            widget.event.date.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.accent.withValues(alpha: 0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const Spacer(),
                          if (widget.event.isEndingSoon)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                widget.event.timeLeft,
                                style: const TextStyle(
                                  color: AppColors.error,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Title
                      Text(
                        widget.event.title,
                        style: GoogleFonts.racingSansOne(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Description
                      Text(
                        widget.event.description,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Department label
                      Row(
                        children: [
                          Icon(Icons.apartment_rounded, size: 12,
                            color: Colors.white.withValues(alpha: 0.3)),
                          const SizedBox(width: 4),
                          Text(
                            widget.event.department,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.35),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // CTA Button
                      _buildCTAButton(context),
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

  Widget _buildCTAButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EventDetailPage(event: widget.event)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.visibility_rounded, size: 18),
              const SizedBox(width: 6),
              const Text(
                'VIEW EVENT',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().shimmer(
      delay: 2500.ms,
      duration: 1500.ms,
      color: Colors.white.withValues(alpha: 0.12),
    );
  }
}
