import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../features/auth/presentation/pages/login_page.dart';

class AccountActionsList extends StatelessWidget {
  const AccountActionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GlassContainer(
            borderRadius: BorderRadius.circular(16),
            blur: 10,
            opacity: 0.08,
            color: Colors.white,
            child: Column(
              children: [
                _buildActionTile(Icons.person_outline, "Edit Profile", onTap: () {}),
                _buildDivider(),
                _buildActionTile(Icons.lock_outline, "Change Password", onTap: () {}),
                _buildDivider(),
                _buildActionTile(Icons.notifications_outlined, "Notifications", onTap: () {}),
                _buildDivider(),
                _buildActionTile(Icons.help_outline, "Help & Support", onTap: () {}),
                _buildDivider(),
                _buildActionTile(
                  Icons.logout,
                  "Logout",
                  color: Colors.redAccent,
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title,
      {Color? color, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color ?? Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.2)),
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.white.withValues(alpha: 0.05), indent: 50);
  }

  void _showLogoutDialog(BuildContext context) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: AlertDialog(
          backgroundColor: const Color(0xFF1A1A2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
          title: Text("Logout", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text(
            "Are you sure you want to logout?",
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.white54)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Logout", style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
