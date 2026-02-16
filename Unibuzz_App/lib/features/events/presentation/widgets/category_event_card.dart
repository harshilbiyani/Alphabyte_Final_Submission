import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../home/data/mock_home_data.dart';
import '../pages/event_detail_page.dart';

/// A reusable event card for category pages. Adapts based on [variant].
class CategoryEventCard extends StatefulWidget {
  final EventModel event;
  final CategoryCardVariant variant;
  final Color accentColor;

  const CategoryEventCard({
    super.key,
    required this.event,
    this.variant = CategoryCardVariant.standard,
    this.accentColor = AppColors.primary,
  });

  @override
  State<CategoryEventCard> createState() => _CategoryEventCardState();
}

enum CategoryCardVariant { standard, hackathon, sports, gaming, workshop, club, fest }

class _CategoryEventCardState extends State<CategoryEventCard> {
  bool _pressed = false;
  bool _saved = false;

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
          MaterialPageRoute(builder: (_) => EventDetailPage(event: widget.event)),
        );
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14, left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withValues(alpha: _pressed ? 0.15 : 0.06),
                blurRadius: _pressed ? 24 : 14,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(20),
            blur: 14,
            opacity: 0.06,
            color: Colors.white,
            border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image header
                _buildImageHeader(),
                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + save
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.event.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() => _saved = !_saved);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _saved
                                    ? widget.accentColor.withValues(alpha: 0.15)
                                    : Colors.white.withValues(alpha: 0.04),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _saved
                                      ? widget.accentColor.withValues(alpha: 0.3)
                                      : Colors.white.withValues(alpha: 0.06),
                                ),
                              ),
                              child: Icon(
                                _saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                color: _saved ? widget.accentColor : Colors.white.withValues(alpha: 0.3),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Description
                      Text(
                        widget.event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Info chips row
                      _buildInfoRow(),
                      const SizedBox(height: 12),
                      // Bottom row: fee + register button
                      _buildBottomRow(context),
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

  Widget _buildImageHeader() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          // Image
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Image.network(
              widget.event.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surfaceLight,
                child: Center(
                  child: Icon(Icons.image_rounded, color: Colors.white.withValues(alpha: 0.2), size: 40),
                ),
              ),
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ),
          // Category chip
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: widget.accentColor.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Text(
                widget.event.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Time left badge
          if (widget.event.timeLeft.isNotEmpty)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_rounded, color: AppColors.accent, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      widget.event.timeLeft,
                      style: TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _infoChip(Icons.calendar_today_rounded, widget.event.date),
        _infoChip(Icons.location_on_rounded, widget.event.venue),
        if (widget.event.isTeamEvent)
          _infoChip(Icons.groups_rounded, '${widget.event.minTeamSize}-${widget.event.maxTeamSize} members'),
        if (widget.event.organizer.isNotEmpty)
          _infoChip(Icons.business_rounded, widget.event.organizer),
      ],
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.35), size: 12),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      children: [
        // Fee or Free badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: widget.event.fee == 0
                ? AppColors.success.withValues(alpha: 0.1)
                : AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.event.fee == 0
                  ? AppColors.success.withValues(alpha: 0.2)
                  : AppColors.accent.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            widget.event.fee == 0 ? 'FREE' : '₹${widget.event.fee.toInt()}',
            style: TextStyle(
              color: widget.event.fee == 0 ? AppColors.success : AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (widget.event.prizes.isNotEmpty) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.warning.withValues(alpha: 0.15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 10)),
                const SizedBox(width: 3),
                Text(
                  widget.event.prizes.first.reward,
                  style: TextStyle(
                    color: AppColors.warning,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
        const Spacer(),
        // Register button
        GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EventDetailPage(event: widget.event)),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.accentColor, widget.accentColor.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                const SizedBox(width: 4),
                Text(
                  'Register',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
