import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class MentorThankYouDialog extends StatelessWidget {
  final String mentorName;

  const MentorThankYouDialog({super.key, required this.mentorName});

  static Future<void> show(BuildContext context, String mentorName) {
    HapticFeedback.heavyImpact();
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Thank You',
      barrierColor: Colors.black.withValues(alpha: 0.8),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, anim, secondaryAnim, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return MentorThankYouDialog(mentorName: mentorName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          constraints: const BoxConstraints(maxWidth: 380),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(32),
            blur: 24,
            opacity: 0.1,
            color: Colors.white,
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            glowColor: AppColors.accent,
            glowIntensity: 0.12,
            padding: const EdgeInsets.all(32),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Background glow
                Positioned(
                  top: -40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated checkmark
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.accent.withValues(alpha: 0.2),
                            AppColors.accent.withValues(alpha: 0.08),
                          ],
                        ),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.3),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.accent,
                        size: 48,
                      ),
                    )
                        .animate()
                        .scale(begin: const Offset(0.5, 0.5), duration: 500.ms, curve: Curves.easeOutBack)
                        .fade(duration: 400.ms),
                    const SizedBox(height: 24),
                    // Title
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.accent, AppColors.neonCyan],
                      ).createShader(bounds),
                      child: Text(
                        'Request Sent! 🚀',
                        style: GoogleFonts.racingSansOne(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ).animate().fade(duration: 400.ms, delay: 200.ms).slideY(begin: 0.1),
                    const SizedBox(height: 12),
                    // Message
                    Text(
                      'Thank you for reaching out!\n$mentorName will review your request and connect with you soon.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ).animate().fade(duration: 400.ms, delay: 300.ms),
                    const SizedBox(height: 8),
                    Text(
                      'Keep an eye on your notifications 🔔',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 11,
                      ),
                    ).animate().fade(duration: 400.ms, delay: 400.ms),
                    const SizedBox(height: 28),
                    // Back to mentors button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context); // close dialog
                        Navigator.pop(context); // go back to mentor list
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.accent, AppColors.accent.withValues(alpha: 0.8)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Back to Mentors',
                            style: GoogleFonts.poppins(
                              color: AppColors.background,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ).animate().fade(duration: 400.ms, delay: 500.ms).slideY(begin: 0.1),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
