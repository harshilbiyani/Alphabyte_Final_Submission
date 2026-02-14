import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable liquid glass container with frosted blur, gradient shine,
/// and subtle border glow. The signature UI component of UniBuzz.
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

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 12,
    this.opacity = 0.15,
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
  });

  @override
  Widget build(BuildContext context) {
    final br = shape == BoxShape.circle
        ? BorderRadius.circular(1000)
        : (borderRadius ?? BorderRadius.circular(20));

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
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
                      color.withValues(alpha: opacity * 0.4),
                    ],
                  ),
              border: border ??
                  Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1.0,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
