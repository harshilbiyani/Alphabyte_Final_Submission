import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A text widget that renders with a gradient shader — used for headings.
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign textAlign;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.gradient = AppColors.neonGradient,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        textAlign: textAlign,
      ),
    );
  }
}
