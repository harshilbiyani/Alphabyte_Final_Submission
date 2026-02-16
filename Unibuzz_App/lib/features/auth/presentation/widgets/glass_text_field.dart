import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class GlassTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.icon,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _focused
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.glassBorder.withValues(alpha: 0.3),
          width: _focused ? 1.2 : 1,
        ),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 14,
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: Colors.white.withValues(alpha: 0.04),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: TextField(
                controller: widget.controller,
                obscureText: widget.obscureText,
                style: const TextStyle(color: AppColors.white, fontSize: 15),
                cursorColor: AppColors.accent,
                onTap: () => setState(() => _focused = true),
                onEditingComplete: () => setState(() => _focused = false),
                onSubmitted: (_) => setState(() => _focused = false),
                decoration: InputDecoration(
                  icon: widget.icon != null
                      ? Icon(widget.icon, color: _focused ? AppColors.accent : AppColors.accent.withValues(alpha: 0.6), size: 20)
                      : null,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
