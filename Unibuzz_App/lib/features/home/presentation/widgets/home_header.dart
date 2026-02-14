import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/page_transitions.dart';
import '../../../notifications/presentation/pages/notification_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      floating: false,
      expandedHeight: 90.0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.0),
                ],
              ),
            ),
            child: const FlexibleSpaceBar(
              background: SizedBox(),
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with glow
          Image.asset(
            'assets/images/unibuzz_logo.png',
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    AppColors.white,
                    AppColors.accent.withValues(alpha: 0.8),
                  ],
                ).createShader(bounds),
                child: Text(
                  'UniBuzz',
                  style: GoogleFonts.racingSansOne(
                    fontSize: 28,
                    color: Colors.white, // base color, masked by shader
                  ),
                ),
              );
            },
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),

          // Action Icons
          Row(
            children: [
              _NotificationBell(),
              const SizedBox(width: 12),
              _ProfileAvatar(),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.1, end: 0),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SlideUpRoute(page: const NotificationPage()),
        );
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 22),
            Positioned(
              top: 9,
              right: 9,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .scaleXY(begin: 1.0, end: 1.3, duration: 1200.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
