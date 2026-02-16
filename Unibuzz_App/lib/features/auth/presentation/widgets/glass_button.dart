import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/constants/app_colors.dart';

class GlassButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const GlassButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        if (!widget.isLoading) {
          HapticFeedback.lightImpact();
          widget.onPressed();
        }
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: _pressed ? 0.7 : 0.5),
                AppColors.primary.withValues(alpha: _pressed ? 0.5 : 0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: _pressed ? 0.8 : 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _pressed ? 0.3 : 0.15),
                blurRadius: _pressed ? 18 : 10,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.accent.withValues(alpha: _pressed ? 0.15 : 0.05),
                blurRadius: 20,
                spreadRadius: -4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                        width: 22, height: 22,
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.text,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
