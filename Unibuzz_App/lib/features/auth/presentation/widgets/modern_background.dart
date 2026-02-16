import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/particle_field.dart';

class ModernBackground extends StatelessWidget {
  final Widget child;
  const ModernBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
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
                    Color(0xFF0A0014),
                    Color(0xFF050008),
                    Color(0xFF000000),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),

            // Primary orb (top-left)
            Positioned(
              top: -120,
              left: -60,
              child: _AnimatedOrb(
                color: AppColors.primary,
                size: 380,
                rotation: 0.5,
                moveY: 25,
                duration: const Duration(seconds: 4),
              ),
            ),

            // Accent orb (bottom-right)
            Positioned(
              bottom: -80,
              right: -60,
              child: _AnimatedOrb(
                color: AppColors.accent,
                size: 320,
                rotation: 2.5,
                moveY: -20,
                duration: const Duration(seconds: 5),
              ),
            ),

            // Cyan accent orb (mid-right)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              right: -80,
              child: _AnimatedOrb(
                color: AppColors.neonCyan,
                size: 180,
                rotation: 1.2,
                moveY: 15,
                duration: const Duration(seconds: 6),
              ),
            ),

            // Subtle particle field
            const Positioned.fill(
              child: IgnorePointer(
                child: ParticleField(
                  particleCount: 20,
                  color: Colors.white,
                  maxSize: 1.5,
                ),
              ),
            ),

            // Content
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _AnimatedOrb extends StatelessWidget {
  final Color color;
  final double size;
  final double rotation;
  final double moveY;
  final Duration duration;

  const _AnimatedOrb({
    required this.color,
    required this.size,
    required this.rotation,
    required this.moveY,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.45),
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
            center: Alignment.center,
            radius: 0.6,
          ),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: CustomPaint(
          painter: _FluidPainter(color: color.withValues(alpha: 0.25)),
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .moveY(begin: 0, end: moveY, duration: duration, curve: Curves.easeInOut);
  }
}

class _FluidPainter extends CustomPainter {
  final Color color;
  _FluidPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 35);

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.quadraticBezierTo(w * 0.85, h * 0.15, w, h * 0.5);
    path.quadraticBezierTo(w * 0.85, h * 0.85, w * 0.5, h);
    path.quadraticBezierTo(w * 0.15, h * 0.85, 0, h * 0.5);
    path.quadraticBezierTo(w * 0.15, h * 0.15, w * 0.5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
