import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_hackathon_data.dart';
import '../../../shared/widgets/countdown_timer.dart';
import '../../../shared/widgets/registration_status_bar.dart';

class HackathonCard extends StatefulWidget {
  final HackathonModel hackathon;
  final VoidCallback onTap;

  const HackathonCard({super.key, required this.hackathon, required this.onTap});

  @override
  State<HackathonCard> createState() => _HackathonCardState();
}

class _HackathonCardState extends State<HackathonCard> {
  bool _pressed = false;

  Color get _difficultyColor {
    switch (widget.hackathon.difficulty) {
      case 'Beginner':
        return AppColors.success;
      case 'Intermediate':
        return AppColors.warning;
      case 'Advanced':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  Color get _modeColor {
    switch (widget.hackathon.mode) {
      case 'Online':
        return AppColors.neonCyan;
      case 'Offline':
        return AppColors.neonPink;
      default:
        return AppColors.neonPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.hackathon;
    return AnimatedScale(
      duration: const Duration(milliseconds: 100),
      scale: _pressed ? 0.97 : 1.0,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(22),
          blur: 14,
          opacity: 0.06,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
          glowColor: const Color(0xFF00FF87),
          glowIntensity: _pressed ? 0.12 : 0.03,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Stack(
            children: [
              // Accent corner glow
              Positioned(
                top: -15,
                right: -15,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00FF87).withValues(alpha: 0.06),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: image + info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: 72,
                            height: 72,
                            color: AppColors.surfaceLight,
                            child: Image.network(h.imageUrl, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.memory_rounded, color: Colors.white24, size: 32),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Live badge + title
                              if (h.isLive)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.error)),
                                      const SizedBox(width: 4),
                                      Text('LIVE NOW', style: TextStyle(color: AppColors.error, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                                    ],
                                  ),
                                ),
                              Text(
                                h.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, height: 1.2),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'by ${h.organizer}',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Tags row
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildTag(h.mode, _modeColor),
                        _buildTag(h.difficulty, _difficultyColor),
                        _buildTag('Team: ${h.minTeamSize}-${h.maxTeamSize}', Colors.white.withValues(alpha: 0.6)),
                        if (h.fee == 0) _buildTag('FREE', AppColors.accent) else _buildTag('₹${h.fee.toInt()}', AppColors.accent),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Prize pool
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xFF00FF87).withValues(alpha: 0.08),
                          const Color(0xFF00FF87).withValues(alpha: 0.02),
                        ]),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF00FF87).withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        children: [
                          Text('🏆', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text('Prize Pool', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11)),
                          const Spacer(),
                          Text(h.prizePool, style: GoogleFonts.poppins(color: const Color(0xFF00FF87), fontSize: 15, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Deadline countdown
                    Row(
                      children: [
                        Text('Registration closes in: ', style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 10)),
                        CountdownTimer(deadline: h.registrationDeadline, color: AppColors.warning, fontSize: 10),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Registration bar
                    RegistrationStatusBar(filled: h.registeredTeams, total: h.maxTeams, color: const Color(0xFF00FF87)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
