import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isUpdating = false;
  bool _success = false;

  void _submit() async {
    if (_currentController.text.isEmpty || _newController.text.isEmpty || _confirmController.text.isEmpty) {
      _showSnack('Please fill all fields');
      return;
    }
    if (_newController.text.length < 8) {
      _showSnack('Password must be at least 8 characters');
      return;
    }
    if (_newController.text != _confirmController.text) {
      _showSnack('Passwords do not match');
      return;
    }
    HapticFeedback.mediumImpact();
    setState(() => _isUpdating = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isUpdating = false;
        _success = true;
      });
      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted) Navigator.pop(context);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: 100,
            right: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonCyan.withValues(alpha: 0.06),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 6, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Lock icon
                        _buildLockIcon(),
                        const SizedBox(height: 28),
                        _buildPasswordField('Current Password', _currentController, _obscureCurrent, () {
                          setState(() => _obscureCurrent = !_obscureCurrent);
                        }),
                        const SizedBox(height: 18),
                        _buildPasswordField('New Password', _newController, _obscureNew, () {
                          setState(() => _obscureNew = !_obscureNew);
                        }),
                        const SizedBox(height: 18),
                        _buildPasswordField('Confirm New Password', _confirmController, _obscureConfirm, () {
                          setState(() => _obscureConfirm = !_obscureConfirm);
                        }),
                        const SizedBox(height: 14),
                        _buildPasswordHints(),
                        const SizedBox(height: 36),
                        _buildSubmitButton(),
                        const SizedBox(height: 40),
                      ].animate(interval: 60.ms).fade(duration: 400.ms).slideY(begin: 0.04, end: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, AppColors.neonCyan],
            ).createShader(bounds),
            child: Text(
              'CHANGE PASSWORD',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildLockIcon() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.neonCyan.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.15)),
        ),
        child: Icon(Icons.lock_reset_rounded, color: AppColors.neonCyan, size: 40),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscure, VoidCallback toggleObscure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: 0.05,
          color: Colors.white,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(Icons.lock_outline_rounded, color: AppColors.neonCyan.withValues(alpha: 0.4), size: 20),
              ),
              prefixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 40),
              suffixIcon: IconButton(
                onPressed: toggleObscure,
                icon: Icon(
                  obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.white.withValues(alpha: 0.3),
                  size: 20,
                ),
              ),
              hintText: 'Enter ${label.toLowerCase()}...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2), fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordHints() {
    final hints = [
      'At least 8 characters',
      'Include uppercase & lowercase',
      'Include a number or symbol',
    ];
    return GlassContainer(
      borderRadius: BorderRadius.circular(14),
      blur: 8,
      opacity: 0.04,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hints.map((h) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, size: 14, color: AppColors.accent.withValues(alpha: 0.5)),
              const SizedBox(width: 8),
              Text(h, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: _success ? null : const LinearGradient(colors: [AppColors.neonCyan, Color(0xFF00B8D4)]),
        color: _success ? AppColors.success : null,
        boxShadow: [
          BoxShadow(
            color: (_success ? AppColors.success : AppColors.neonCyan).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isUpdating || _success ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: _isUpdating
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
            : _success
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text('Password Updated!', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)),
                    ],
                  )
                : Text(
                    'UPDATE PASSWORD',
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.5),
                  ),
      ),
    );
  }
}
