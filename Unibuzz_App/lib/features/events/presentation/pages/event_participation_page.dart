import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/data/mock_home_data.dart';

class EventParticipationPage extends StatefulWidget {
  final EventModel event;

  const EventParticipationPage({super.key, required this.event});

  @override
  State<EventParticipationPage> createState() => _EventParticipationPageState();
}

class _EventParticipationPageState extends State<EventParticipationPage> {
  bool _isLoading = false;
  bool _isSuccess = false;

  void _confirmParticipation() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
      
      // Auto close after success
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
           Navigator.pop(context);
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('Participation Confirmed! 🎉'),
               backgroundColor: AppColors.accent,
             ),
           );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.2),
                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 100)],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildEventSummaryCard(),
                        const SizedBox(height: 24),
                        _buildParticipantDetails(),
                        const SizedBox(height: 24),
                        _buildConfirmationNotice(),
                        const SizedBox(height: 40),
                        _buildCTAButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_isSuccess) _buildSuccessOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          Text(
            'CONFIRM PARTICIPATION',
            style: GoogleFonts.racingSansOne(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventSummaryCard() {
    return GlassContainer.frostedGlass(
      height: 120,
      width: double.infinity,
      borderRadius: BorderRadius.circular(20),
      borderColor: AppColors.primary.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.event.imageUrl,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.event.date,
                    style: TextStyle(
                      color: AppColors.accent.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                   Row(
                    children: const [
                       Icon(Icons.location_on, size: 12, color: Colors.white54),
                       SizedBox(width: 4),
                       Text(
                        "Main Auditorium",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _buildParticipantDetails() {
    // Mock user data - in real app, fetch from Supabase
    final details = {
      'Full Name': 'Ansh D',
      'PRN': '1032210899',
      'Department': 'Computer Science',
      'Year': 'Third Year',
      'Email': 'anshd@college.edu',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR DETAILS',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
               ...details.entries.map((e) => _buildDetailRow(e.key, e.value)).toList(),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.lock_outline, size: 12, color: AppColors.accent.withOpacity(0.5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationNotice() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: const [
          Icon(Icons.info_outline, color: AppColors.primary, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your details will be used for event registration and attendance tracking.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _confirmParticipation,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
              )
            : const Text(
                'CONFIRM & PARTICIPATE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    ).animate().shimmer(delay: 1.seconds, duration: 2.seconds);
  }

  Widget _buildSuccessOverlay() {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.black, size: 40),
            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
            const SizedBox(height: 20),
            Text(
              "You're in! 🎉",
              style: GoogleFonts.racingSansOne(
                color: Colors.white,
                fontSize: 32,
              ),
            ).animate().fadeIn().slideY(begin: 0.5, end: 0),
            const SizedBox(height: 10),
            const Text(
              "See you at the event.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ).animate().fadeIn(delay: 200.ms),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
