import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_text_field.dart';

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
        // Navigate to home or show success
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
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: AppColors.background,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verification',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter the code sent to ${widget.email}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 30),
                  GlassTextField(
                    controller: _codeController,
                    hintText: 'Enter Code',
                    icon: Icons.security,
                  ),
                  const SizedBox(height: 24),
                  GlassButton(
                    onPressed: _verify,
                    text: 'Verify',
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
