import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_mentor_data.dart';

class MentorProfilePopup extends StatelessWidget {
  final MentorModel mentor;

  const MentorProfilePopup({super.key, required this.mentor});

  static Future<void> show(BuildContext context, MentorModel mentor) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Mentor Profile',
      barrierColor: Colors.black.withValues(alpha: 0.75),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim, secondaryAnim, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return MentorProfilePopup(mentor: mentor);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          constraints: BoxConstraints(
            maxWidth: isWide ? 680 : screenWidth - 32,
            maxHeight: MediaQuery.of(context).size.height * 0.82,
          ),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(28),
            blur: 20,
            opacity: 0.08,
            color: Colors.white,
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            glowColor: AppColors.primary,
            glowIntensity: 0.08,
            child: Stack(
              children: [
                // Background accent orbs
                Positioned(
                  top: -30,
                  left: -30,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: -20,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.neonCyan.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                ),
                // Content
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    child: isWide
                        ? _buildWideLayout(context)
                        : _buildNarrowLayout(context),
                  ),
                ),
                // Close button
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Wide layout: Left (personal) | Right (about)
  Widget _buildWideLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side — Profile & Personal Details
          SizedBox(
            width: 220,
            child: _buildLeftPanel(),
          ),
          const SizedBox(width: 24),
          // Vertical divider
          Container(
            width: 1,
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Right side — About
          Expanded(child: _buildRightPanel()),
        ],
      ),
    );
  }

  /// Narrow layout: stacked vertically
  Widget _buildNarrowLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        children: [
          _buildLeftPanel(),
          const SizedBox(height: 20),
          // Horizontal separator
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildRightPanel(),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Column(
      children: [
        // Profile Picture with gradient ring
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryLight,
                  AppColors.primary,
                  AppColors.neonCyan.withValues(alpha: 0.7),
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
              child: CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.surfaceLight,
                backgroundImage: NetworkImage(mentor.imageUrl),
              ),
            ),
          ),
        ).animate().scale(begin: const Offset(0.8, 0.8), duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 18),
        // Name
        Text(
          mentor.name,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fade(duration: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 4),
        // Designation
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Text(
            mentor.designation,
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate().fade(duration: 400.ms, delay: 100.ms),
        const SizedBox(height: 8),
        // Profession
        Text(
          mentor.profession,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          mentor.department,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 16),
        // Stats row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBadge(Icons.star_rounded, mentor.rating.toString(), AppColors.accent),
            const SizedBox(width: 8),
            _buildStatBadge(Icons.people_rounded, '${mentor.menteeCount}', AppColors.neonCyan),
          ],
        ).animate().fade(duration: 400.ms, delay: 200.ms),
        const SizedBox(height: 18),
        // Expertise chips
        _buildSectionTitle('EXPERTISE'),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 6,
          children: mentor.expertise.map((e) => _buildChip(e, AppColors.primary)).toList(),
        ).animate().fade(duration: 400.ms, delay: 300.ms),
        const SizedBox(height: 14),
        // Experience
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.neonCyan.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.work_history_rounded, color: AppColors.neonCyan, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  mentor.experience,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fade(duration: 400.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildRightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About section
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, AppColors.primaryLight],
          ).createShader(bounds),
          child: Text(
            'About ${mentor.name.split(' ').first}',
            style: GoogleFonts.racingSansOne(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.neonGradient,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          mentor.about,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 13,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 24),
        // Specializations
        _buildSectionTitle('SPECIALIZATIONS'),
        const SizedBox(height: 10),
        ...mentor.specializations.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fade(duration: 300.ms, delay: (100 * entry.key).ms).slideX(begin: 0.05);
        }),
        const SizedBox(height: 20),
        // Achievements
        _buildSectionTitle('ACHIEVEMENTS'),
        const SizedBox(height: 10),
        ...mentor.achievements.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(12),
              blur: 8,
              opacity: 0.04,
              color: AppColors.accent,
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.08)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.emoji_events_rounded, color: AppColors.accent, size: 14),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 300.ms, delay: (80 * entry.key).ms).slideY(begin: 0.04);
        }),
        const SizedBox(height: 8),
      ],
    ).animate().fade(duration: 500.ms).slideX(begin: 0.03);
  }

  Widget _buildStatBadge(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.withValues(alpha: 0.8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
