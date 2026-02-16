import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import 'particle_field.dart';

/// Full-screen ambient background with gradient, animated glow orbs,
/// and floating particles. Use as the base layer for any screen.
class AmbientBackground extends StatelessWidget {
  final Widget child;
  final bool showParticles;
  final bool showOrbs;

  const AmbientBackground({
    super.key,
    required this.child,
    this.showParticles = true,
    this.showOrbs = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Base gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF060010),
                  Color(0xFF000000),
                ],
              ),
            ),
          ),

          // Animated glow orbs
          if (showOrbs) ...[
            Positioned(
              top: -80,
              right: -60,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.12),
                  ),
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 1.0, end: 1.25, duration: 5.seconds, curve: Curves.easeInOut)
                .moveY(begin: 0, end: 30, duration: 6.seconds, curve: Curves.easeInOut),

            Positioned(
              bottom: 60,
              left: -70,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.05),
                  ),
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 1.0, end: 1.35, duration: 7.seconds, curve: Curves.easeInOut)
                .moveX(begin: 0, end: 40, duration: 8.seconds, curve: Curves.easeInOut),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.5,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.neonCyan.withValues(alpha: 0.03),
                  ),
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(begin: -20, end: 20, duration: 9.seconds, curve: Curves.easeInOut),
          ],

          // Particles
          if (showParticles)
            Positioned.fill(
              child: ParticleField(
                particleCount: 18,
                color: AppColors.primary.withValues(alpha: 0.5),
                maxSize: 3.0,
                minSize: 1.0,
              ),
            ),

          // Content
          child,
        ],
      ),
    );
  }
}
