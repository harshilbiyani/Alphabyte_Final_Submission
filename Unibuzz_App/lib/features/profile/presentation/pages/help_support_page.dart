import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  int _expandedIndex = -1;

  static const List<Map<String, String>> _faqs = [
    {
      'q': 'How do I register for an event?',
      'a': 'Tap on any event card to view details, then hit the "Register" button. For team events, you\'ll need to create a team first.',
    },
    {
      'q': 'Can I leave a team after joining?',
      'a': 'Yes! Go to your team page and tap "Leave Team". Note that if you\'re the team leader, leadership will transfer to another member.',
    },
    {
      'q': 'How do I get my certificate?',
      'a': 'Certificates are automatically added to your profile after the event organizer marks attendance. Check the Certificates section in your profile.',
    },
    {
      'q': 'What if I can\'t attend after registering?',
      'a': 'You can cancel your registration from the Event History page up to 24 hours before the event. Refunds are processed within 3-5 days.',
    },
    {
      'q': 'How do I change my profile details?',
      'a': 'Go to Profile → Edit Profile. You can update your name, bio, interests, and contact info. PRN and department are linked to your college account and can\'t be changed here.',
    },
    {
      'q': 'Is my payment information secure?',
      'a': 'Absolutely. We use 256-bit SSL encryption and never store your card details. All payments are processed through certified payment gateways.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: 80,
            left: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.06),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 6, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Help icon
                        _buildHelpIcon(),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            'How can we help?',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Find answers to common questions below',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 28),
                        // FAQs
                        _buildSectionLabel('FREQUENTLY ASKED QUESTIONS'),
                        const SizedBox(height: 10),
                        _buildFAQs(),
                        const SizedBox(height: 28),
                        // Contact section
                        _buildSectionLabel('CONTACT US'),
                        const SizedBox(height: 10),
                        _buildContactCards(),
                        const SizedBox(height: 28),
                        // Report bug
                        _buildReportBugButton(),
                        const SizedBox(height: 40),
                      ].animate(interval: 60.ms).fade(duration: 400.ms).slideY(begin: 0.04, end: 0),
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

  Widget _buildHeader() {
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
              colors: [Colors.white, AppColors.primaryLight],
            ).createShader(bounds),
            child: Text(
              'HELP & SUPPORT',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildHelpIcon() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.15)),
        ),
        child: Icon(Icons.support_agent_rounded, color: AppColors.primaryLight, size: 40),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  Widget _buildFAQs() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: List.generate(_faqs.length, (i) {
          final faq = _faqs[i];
          final isExpanded = _expandedIndex == i;
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _expandedIndex = isExpanded ? -1 : i);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: isExpanded ? 0.15 : 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: isExpanded ? AppColors.primaryLight : Colors.white38,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          faq['q']!,
                          style: TextStyle(
                            color: isExpanded ? Colors.white : Colors.white.withValues(alpha: 0.7),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(58, 0, 18, 16),
                  child: Text(
                    faq['a']!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
              if (i < _faqs.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Divider(height: 1, color: Colors.white.withValues(alpha: 0.04)),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContactCards() {
    return Row(
      children: [
        Expanded(
          child: _buildContactTile(
            icon: Icons.email_rounded,
            label: 'Email Us',
            value: 'support@unibuzz.app',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildContactTile(
            icon: Icons.chat_rounded,
            label: 'Live Chat',
            value: 'Available 9am-6pm',
            color: AppColors.neonCyan,
          ),
        ),
      ],
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 10,
      opacity: 0.06,
      color: color,
      border: Border.all(color: color.withValues(alpha: 0.15)),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildReportBugButton() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bug report form coming soon!'), backgroundColor: AppColors.primary),
        );
      },
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        blur: 10,
        opacity: 0.06,
        color: AppColors.error,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.15)),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.bug_report_rounded, color: AppColors.error, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Report a Bug', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  Text(
                    'Found something broken? Let us know',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 11),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.2), size: 20),
          ],
        ),
      ),
    );
  }
}
