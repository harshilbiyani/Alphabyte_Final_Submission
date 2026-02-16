import 'dart:ui';
import 'package:flutter/material.dart';

/// Enhanced liquid glass container with neon glow, depth shadows,
/// light reflection, and border shimmer support.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final BoxShape shape;
  final double? width;
  final double? height;
  final Color? glowColor;
  final double glowIntensity;
  final bool showReflection;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 14,
    this.opacity = 0.12,
    this.color = Colors.white,
    this.borderRadius,
    this.padding,
    this.margin,
    this.gradient,
    this.border,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
    this.width,
    this.height,
    this.glowColor,
    this.glowIntensity = 0.0,
    this.showReflection = false,
  });

  @override
  Widget build(BuildContext context) {
    final br = shape == BoxShape.circle
        ? BorderRadius.circular(1000)
        : (borderRadius ?? BorderRadius.circular(20));

    final List<BoxShadow> shadows = boxShadow ?? [];
    final List<BoxShadow> allShadows = [
      ...shadows,
      if (glowColor != null && glowIntensity > 0)
        BoxShadow(
          color: glowColor!.withValues(alpha: glowIntensity.clamp(0.0, 1.0)),
          blurRadius: 24 + (glowIntensity * 20),
          spreadRadius: glowIntensity * 4,
        ),
    ];

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: allShadows.isNotEmpty ? allShadows : null,
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : br,
      ),
      child: ClipRRect(
        borderRadius: br,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              shape: shape,
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: opacity),
                      color.withValues(alpha: opacity * 0.3),
                    ],
                  ),
              border: border ??
                  Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                    width: 1.0,
                  ),
            ),
            child: Stack(
              children: [
                if (showReflection)
                  Positioned(
                    top: -10,
                    left: 10,
                    right: 40,
                    child: IgnorePointer(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.08),
                              Colors.white.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
