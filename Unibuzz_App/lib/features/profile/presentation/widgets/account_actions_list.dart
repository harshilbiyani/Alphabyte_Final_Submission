import 'package:flutter/material.dart';
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
          const Text(
            "Account",
            style: TextStyle(
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
        style: TextStyle(
          color: color ?? Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.2)),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.white.withValues(alpha: 0.05), indent: 50);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
