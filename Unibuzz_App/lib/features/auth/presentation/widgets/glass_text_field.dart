import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../../../core/constants/app_colors.dart';

class GlassTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      height: 60,
      width: double.infinity,
      borderRadius: BorderRadius.circular(16),
      borderColor: AppColors.glassBorder,
      frostedOpacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              icon: icon != null ? Icon(icon, color: AppColors.accent) : null,
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.5)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
