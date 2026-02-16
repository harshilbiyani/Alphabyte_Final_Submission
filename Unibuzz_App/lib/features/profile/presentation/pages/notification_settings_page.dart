import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/particle_field.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _eventReminders = true;
  bool _teamUpdates = true;
  bool _announcements = true;
  bool _registrationAlerts = true;
  bool _emailNotifications = false;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -50,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.warning.withValues(alpha: 0.06),
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
                        const SizedBox(height: 8),
                        // Bell icon
                        _buildBellIcon(),
                        const SizedBox(height: 28),
                        // Event notifications
                        _buildSectionLabel('EVENT NOTIFICATIONS'),
                        const SizedBox(height: 10),
                        _buildToggleGroup([
                          _ToggleItem('Event Reminders', 'Get notified before events start', Icons.alarm_rounded, _eventReminders, (v) => setState(() => _eventReminders = v)),
                          _ToggleItem('Team Updates', 'When teammates join or leave', Icons.groups_rounded, _teamUpdates, (v) => setState(() => _teamUpdates = v)),
                          _ToggleItem('Announcements', 'Important campus announcements', Icons.campaign_rounded, _announcements, (v) => setState(() => _announcements = v)),
                          _ToggleItem('Registration Alerts', 'Confirmation & updates', Icons.how_to_reg_rounded, _registrationAlerts, (v) => setState(() => _registrationAlerts = v)),
                        ]),
                        const SizedBox(height: 28),
                        // Delivery
                        _buildSectionLabel('DELIVERY METHOD'),
                        const SizedBox(height: 10),
                        _buildToggleGroup([
                          _ToggleItem('Push Notifications', 'Receive alerts on your device', Icons.notifications_active_rounded, _pushNotifications, (v) => setState(() => _pushNotifications = v)),
                          _ToggleItem('Email Notifications', 'Receive alerts via email', Icons.email_rounded, _emailNotifications, (v) => setState(() => _emailNotifications = v)),
                        ]),
                        const SizedBox(height: 100),
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
              colors: [Colors.white, AppColors.warning],
            ).createShader(bounds),
            child: Text(
              'NOTIFICATIONS',
              style: GoogleFonts.racingSansOne(color: Colors.white, fontSize: 20, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildBellIcon() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.warning.withValues(alpha: 0.15)),
        ),
        child: Icon(Icons.notifications_rounded, color: AppColors.warning, size: 40),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  Widget _buildToggleGroup(List<_ToggleItem> items) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: 0.05,
      color: Colors.white,
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.icon, color: AppColors.warning.withValues(alpha: 0.6), size: 18),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 1),
                          Text(item.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.35), fontSize: 11)),
                        ],
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: item.value,
                        onChanged: (v) {
                          HapticFeedback.selectionClick();
                          item.onChanged(v);
                        },
                        activeThumbColor: AppColors.accent,
                        activeTrackColor: AppColors.accent.withValues(alpha: 0.3),
                        inactiveThumbColor: Colors.white30,
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < items.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 58),
                  child: Divider(height: 1, color: Colors.white.withValues(alpha: 0.04)),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _ToggleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  _ToggleItem(this.title, this.subtitle, this.icon, this.value, this.onChanged);
}
