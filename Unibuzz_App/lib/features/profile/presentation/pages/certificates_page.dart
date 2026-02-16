import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});

  static final List<Map<String, String>> _certificates = [
    {
      'event': 'Hackathon 24',
      'type': 'Winner — 1st Place',
      'date': 'Jan 15, 2026',
      'icon': '🏆',
    },
    {
      'event': 'AI Workshop',
      'type': 'Completion Certificate',
      'date': 'Jan 22, 2026',
      'icon': '🤖',
    },
    {
      'event': 'Code Sprint',
      'type': 'Runner Up — 2nd Place',
      'date': 'Feb 10, 2026',
      'icon': '🥈',
    },
    {
      'event': 'Debate Championship',
      'type': 'Participation Certificate',
      'date': 'Feb 08, 2026',
      'icon': '🗣️',
    },
    {
      'event': 'Startup Pitch Night',
      'type': 'Best Idea Award',
      'date': 'Feb 14, 2026',
      'icon': '💡',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFD700).withValues(alpha: 0.06),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 8, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _certificates.length,
                    itemBuilder: (context, index) => _buildCertCard(_certificates[index], index, context),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFFFFD700)],
            ).createShader(bounds),
            child: Text(
              'CERTIFICATES',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.2)),
            ),
            child: Text(
              '${_certificates.length} earned',
              style: TextStyle(color: const Color(0xFFFFD700).withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildCertCard(Map<String, String> cert, int index, BuildContext context) {
    final isWinner = cert['type']!.contains('Winner') || cert['type']!.contains('1st');
    final glowColor = isWinner ? const Color(0xFFFFD700) : AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(20),
        blur: 12,
        opacity: isWinner ? 0.08 : 0.05,
        color: glowColor,
        border: Border.all(color: glowColor.withValues(alpha: isWinner ? 0.25 : 0.12)),
        glowColor: isWinner ? glowColor : null,
        glowIntensity: isWinner ? 0.06 : 0,
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            // Certificate icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: glowColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: glowColor.withValues(alpha: 0.2)),
              ),
              child: Center(
                child: Text(cert['icon']!, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cert['event']!,
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    cert['type']!,
                    style: TextStyle(
                      color: isWinner ? const Color(0xFFFFD700) : AppColors.primaryLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cert['date']!,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 11),
                  ),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Download coming soon!'), backgroundColor: AppColors.primary),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.download_rounded, color: Colors.white.withValues(alpha: 0.5), size: 18),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share coming soon!'), backgroundColor: AppColors.primary),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.share_rounded, color: Colors.white.withValues(alpha: 0.5), size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate(delay: (60 * index).ms).fadeIn(duration: 350.ms).slideX(begin: 0.05, end: 0);
  }
}
