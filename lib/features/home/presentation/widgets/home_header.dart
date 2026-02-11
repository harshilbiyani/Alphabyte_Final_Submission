import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../notifications/presentation/pages/notification_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // We use a ClipRRect with BackdropFilter for the glass effect in the status bar area
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      floating: false,
      expandedHeight: 80.0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: const FlexibleSpaceBar(
              background: SizedBox(), // Keep it simple
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Image.asset(
            'assets/images/unibuzz_logo.png',
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
               // Fallback to text if asset fails to load dev-side
               return Text(
                 'UniBuzz',
                 style: GoogleFonts.racingSansOne(
                   fontSize: 28, 
                   color: Colors.white,
                 ),
               );
            },
          ),
          
          // Action Icons
          Row(
            children: [
              _buildIconButton(context, Icons.notifications_none_rounded, isNotification: true),
              const SizedBox(width: 12),
              _buildProfileAvatar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, {bool isNotification = false}) {
    return GestureDetector(
      onTap: () {
        if (isNotification) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationPage()),
          );
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (isNotification)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8, 
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC6FF33),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
