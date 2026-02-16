import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../../home/data/mock_home_data.dart';
import 'registration_success_page.dart';

class PaymentPage extends StatefulWidget {
  final EventModel event;
  final String? teamName;
  final List<Map<String, String>>? teamMembers;

  const PaymentPage({
    super.key,
    required this.event,
    this.teamName,
    this.teamMembers,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = 'upi';
  bool _isProcessing = false;

  double get _regFee => widget.event.fee;
  double get _platformFee => _regFee > 0 ? 19.0 : 0.0;
  double get _total => _regFee + _platformFee;

  void _processPayment() async {
    HapticFeedback.mediumImpact();
    setState(() => _isProcessing = true);
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isProcessing = false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => RegistrationSuccessPage(
            event: widget.event,
            teamName: widget.teamName,
            teamMembers: widget.teamMembers,
          ),
        ),
        (route) => route.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient
          Positioned(
            top: -80,
            left: -60,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.06),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 8, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amount card
                        _buildAmountCard(),
                        const SizedBox(height: 28),
                        // Payment methods
                        _buildPaymentMethodsSection(),
                        const SizedBox(height: 28),
                        // Breakdown
                        _buildBreakdownCard(),
                        const SizedBox(height: 28),
                        // Security notice
                        _buildSecurityNotice(),
                        const SizedBox(height: 40),
                        // Pay button
                        _buildPayButton(),
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withValues(alpha: 0.03), Colors.transparent],
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  'PAYMENT',
                  style: GoogleFonts.racingSansOne(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.lock_rounded, color: AppColors.accent.withValues(alpha: 0.5), size: 18),
              const SizedBox(width: 4),
              Text(
                'Secure',
                style: TextStyle(color: AppColors.accent.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildAmountCard() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      blur: 14,
      opacity: 0.08,
      color: AppColors.accent,
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      glowColor: AppColors.accent,
      glowIntensity: 0.08,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Total Amount',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            _total > 0 ? '₹${_total.toStringAsFixed(0)}' : 'FREE',
            style: GoogleFonts.racingSansOne(
              color: AppColors.accent,
              fontSize: 48,
              letterSpacing: 1,
              shadows: [
                Shadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 20),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.event.title,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PAYMENT METHOD',
          style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 12),
        _buildPaymentMethodTile(
          id: 'upi',
          icon: Icons.account_balance_rounded,
          title: 'UPI',
          subtitle: 'Google Pay, PhonePe, Paytm',
        ),
        const SizedBox(height: 10),
        _buildPaymentMethodTile(
          id: 'card',
          icon: Icons.credit_card_rounded,
          title: 'Credit / Debit Card',
          subtitle: 'Visa, Mastercard, RuPay',
        ),
        const SizedBox(height: 10),
        _buildPaymentMethodTile(
          id: 'netbanking',
          icon: Icons.account_balance_wallet_rounded,
          title: 'Net Banking',
          subtitle: 'All major banks supported',
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedMethod == id;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedMethod = id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          blur: 10,
          opacity: isSelected ? 0.10 : 0.04,
          color: isSelected ? AppColors.accent : Colors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.accent.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: isSelected ? 1.5 : 1,
          ),
          glowColor: isSelected ? AppColors.accent : null,
          glowIntensity: isSelected ? 0.05 : 0,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: isSelected ? AppColors.accent : Colors.white54, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 11),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.accent : Colors.white.withValues(alpha: 0.2),
                    width: 2,
                  ),
                  color: isSelected ? AppColors.accent : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.black, size: 14)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownCard() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          _buildBreakdownRow('Registration Fee', _regFee > 0 ? '₹${_regFee.toStringAsFixed(0)}' : 'FREE'),
          if (_regFee > 0) ...[
            const SizedBox(height: 10),
            _buildBreakdownRow('Platform Fee', '₹${_platformFee.toStringAsFixed(0)}'),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              Text(
                _total > 0 ? '₹${_total.toStringAsFixed(0)}' : 'FREE',
                style: GoogleFonts.poppins(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 13)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildSecurityNotice() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(14),
      blur: 8,
      opacity: 0.06,
      color: AppColors.accent,
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.1)),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(Icons.shield_rounded, color: AppColors.accent.withValues(alpha: 0.6), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your payment is secured with 256-bit SSL encryption. We never store your card details.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [AppColors.accent, Color(0xFFB8E62E)]),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.4),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: _isProcessing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_rounded, color: Colors.black, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    _total > 0 ? 'PAY ₹${_total.toStringAsFixed(0)}' : 'CONFIRM REGISTRATION',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    ).animate().shimmer(delay: 1.seconds, duration: 2.seconds, color: Colors.white.withValues(alpha: 0.12));
  }
}
