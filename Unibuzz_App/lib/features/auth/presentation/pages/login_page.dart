import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../services/auth_service.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/modern_background.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _prnController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);
    try {
      final email = _prnController.text.trim(); 
      await _authService.signIn(
        email: email,
        password: _passwordController.text.trim(),
      );
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = e.toString();
        if (errorMsg.contains('Failed host lookup')) {
          errorMsg = 'Connection Error: Please check Supabase URL in constants file.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModernBackground(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with neon glow
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.25),
                      AppColors.accent.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [AppColors.white, AppColors.accent],
                        ).createShader(bounds),
                        child: Text(
                          'UB',
                          style: GoogleFonts.racingSansOne(
                            fontSize: 40,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
               
               const SizedBox(height: 30),
               
               ShaderMask(
                 shaderCallback: (bounds) => LinearGradient(
                   colors: [AppColors.white, AppColors.primaryLight],
                 ).createShader(bounds),
                 child: Text(
                   'LOGIN TO\nYOUR ACCOUNT',
                   textAlign: TextAlign.center,
                   style: GoogleFonts.racingSansOne(
                     fontSize: 28,
                     color: AppColors.white,
                     letterSpacing: 1.2,
                   ),
                 ),
               ).animate().fadeIn().moveY(begin: 20, end: 0),
               
               const SizedBox(height: 40),
               
               // Glass form card
               ClipRRect(
                 borderRadius: BorderRadius.circular(24),
                 child: BackdropFilter(
                   filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                   child: Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(24),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(24),
                       color: Colors.white.withValues(alpha: 0.04),
                       border: Border.all(
                         color: AppColors.glassBorder.withValues(alpha: 0.15),
                       ),
                       boxShadow: [
                         BoxShadow(
                           color: AppColors.primary.withValues(alpha: 0.06),
                           blurRadius: 30,
                           offset: const Offset(0, 10),
                         ),
                       ],
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Enter your login information',
                           style: TextStyle(
                             color: Colors.white.withValues(alpha: 0.5),
                             fontSize: 13,
                           ),
                         ),
                         const SizedBox(height: 28),
                         
                         GlassTextField(
                           controller: _prnController,
                           hintText: 'College Email / PRN',
                           icon: Icons.person_outline,
                         ),
                         
                         const SizedBox(height: 16),
                         
                         GlassTextField(
                           controller: _passwordController,
                           hintText: 'Password',
                           obscureText: true,
                           icon: Icons.lock_outline,
                         ),
                         
                         const SizedBox(height: 40),
                         
                         GlassButton(
                           onPressed: _login,
                           text: 'LOGIN',
                           isLoading: _isLoading,
                         ),
                         
                         const SizedBox(height: 20),
                         
                         Center(
                           child: GestureDetector(
                             onTap: () {
                               Navigator.push(
                                 context, 
                                 MaterialPageRoute(builder: (_) => const SignupPage())
                               );
                             },
                             child: RichText(
                               text: TextSpan(
                                 text: "Don't have an account? ",
                                 style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                                 children: const [
                                   TextSpan(
                                     text: 'Sign Up',
                                     style: TextStyle(
                                       color: AppColors.accent,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
