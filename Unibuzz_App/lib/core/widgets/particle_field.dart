import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Floating ambient particles that pulse and drift — creates festival atmosphere.
class ParticleField extends StatefulWidget {
  final int particleCount;
  final Color color;
  final double maxSize;
  final double minSize;

  const ParticleField({
    super.key,
    this.particleCount = 20,
    this.color = AppColors.primary,
    this.maxSize = 4.0,
    this.minSize = 1.5,
  });

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(widget.particleCount, (_) => _generateParticle());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  _Particle _generateParticle() {
    return _Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      size: widget.minSize + _random.nextDouble() * (widget.maxSize - widget.minSize),
      speed: 0.02 + _random.nextDouble() * 0.04,
      opacity: 0.15 + _random.nextDouble() * 0.45,
      phase: _random.nextDouble() * 2 * pi,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size.infinite,
            painter: _ParticlePainter(
              particles: _particles,
              progress: _controller.value,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _Particle {
  double x, y, size, speed, opacity, phase;
  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.phase,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed * 10 + p.phase) % 1.0;
      final dx = p.x * size.width + sin(t * 2 * pi + p.phase) * 20;
      final dy = (p.y - progress * p.speed * 2) % 1.0 * size.height;
      final pulse = 0.5 + 0.5 * sin(progress * 2 * pi * 3 + p.phase);
      final currentOpacity = p.opacity * (0.4 + pulse * 0.6);

      final paint = Paint()
        ..color = color.withValues(alpha: currentOpacity.clamp(0.0, 1.0))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 1.5);

      canvas.drawCircle(Offset(dx, dy), p.size * (0.8 + pulse * 0.4), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

/// A subtle ambient glow orb that breathes in and out.
class GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const GlowOrb({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: size * 0.8,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
    );
  }
}
