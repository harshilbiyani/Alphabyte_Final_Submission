import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

/// Neon energy-style button with glow, bounce feedback, and shimmer.
class NeonButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final bool outlined;
  final IconData? icon;

  const NeonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.color = AppColors.accent,
    this.textColor = Colors.black,
    this.height = 52,
    this.borderRadius = 16,
    this.outlined = false,
    this.icon,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        if (!widget.isLoading) widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.outlined ? Colors.transparent : widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.outlined
                ? Border.all(color: widget.color, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: _pressed ? 0.5 : 0.25),
                blurRadius: _pressed ? 30 : 16,
                offset: const Offset(0, 4),
                spreadRadius: _pressed ? 2 : 0,
              ),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: widget.outlined ? widget.color : widget.textColor,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: widget.outlined ? widget.color : widget.textColor,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: widget.outlined ? widget.color : widget.textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ).animate().shimmer(
      delay: 2.seconds,
      duration: 1500.ms,
      color: Colors.white.withValues(alpha: 0.15),
    );
  }
}
