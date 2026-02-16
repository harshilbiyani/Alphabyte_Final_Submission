import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/modern_background.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _codeController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  void _verify() async {
    setState(() => _isLoading = true);
    try {
      await _authService.verifyOtp(
        email: widget.email,
        token: _codeController.text.trim(),
      );
      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verified! Please login.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModernBackground(
      child: Column(
        children: [
          // Back button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon with glow
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.mail_outline_rounded, color: AppColors.accent, size: 36),
                    ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                    const SizedBox(height: 24),
                    Text(
                      'Verification',
                      style: GoogleFonts.racingSansOne(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 10),
                    Text(
                      'Enter the code sent to\n${widget.email}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14, height: 1.4),
                    ).animate().fadeIn(delay: 100.ms),
                    const SizedBox(height: 36),
                    GlassTextField(
                      controller: _codeController,
                      hintText: 'Enter Verification Code',
                      icon: Icons.security_rounded,
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 24),
                    GlassButton(
                      onPressed: _verify,
                      text: 'VERIFY',
                      isLoading: _isLoading,
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
