import 'package:flutter/material.dart';

class AppColors {
  // ── Base ──
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF0A0A0F);
  static const Color surfaceLight = Color(0xFF141420);

  // ── Brand ──
  static const Color primary = Color(0xFF7D39EB);
  static const Color primaryLight = Color(0xFF9B5FFF);
  static const Color primaryDark = Color(0xFF5B1FBF);
  static const Color accent = Color(0xFFC6FF33);
  static const Color accentDark = Color(0xFF9BCC1A);

  // ── Typography ──
  static const Color white = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textTertiary = Color(0xFF6E6E80);

  // ── Glass ──
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color glassBorderLight = Color(0x22FFFFFF);
  static const Color glassBackground = Color(0x1AFFFFFF);
  static const Color glassBackgroundDark = Color(0x0DFFFFFF);

  // ── Neon Glow ──
  static const Color neonPurple = Color(0xFF9B5FFF);
  static const Color neonGreen = Color(0xFFC6FF33);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonPink = Color(0xFFFF4DA6);

  // ── Status ──
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF4444);

  // ── Gradients ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7D39EB), Color(0xFF9B5FFF)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC6FF33), Color(0xFFA8E600)],
  );

  static const LinearGradient neonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7D39EB), Color(0xFFC6FF33)],
  );

  static const LinearGradient darkFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xDD000000)],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A0014), Color(0xFF000000), Color(0xFF05000A)],
  );

  static LinearGradient glassGradient({double opacity = 0.08}) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: opacity),
      Colors.white.withValues(alpha: opacity * 0.3),
    ],
  );
}
