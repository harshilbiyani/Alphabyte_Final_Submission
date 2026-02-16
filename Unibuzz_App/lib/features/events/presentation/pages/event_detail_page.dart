import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../home/data/mock_home_data.dart';
import 'create_team_page.dart';
import 'solo_registration_page.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  void _onRegisterTap(BuildContext context) {
    HapticFeedback.mediumImpact();
    if (event.isTeamEvent) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CreateTeamPage(event: event)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SoloRegistrationPage(event: event)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Ambient glow orbs ──
          Positioned(
            top: -80,
            right: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.04),
                ),
              ),
            ),
          ),
          // ── Particles ──
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 10, color: Colors.white, maxSize: 1.5, minSize: 0.5),
            ),
          ),
          // ── Content ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Image
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: AppColors.background,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => _onRegisterTap(context),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.accent, Color(0xFFB8E62E)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.bolt_rounded, color: Colors.black, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'REGISTER',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().shimmer(
                    delay: 2.seconds,
                    duration: 1500.ms,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        event.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceLight,
                          child: const Icon(Icons.broken_image, color: Colors.white24, size: 60),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                              AppColors.background,
                            ],
                            stops: const [0.3, 0.6, 1.0],
                          ),
                        ),
                      ),
                      // Category pill
                      Positioned(
                        bottom: 80,
                        left: 20,
                        child: GlassContainer(
                          borderRadius: BorderRadius.circular(30),
                          blur: 12,
                          opacity: 0.15,
                          color: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
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
                                    BoxShadow(color: AppColors.accent.withValues(alpha: 0.6), blurRadius: 4),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                event.category.toUpperCase(),
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
                      // Event type badge
                      if (event.isTeamEvent)
                        Positioned(
                          bottom: 80,
                          right: 20,
                          child: GlassContainer(
                            borderRadius: BorderRadius.circular(30),
                            blur: 12,
                            opacity: 0.15,
                            color: AppColors.neonCyan,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.3)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.groups_rounded, color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  'TEAM (${event.minTeamSize}-${event.maxTeamSize})',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // Title at bottom
                      Positioned(
                        bottom: 16,
                        left: 20,
                        right: 20,
                        child: Text(
                          event.title,
                          style: GoogleFonts.racingSansOne(
                            color: Colors.white,
                            fontSize: 34,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(color: AppColors.primary.withValues(alpha: 0.6), blurRadius: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Body content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // ── Quick Info Row ──
                      _buildQuickInfoRow(),
                      const SizedBox(height: 24),
                      // ── About Section ──
                      _buildSectionTitle('ABOUT'),
                      const SizedBox(height: 10),
                      _buildAboutSection(),
                      const SizedBox(height: 28),
                      // ── Rules Section ──
                      if (event.rules.isNotEmpty) ...[
                        _buildSectionTitle('RULES & GUIDELINES'),
                        const SizedBox(height: 10),
                        _buildRulesSection(),
                        const SizedBox(height: 28),
                      ],
                      // ── Prizes Section ──
                      if (event.prizes.isNotEmpty) ...[
                        _buildSectionTitle('PRIZES'),
                        const SizedBox(height: 10),
                        _buildPrizesSection(),
                        const SizedBox(height: 28),
                      ],
                      // ── Fee Section ──
                      _buildFeeSection(context),
                      const SizedBox(height: 120),
                    ].animate(interval: 60.ms).fade(duration: 400.ms).slideY(begin: 0.05, end: 0),
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom CTA ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomCTA(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoRow() {
    return Row(
      children: [
        _buildInfoChip(Icons.calendar_today_rounded, event.date),
        const SizedBox(width: 8),
        _buildInfoChip(Icons.access_time_rounded, event.time),
        const SizedBox(width: 8),
        Expanded(child: _buildInfoChip(Icons.location_on_rounded, event.venue)),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(12),
      blur: 8,
      opacity: 0.06,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.accent.withValues(alpha: 0.8)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [BoxShadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 6)],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.about.isNotEmpty ? event.about : event.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.apartment_rounded, size: 13, color: AppColors.primaryLight.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Text(
                'Organized by ${event.organizer}',
                style: TextStyle(
                  color: AppColors.primaryLight.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRulesSection() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(event.rules.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index < event.rules.length - 1 ? 14 : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      event.rules[index],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPrizesSection() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: event.prizes.length,
        itemBuilder: (context, index) {
          final prize = event.prizes[index];
          final bool isFirst = index == 0;
          return Container(
            width: 140,
            margin: EdgeInsets.only(right: 12, left: index == 0 ? 0 : 0),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(18),
              blur: 10,
              opacity: isFirst ? 0.10 : 0.05,
              color: isFirst ? AppColors.accent : Colors.white,
              border: Border.all(
                color: isFirst
                    ? AppColors.accent.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.1),
              ),
              glowColor: isFirst ? AppColors.accent : null,
              glowIntensity: isFirst ? 0.08 : 0,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    prize.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    prize.position,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prize.reward,
                    style: TextStyle(
                      color: isFirst ? AppColors.accent : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ).animate(delay: (80 * index).ms).fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
        },
      ),
    );
  }

  Widget _buildFeeSection(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 10,
      opacity: 0.06,
      color: AppColors.primary,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      glowColor: AppColors.primary,
      glowIntensity: 0.05,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.confirmation_number_rounded, color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Registration Fee',
                style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                event.fee > 0 ? '₹${event.fee.toStringAsFixed(0)}' : 'FREE',
                style: GoogleFonts.poppins(
                  color: AppColors.accent,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (event.isTeamEvent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.groups_rounded, color: Colors.white54, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${event.minTeamSize}-${event.maxTeamSize} members',
                    style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.background.withValues(alpha: 0.0),
                AppColors.background.withValues(alpha: 0.95),
                AppColors.background,
              ],
            ),
          ),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [AppColors.accent, Color(0xFFB8E62E)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _onRegisterTap(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.black, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    event.isTeamEvent ? 'CREATE TEAM & REGISTER' : 'REGISTER NOW',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().shimmer(delay: 1.seconds, duration: 2.seconds, color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
    );
  }
}
