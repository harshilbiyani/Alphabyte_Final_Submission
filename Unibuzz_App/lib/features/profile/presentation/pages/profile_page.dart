import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';
import '../../data/mock_profile_data.dart';
import '../../../auth/presentation/pages/login_page.dart';
import 'event_history_page.dart';
import 'edit_profile_page.dart';
import 'change_password_page.dart';
import 'notification_settings_page.dart';
import 'certificates_page.dart';
import 'help_support_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Ambient Glows ──
          Positioned(
            top: -80,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.04),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              child: ParticleField(particleCount: 10, color: Colors.white, maxSize: 1.0, minSize: 0.5),
            ),
          ),

          // ── Content ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 80,
                collapsedHeight: 80,
                automaticallyImplyLeading: false,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.black.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, AppColors.primaryLight],
                        ).createShader(bounds),
                        child: Text(
                          'PROFILE',
                          style: GoogleFonts.racingSansOne(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Body
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // ── Profile Hero ──
                      _buildProfileHero(context),
                      const SizedBox(height: 24),
                      // ── Stats Row ──
                      _buildStatsRow(),
                      const SizedBox(height: 28),
                      // ── Menu Items ──
                      _buildMenuSection(context),
                      const SizedBox(height: 28),
                      // ── Logout ──
                      _buildLogoutButton(context),
                      const SizedBox(height: 120),
                    ].animate(interval: 70.ms).fade(duration: 400.ms).slideY(begin: 0.04, end: 0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  // PROFILE HERO
  // ═══════════════════════════════════════════════════
  Widget _buildProfileHero(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(28),
      blur: 14,
      opacity: 0.08,
      color: AppColors.primary,
      glowColor: AppColors.primary,
      glowIntensity: 0.12,
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar + Edit overlay
          Stack(
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.neonCyan, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.3),
                      blurRadius: 22,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Camera badge
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2.5),
                      boxShadow: [
                        BoxShadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 8),
                      ],
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: Colors.black, size: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            MockProfileData.userName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // PRN
          Text(
            'PRN: ${MockProfileData.prn}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13,
              fontFamily: 'monospace',
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          // Department pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Text(
              '${MockProfileData.department} • Div ${MockProfileData.division}',
              style: TextStyle(
                color: AppColors.primaryLight.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Interests chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: MockProfileData.interests.map((interest) {
                final emoji = _interestEmoji(interest);
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    '$emoji $interest',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _interestEmoji(String interest) {
    const map = {
      'Technical': '💻',
      'Gaming': '🎮',
      'Music': '🎵',
      'Coding': '⚡',
      'Cultural': '🎭',
      'Sports': '🏀',
      'Debate': '🗣️',
      'Art': '🎨',
      'Dance': '💃',
    };
    return map[interest] ?? '✨';
  }

  // ═══════════════════════════════════════════════════
  // STATS ROW
  // ═══════════════════════════════════════════════════
  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('Events', 12, AppColors.accent, Icons.event_rounded),
        const SizedBox(width: 10),
        _buildStatCard('Certificates', 5, AppColors.neonCyan, Icons.workspace_premium_rounded),
        const SizedBox(width: 10),
        _buildStatCard('Teams', 3, AppColors.primary, Icons.groups_rounded),
      ],
    );
  }

  Widget _buildStatCard(String label, int value, Color color, IconData icon) {
    return Expanded(
      child: GlassContainer(
        borderRadius: BorderRadius.circular(18),
        blur: 10,
        opacity: 0.06,
        color: color,
        border: Border.all(color: color.withValues(alpha: 0.2)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: color.withValues(alpha: 0.6), size: 18),
            const SizedBox(height: 6),
            Text(
              value.toString(),
              style: GoogleFonts.racingSansOne(
                color: color,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    ).animate().scaleXY(begin: 0.85, end: 1.0, duration: 500.ms, curve: Curves.easeOutBack);
  }

  // ═══════════════════════════════════════════════════
  // MENU SECTION
  // ═══════════════════════════════════════════════════
  Widget _buildMenuSection(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(22),
      blur: 12,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          _ProfileMenuTile(
            icon: Icons.history_rounded,
            iconColor: AppColors.accent,
            title: 'Event History',
            subtitle: '12 events attended',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventHistoryPage())),
          ),
          _buildMenuDivider(),
          _ProfileMenuTile(
            icon: Icons.edit_rounded,
            iconColor: AppColors.primaryLight,
            title: 'Edit Profile',
            subtitle: 'Update your info & interests',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage())),
          ),
          _buildMenuDivider(),
          _ProfileMenuTile(
            icon: Icons.lock_outline_rounded,
            iconColor: AppColors.neonCyan,
            title: 'Change Password',
            subtitle: 'Last changed 30 days ago',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePasswordPage())),
          ),
          _buildMenuDivider(),
          _ProfileMenuTile(
            icon: Icons.notifications_outlined,
            iconColor: AppColors.warning,
            title: 'Notifications',
            subtitle: '3 unread',
            showBadge: true,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationSettingsPage())),
          ),
          _buildMenuDivider(),
          _ProfileMenuTile(
            icon: Icons.workspace_premium_rounded,
            iconColor: const Color(0xFFFFD700),
            title: 'Certificates',
            subtitle: '5 certificates earned',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CertificatesPage())),
          ),
          _buildMenuDivider(),
          _ProfileMenuTile(
            icon: Icons.help_outline_rounded,
            iconColor: Colors.white54,
            title: 'Help & Support',
            subtitle: 'FAQs, contact us',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportPage())),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 58),
      child: Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
    );
  }

  // ═══════════════════════════════════════════════════
  // LOGOUT BUTTON
  // ═══════════════════════════════════════════════════
  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLogoutSheet(context),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.error.withValues(alpha: 0.08),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error.withValues(alpha: 0.8), size: 18),
            const SizedBox(width: 10),
            Text(
              'Log Out',
              style: GoogleFonts.poppins(
                color: AppColors.error.withValues(alpha: 0.9),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutSheet(BuildContext context) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D18),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.logout_rounded, color: AppColors.error, size: 28),
                ),
                const SizedBox(height: 16),
                Text(
                  'Log Out?',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  'Are you sure you want to log out of your account?',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    // Cancel
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Logout
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text('Log Out', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// PROFILE MENU TILE (private widget)
// ═══════════════════════════════════════════════════
class _ProfileMenuTile extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool showBadge;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.showBadge = false,
    required this.onTap,
  });

  @override
  State<_ProfileMenuTile> createState() => _ProfileMenuTileState();
}

class _ProfileMenuTileState extends State<_ProfileMenuTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticFeedback.selectionClick();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        color: _pressed ? Colors.white.withValues(alpha: 0.03) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: widget.iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(widget.icon, color: widget.iconColor, size: 19),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      if (widget.showBadge) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: AppColors.error.withValues(alpha: 0.5), blurRadius: 4)],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.2), size: 20),
          ],
        ),
      ),
    );
  }
}
