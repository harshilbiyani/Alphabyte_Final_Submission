import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../../../../core/constants/app_colors.dart';

class GlassButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: GlassContainer.clearGlass(
        height: 50,
        width: double.infinity,
        borderRadius: BorderRadius.circular(16),
        borderColor: AppColors.accent,
        color: AppColors.primary.withOpacity(0.5),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: AppColors.accent)
              : Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
