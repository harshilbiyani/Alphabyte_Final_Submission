import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../home/data/mock_home_data.dart';
import 'payment_page.dart';

class ConfirmParticipationPage extends StatelessWidget {
  final EventModel event;
  final String? teamName;
  final List<Map<String, String>>? teamMembers;

  const ConfirmParticipationPage({
    super.key,
    required this.event,
    this.teamName,
    this.teamMembers,
  });

  bool get isTeamRegistration => teamName != null && teamMembers != null;

  void _payAndProceed(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentPage(
          event: event,
          teamName: teamName,
          teamMembers: teamMembers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient glows
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.primary.withValues(alpha: 0.15), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.neonCyan.withValues(alpha: 0.06), Colors.transparent],
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 10, color: Colors.white, maxSize: 1.0),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildEventSummaryCard(),
                        const SizedBox(height: 24),
                        _buildParticipantDetails(),
                        if (isTeamRegistration) ...[
                          const SizedBox(height: 24),
                          _buildTeamDetails(),
                        ],
                        const SizedBox(height: 24),
                        _buildFeeBreakdown(),
                        const SizedBox(height: 24),
                        _buildConfirmationNotice(),
                        const SizedBox(height: 40),
                        _buildCTAButton(context),
                        const SizedBox(height: 40),
                      ].animate(interval: 80.ms).fade().slideY(begin: 0.04, end: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withValues(alpha: 0.03), Colors.transparent],
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  'CONFIRM REGISTRATION',
                  style: GoogleFonts.racingSansOne(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildEventSummaryCard() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 12,
      opacity: 0.1,
      color: AppColors.primary,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 25, offset: const Offset(0, 8)),
        BoxShadow(color: AppColors.neonCyan.withValues(alpha: 0.06), blurRadius: 40),
      ],
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  event.imageUrl,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 90,
                    width: 90,
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image, color: Colors.white24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.date,
                      style: TextStyle(color: AppColors.accent.withValues(alpha: 0.9), fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 12, color: Colors.white.withValues(alpha: 0.5)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.venue,
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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

  Widget _buildParticipantDetails() {
    final details = {
      'Full Name': 'Ansh D',
      'PRN': '1032210899',
      'Department': 'Computer Science',
      'Year': 'Third Year',
      'Email': 'anshd@college.edu',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR DETAILS',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 10),
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          blur: 10,
          opacity: 0.06,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          child: Column(
            children: details.entries.map((e) => _buildDetailRow(e.key, e.value)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14)),
          Row(
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(width: 8),
              Icon(Icons.lock_outline, size: 12, color: AppColors.accent.withValues(alpha: 0.5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TEAM DETAILS',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 10),
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          blur: 10,
          opacity: 0.06,
          color: AppColors.neonCyan,
          border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.15)),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team name
              Row(
                children: [
                  Icon(Icons.groups_rounded, color: AppColors.neonCyan.withValues(alpha: 0.7), size: 20),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team Name',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
                      ),
                      Text(
                        teamName ?? '',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.neonCyan.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${teamMembers?.length ?? 0} Members',
                      style: TextStyle(
                        color: AppColors.neonCyan,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Team members list
              ...List.generate(teamMembers?.length ?? 0, (index) {
                final member = teamMembers![index];
                final isLeader = index == 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isLeader
                              ? AppColors.accent.withValues(alpha: 0.15)
                              : AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: isLeader
                              ? Icon(Icons.star_rounded, color: AppColors.accent, size: 16)
                              : Text(
                                  member['name']![0],
                                  style: TextStyle(
                                    color: AppColors.primaryLight,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  member['name']!,
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                if (isLeader) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      'LEADER',
                                      style: TextStyle(color: AppColors.accent, fontSize: 7, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              member['prn']!,
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeeBreakdown() {
    final regFee = event.fee;
    final platformFee = regFee > 0 ? 19.0 : 0.0;
    final total = regFee + platformFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FEE BREAKDOWN',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 10),
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          blur: 10,
          opacity: 0.06,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              _buildFeeRow('Registration Fee', regFee > 0 ? '₹${regFee.toStringAsFixed(0)}' : 'FREE'),
              if (regFee > 0) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
                ),
                _buildFeeRow('Platform Fee', '₹${platformFee.toStringAsFixed(0)}'),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: Colors.white.withValues(alpha: 0.1), height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    total > 0 ? '₹${total.toStringAsFixed(0)}' : 'FREE',
                    style: GoogleFonts.poppins(
                      color: AppColors.accent,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeeRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildConfirmationNotice() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(14),
      blur: 8,
      opacity: 0.08,
      color: AppColors.primary,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info_outline, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'By proceeding, you agree to the event rules and terms. Your registration details will be shared with the organizer.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    final total = event.fee + (event.fee > 0 ? 19.0 : 0.0);

    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFB8E62E)]),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _payAndProceed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.payment_rounded, color: Colors.black, size: 20),
            const SizedBox(width: 8),
            Text(
              total > 0 ? 'PAY ₹${total.toStringAsFixed(0)} & PROCEED' : 'CONFIRM & PROCEED',
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
    ).animate().shimmer(delay: 1.seconds, duration: 2.seconds, color: Colors.white.withValues(alpha: 0.12));
  }
}
