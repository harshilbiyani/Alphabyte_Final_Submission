import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

/// "Your Skills. Verified On Chain." — personal stats banner.
class StatsBanner extends StatelessWidget {
  const StatsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => HapticFeedback.lightImpact(),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(22),
          blur: 16,
          opacity: 0.08,
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.2), width: 1),
          glowColor: AppColors.accent,
          glowIntensity: 0.06,
          child: Stack(
            children: [
              // Subtle accent glow orbs
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                bottom: -15,
                left: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [AppColors.white, AppColors.accent],
                                ).createShader(bounds),
                                child: Text(
                                  'YOUR SKILLS.',
                                  style: GoogleFonts.racingSansOne(
                                    fontSize: 22,
                                    color: Colors.white,
                                    height: 1.1,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    AppColors.accent.withValues(alpha: 0.8),
                                    Colors.white.withValues(alpha: 0.6),
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  'VERIFIED ON CHAIN.',
                                  style: GoogleFonts.racingSansOne(
                                    fontSize: 22,
                                    color: Colors.white,
                                    height: 1.1,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Chain icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                          ),
                          child: Icon(Icons.verified_rounded, color: AppColors.accent, size: 26),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Stats row
                    Row(
                      children: [
                        _StatItem(value: '12', label: 'Events', icon: Icons.calendar_today_rounded),
                        _StatDivider(),
                        _StatItem(value: '3', label: 'Wins', icon: Icons.emoji_events_rounded),
                        _StatDivider(),
                        _StatItem(value: '8', label: 'Certs', icon: Icons.workspace_premium_rounded),
                        _StatDivider(),
                        _StatItem(value: '420', label: 'Points', icon: Icons.star_rounded),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // CTA button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt_rounded, size: 16, color: AppColors.primaryLight),
                          const SizedBox(width: 6),
                          Text(
                            'VIEW SMART PORTFOLIO',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.primaryLight),
                        ],
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

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.accent.withValues(alpha: 0.7), size: 16),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.racingSansOne(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.0),
            Colors.white.withValues(alpha: 0.12),
            Colors.white.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}
