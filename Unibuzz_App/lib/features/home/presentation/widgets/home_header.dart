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
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.7),
                  Colors.black.withValues(alpha: 0.0),
                ],
              ),
            ),
            child: const FlexibleSpaceBar(background: SizedBox()),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with neon gradient glow
          Image.asset(
            'assets/images/unibuzz_logo.png',
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.white, AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  'UniBuzz',
                  style: GoogleFonts.racingSansOne(
                    fontSize: 30,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.08, end: 0),

          Row(
            children: [
              const _NotificationBell(),
              const SizedBox(width: 10),
              const _ProfileAvatar(),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.08, end: 0),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, SlideUpRoute(page: const NotificationPage()));
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
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
                      color: AppColors.accent.withValues(alpha: 0.7),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .scaleXY(begin: 1.0, end: 1.4, duration: 1200.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
