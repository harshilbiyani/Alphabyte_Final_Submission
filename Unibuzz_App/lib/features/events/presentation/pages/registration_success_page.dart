import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../home/data/mock_home_data.dart';

class RegistrationSuccessPage extends StatefulWidget {
  final EventModel event;
  final String? teamName;
  final List<Map<String, String>>? teamMembers;

  const RegistrationSuccessPage({
    super.key,
    required this.event,
    this.teamName,
    this.teamMembers,
  });

  @override
  State<RegistrationSuccessPage> createState() => _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage>
    with TickerProviderStateMixin {
  late final AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String get _ticketId => 'UB-${widget.event.id.padLeft(3, '0')}-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient glows
          Positioned(
            top: -100,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.08),
                ),
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 1.0, end: 1.3, duration: 4.seconds),
          Positioned(
            bottom: 50,
            right: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 1.0, end: 1.2, duration: 5.seconds),
          // Particles
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 20, color: Colors.white, maxSize: 2.0, minSize: 0.5),
            ),
          ),

          // Confetti
          AnimatedBuilder(
            animation: _confettiController,
            builder: (context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _ConfettiPainter(progress: _confettiController.value),
              );
            },
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Success checkmark
                  _buildSuccessIcon(),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    "You're in! 🎉",
                    style: GoogleFonts.racingSansOne(
                      color: Colors.white,
                      fontSize: 36,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 20),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    'Registration Confirmed',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 16),
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 36),
                  // Ticket card
                  _buildTicketCard(),
                  const SizedBox(height: 24),
                  // Details
                  if (widget.teamName != null) _buildTeamInfo(),
                  const SizedBox(height: 32),
                  // Actions
                  _buildActions(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.5),
            blurRadius: 50,
            spreadRadius: 8,
          ),
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.2),
            blurRadius: 80,
            spreadRadius: 20,
          ),
        ],
      ),
      child: const Icon(Icons.check_rounded, color: Colors.black, size: 56),
    )
        .animate()
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.elasticOut,
        )
        .then()
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scaleXY(begin: 1.0, end: 1.05, duration: 1500.ms);
  }

  Widget _buildTicketCard() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      blur: 14,
      opacity: 0.08,
      color: Colors.white,
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      glowColor: AppColors.accent,
      glowIntensity: 0.06,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  widget.event.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image, color: Colors.white24),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${widget.event.date} • ${widget.event.venue}',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children: List.generate(30, (i) {
                return Expanded(
                  child: Container(
                    height: 1,
                    color: i % 2 == 0 ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
                  ),
                );
              }),
            ),
          ),
          // Ticket ID & QR placeholder
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TICKET ID',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _ticketId,
                    style: GoogleFonts.sourceCodePro(
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // QR code placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(Icons.qr_code_2_rounded, color: Colors.black, size: 48),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.person_rounded, size: 14, color: Colors.white.withValues(alpha: 0.4)),
              const SizedBox(width: 6),
              Text(
                'Ansh D • 1032210899',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 800.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTeamInfo() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 10,
      opacity: 0.05,
      color: AppColors.neonCyan,
      border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.15)),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups_rounded, color: AppColors.neonCyan.withValues(alpha: 0.7), size: 18),
              const SizedBox(width: 8),
              Text(
                'Team: ${widget.teamName}',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: (widget.teamMembers ?? []).map((m) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: Text(
                  m['name']!,
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate(delay: 1.seconds).fadeIn(duration: 400.ms);
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        // Back to home
        Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFB8E62E)]),
            boxShadow: [
              BoxShadow(color: AppColors.accent.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8)),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            child: Text(
              'BACK TO HOME',
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: 0.5),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Share button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share functionality coming soon!'), backgroundColor: AppColors.primary),
              );
            },
            icon: const Icon(Icons.share_rounded, size: 18),
            label: Text(
              'SHARE WITH FRIENDS',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 0.5),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
          ),
        ),
      ],
    ).animate(delay: 1200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}

// Simple confetti painter
class _ConfettiPainter extends CustomPainter {
  final double progress;
  final Random _random = Random(42);

  _ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress >= 1.0) return;

    final colors = [
      AppColors.accent,
      AppColors.primary,
      AppColors.neonCyan,
      AppColors.neonPink,
      Colors.white,
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
    ];

    for (int i = 0; i < 50; i++) {
      final x = _random.nextDouble() * size.width;
      final startY = -20.0 - (_random.nextDouble() * 100);
      final endY = size.height + 50;
      final currentY = startY + (endY - startY) * progress;
      final wobbleX = x + sin(progress * 6 + i) * 30;

      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = colors[i % colors.length].withValues(alpha: opacity * 0.8)
        ..style = PaintingStyle.fill;

      final w = 4.0 + _random.nextDouble() * 4;
      final h = 3.0 + _random.nextDouble() * 6;

      canvas.save();
      canvas.translate(wobbleX, currentY);
      canvas.rotate(progress * 8 + i.toDouble());
      canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: w, height: h), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}
