import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../../../core/constants/app_colors.dart';

class ModernBackground extends StatelessWidget {
  final Widget child;
  const ModernBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Dynamic gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF0A0014), // Very dark purple
                  Color(0xFF000000),
                ],
              ),
            ),
          ),
          
          // Abstract Shape Top Left (Purple)
          Positioned(
            top: -100,
            left: -50,
            child: _AbstractShape(
              color: AppColors.primary,
              size: 400,
              rotation: 0.5,
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .moveY(begin: 0, end: 20, duration: 3.seconds, curve: Curves.easeInOut),
          ),

          // Abstract Shape Bottom Right (Lime/Accent)
          Positioned(
            bottom: -50,
            right: -50,
            child: _AbstractShape(
              color: AppColors.accent,
              size: 350,
              rotation: 2.5,
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .moveY(begin: 0, end: -20, duration: 4.seconds, curve: Curves.easeInOut),
          ),
          
          // Glass overlay/noise (optional, subtle texture)
          
          // Content
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class _AbstractShape extends StatelessWidget {
  final Color color;
  final double size;
  final double rotation;

  const _AbstractShape({
    required this.color,
    required this.size,
    required this.rotation,
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
              color.withOpacity(0.5),
              color.withOpacity(0.0),
            ],
            center: Alignment.center,
            radius: 0.6,
          ),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: CustomPaint(
          painter: _FluidPainter(color: color.withOpacity(0.3)),
        ),
      ),
    );
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
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Create a wavy abstract blob shape
    path.moveTo(w * 0.5, 0);
    path.quadraticBezierTo(w * 0.8, h * 0.2, w, h * 0.5);
    path.quadraticBezierTo(w * 0.8, h * 0.8, w * 0.5, h);
    path.quadraticBezierTo(w * 0.2, h * 0.8, 0, h * 0.5);
    path.quadraticBezierTo(w * 0.2, h * 0.2, w * 0.5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
